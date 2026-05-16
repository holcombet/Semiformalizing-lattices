import Mathlib.Order.Basic
import Mathlib.Order.Ideal
import Mathlib.Order.Lattice
import Mathlib.Order.Notation
import Mathlib.Order.SetNotation
import Mathlib.Order.CompleteLattice.Basic
import Mathlib.Order.CompleteLattice.Defs
import Mathlib.Order.Hom.CompleteLattice
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Order
import Mathlib.Order.UpperLower.Basic
import Mathlib.Order.UpperLower.CompleteLattice
import Mathlib.Tactic.TFAE
import Mathlib.Order.Preorder.Chain
import Mathlib.Order.Sublattice

import Mathlib.Order.Atoms
import Mathlib.Order.CompleteBooleanAlgebra
import Mathlib.Order.Irreducible
import Mathlib.Order.GaloisConnection.Defs

variable {L K P Q B : Type*}

/-!
## Lemma stack for theorem 5.19 (`SemiformalProof/5_FiniteRepresentation.md`)

Assistant-led scaffolding for the Markdown lemma ladder lives in namespace `ai` (see `SemiformalProof/5_FiniteRepresentation-bridge.md`). Human-aligned chapter lemmas keep unqualified names like `lemma_5_3_i` elsewhere in this file.

The Markdown file records the lemma ladder for Stone-style dualities: Galois connections (“unit /
counit” inequalities), formulae producing adjoints from complete-lattice morphisms that preserve joins
(or, dually via `OrderDual`, meets), and finally a lemma on sendings of join-/sup-primal elements along
those adjoints.

Mathlib bundles join-preserving complete maps as `sSupHom`; the Galois partner with the semiformal
`⋁`-shape is **`rightAdjointₛSupHom`** below—the Markdown’s notation `⋀ {a | f(a) ≤ b}` is the order
dual of this construction (meet vs join; see dualisation comment in module doc).
-/

namespace ai

namespace theorem_5_19_md_lemmas

variable {α β : Type*}

/--
Informal: Between posets, two monotone maps form an adjoint pair (whenever `f a` lies below `b` in the
right-hand side if and only if `a` lies below `g b` on the left) exactly when the usual unit and
counit inequalities hold: everything is below its round-trip through the partner map in the
expected direction.

**Lemma (adjunction)** from `SemiformalProof/5_FiniteRepresentation.md`: for monotone `f,g`, being a
Mathlib Galois connection (`∀ a b, f a ≤ b ↔ a ≤ g b`; i.e. `f` lower / left and `g` upper / right)
is equivalent to unit `a ≤ g (f a)` and counit `f (g b) ≤ b`.
-/
lemma galoisConnection_iff_mono {α β : Type*} [PartialOrder α] [PartialOrder β] {f : α → β}
    {g : β → α} (mf : Monotone f) (mg : Monotone g) :
    GaloisConnection f g ↔ (∀ a : α, a ≤ g (f a)) ∧ (∀ b : β, f (g b) ≤ b) :=
  Iff.intro (fun gc ↦ ⟨gc.le_u_l, fun b ↦ gc.le_iff_le.mpr le_rfl⟩)
    fun ⟨Hu, Hl⟩ ↦ GaloisConnection.monotone_intro mg mf Hu Hl

section RightAdjointₛSupHom

variable [CompleteLattice α] [CompleteLattice β]

/--
Informal: Starting from a join-preserving map between complete lattices, form the “largest” preimage
of everything below `b`: take the join of all inputs whose image lies under `b`.

The Galois partner \(g(b)=\bigvee\{a\in\alpha \mid f(a)\le b\}\) attached to `f : α →+* β`; this matches
the `⋁`-shaped formulae appearing in Galois theory dual to the semiformal `\bigwedge` bookkeeping in
that Markdown sketch.
-/
noncomputable abbrev rightAdjointₛSupHom (f : sSupHom α β) : β → α :=
  fun b ↦ sSup { a : α | f a ≤ b }

/--
Informal: Any map that preserves arbitrary joins must preserve binary joins, hence cannot reverse
comparisons; larger inputs still map to larger outputs.
-/
lemma Monotone.sSupHom (f : sSupHom α β) : Monotone (f : α → β) :=
  fun _ _ hxy ↦ by
    nth_rw 2 [← sup_eq_right.1 hxy]
    rw [map_sup]
    exact le_sup_left

open GaloisConnection

/--
Informal: If `f` preserves suprema, then the join-of-preimages construction above is exactly the
upper/right partner in a Galois connection (`f` below `b` if and only if “you” sit below that join).

**Lemma (join-preserving homomorphism yields a right adjoint)** from the Markdown: if `f` preserves all
joins/suprema (here `sSupHom`), then adjoining `rightAdjointₛSupHom f` satisfies the Galois equivalence.
-/
lemma galoisConnection_sSupHom_rightAdjoint (f : sSupHom α β) :
    GaloisConnection (f : α → β) (rightAdjointₛSupHom f) := fun a b ↦ by
  refine ⟨fun h ↦ ?_, fun ha ↦ ?_⟩
  · exact le_sSup h
  · have mf := Monotone.sSupHom f
    have h1 := mf ha
    rw [map_sSup] at h1
    exact h1.trans (sSup_le fun _ ⟨x, hx, hxeq⟩ ↦ hxeq ▸ hx)

/--
Informal (counit): Applying `f` to that big join of candidates never overshoots `b`; the partner was
built only from values already living under `b`.

Counit \(f(\bigvee\{a:f(a)\le b\})\le b\) in the adjunction.
-/
lemma le_rightAdjointₛSupHom_map (f : sSupHom α β) (b : β) :
    f (rightAdjointₛSupHom f b) ≤ b :=
  (galoisConnection_sSupHom_rightAdjoint f).le_iff_le.mpr le_rfl

/--
Informal (unit): Each `a` sits below the join of all preimages of its image; `a` is always one of the
witnesses in that family.

Unit \(a\le\bigvee\{a': f(a')\le f(a)\}\).
-/
lemma le_rightAdjointₛSupHom_of_map (f : sSupHom α β) (a : α) : a ≤ rightAdjointₛSupHom f (f a) :=
  (galoisConnection_sSupHom_rightAdjoint f).le_iff_le.mp le_rfl

/--
Informal: The join-of-preimages rule is itself monotone in `b`: larger targets admit more admissible
inputs, so the supremum over them only grows.
-/
lemma Monotone.rightAdjointₛSupHom (f : sSupHom α β) : Monotone (rightAdjointₛSupHom f) :=
  (galoisConnection_sSupHom_rightAdjoint f).monotone_u

end RightAdjointₛSupHom

section LeftAdjointₛInfHom

variable [CompleteLattice α] [CompleteLattice β]

/--
Informal: Dually, if `f` preserves meets, take the meet of all elements whose image lies under `b`;
that is the usual left-hand partner to `f` in the same Galois pattern but with meets.

\(g(b)=\bigwedge\{a\in\alpha \mid f(a)\le b\}\) for `f : α →+* β` an `sInfHom`; matches Lemma
“(left‑adjoint)” in `SemiformalProof/5_FiniteRepresentation.md`.
-/
noncomputable abbrev leftAdjointₛInfHom (f : sInfHom α β) : β → α :=
  fun b ↦ sInf { a : α | f a ≤ b }

/--
Informal: Meet-preserving maps between complete lattices are order-preserving: if one side grows, the
meet over a larger pair cannot shrink the image.
-/
lemma Monotone.sInfHom (f : sInfHom α β) : Monotone (f : α → β) :=
  fun _ _ hxy ↦ by
    nth_rw 2 [← inf_eq_left.1 hxy]
    rw [map_inf]
    exact inf_le_left

/--
Informal: For meet-preserving `f`, the meet-of-all-elements-over-`b` construction is the Galois
upper partner: `f a ≤ b` if and only if `a` lies below that meet.
-/
lemma galoisConnection_sInfHom_leftAdjoint (f : sInfHom α β) :
    GaloisConnection (f : α → β) (leftAdjointₛInfHom f) := fun a b ↦ by
  refine ⟨fun h ↦ ?_, fun ha ↦ ?_⟩
  · exact le_sInf h
  · have mf := Monotone.sInfHom f
    have h1 := mf ha
    rw [map_sInf] at h1
    exact h1.trans (sInf_le fun _ ⟨x, hx, hxeq⟩ ↦ hxeq ▸ hx)

/--
Informal (counit direction): Feeding the meet of admissible preimages through `f` stays below `b`.
-/
lemma le_map_leftAdjointₛInfHom (f : sInfHom α β) (b : β) :
    f (leftAdjointₛInfHom f b) ≤ b :=
  (galoisConnection_sInfHom_leftAdjoint f).l_u_le b

/--
Informal (unit direction): Each `a` lies below the meet of everything mapping under `f a`.
-/
lemma le_leftAdjointₛInfHom_map (f : sInfHom α β) (a : α) : a ≤ leftAdjointₛInfHom f (f a) :=
  (galoisConnection_sInfHom_leftAdjoint f).le_iff_le.mp le_rfl

/--
Informal: The meet-of-preimages assignment grows when `b` grows (dual monotonicity to the join partner).
-/
lemma Monotone.leftAdjointₛInfHom (f : sInfHom α β) : Monotone (leftAdjointₛInfHom f) :=
  (galoisConnection_sInfHom_leftAdjoint f).monotone_u

end LeftAdjointₛInfHom

section sInfHomDual

variable [CompleteLattice α] [CompleteLattice β]

/--
Informal: Flip the orders on both sides: a meet-preserving map becomes a join-preserving map between
the dual lattices, so the “join of preimages” adjoint from the previous section applies there; this is
exactly how the semiformal draft relabels joins and meets across `(-)^op`.

**Lemma (right‑adjoint lemma, packaged on dual orders)** (`SemiformalProof/5_FiniteRepresentation.md`):
`sInfHom.dual` promotes an `⨅`-hom to a `⨆`-hom `αᵒᵈ → βᵒᵈ`; `rightAdjointₛSupHom` is then the
Galois partner on that side.
-/
lemma galoisConnection_sInfHom_dual (f : sInfHom α β) :
    GaloisConnection (sInfHom.dual f) (rightAdjointₛSupHom (sInfHom.dual f)) :=
  galoisConnection_sSupHom_rightAdjoint (sInfHom.dual f)

end sInfHomDual

/--
Informal: Sup-prime elements (non-bottom lattice elements whose “≤ union/join” dichotomy behaves like a
prime filter) pull back along the upper adjoint of a complete homomorphism: if `b` primes joins in the
codomain then `g b` primes joins in the domain.

**Lemma (join‑irred)** from the Markdown (stated for sup‑primality): if `f : A →+* B` is a complete
lattice homomorphism and `GaloisConnection f g`, then `g` sends sup‑prime elements of `B` to
sup‑prime elements of `A`.
-/
lemma supPrime_comap_of_gc_completeLatticeHom {A B : Type*} [CompleteLattice A] [CompleteLattice B]
    {f : CompleteLatticeHom A B} {g : B → A} (gc : GaloisConnection (↑f) g) {b : B}
    (hb : SupPrime b) : SupPrime (g b) := by
  refine ⟨fun hmin ↦ ?_, fun a₁ a₂ h ↦ ?_⟩
  · have gb_bot : g b = ⊥ := le_antisymm (hmin bot_le) bot_le
    have : b ≤ ⊥ := by
      calc
        b ≤ f (g b) := gc.le_u_l b
        _ = f ⊥ := by rw [gb_bot]
        _ = ⊥ := map_bot f
    exact hb.ne_bot (le_antisymm this bot_le)
  · have step1 : b ≤ f a₁ ⊔ f a₂ := by
      rw [← map_sup f]
      exact (gc.le_iff_le).mp h
    rcases hb.2 step1 with h1 | h2
    · exact Or.inl ((gc.le_iff_le).mpr h1)
    · exact Or.inr ((gc.le_iff_le).mpr h2)

end theorem_5_19_md_lemmas

end ai

/--
Informal (**lemma 5.3(i)**): In a lattice with zero, anything that covers the bottom (there is nothing
between it and zero) acts like an atom at the bottom; such elements are join-irreducible—they cannot be
written as the join of two strictly smaller pieces unless one piece is already equal to them.

Lemma: let `L` have a least element 0. If 0 is strictly below `x` with no intermediates, then `x` is
sup-irreducible (`SupIrred`).
-/
lemma lemma_5_3_i [Lattice L] [OrderBot L] (x : L) :
  (⊥ ⋖ x → SupIrred x) := by
    intro h
    constructor
    · exact not_isMin_of_lt h.lt
    · intro b c heq
      by_cases hb_eq : b = x
      · exact Or.inl hb_eq
      · right
        have hb_le : b ≤ x := le_sup_left.trans_eq heq
        have hb_lt : b < x := lt_of_le_of_ne hb_le hb_eq
        have hb_bot : b = ⊥ := by
          by_cases hbot : b = ⊥
          · exact hbot
          · exact absurd hb_lt (h.2 (lt_of_le_of_ne bot_le (Ne.symm hbot)))
        rw [hb_bot] at heq
        rw [bot_sup_eq c] at heq
        exact heq


/--
Informal (**lemma 5.3(ii)**): In a Boolean lattice, join-irreducible elements are atoms (cover ⊥).
Proof follows the semiformal case split in `SemiformalProof/5_FiniteRepresentation.md`.
-/
lemma lemma_5_3_ii [BooleanAlgebra L] (x : L) :
  SupIrred x → ⊥ ⋖ x := by
  intro h
  constructor
  · exact bot_lt_iff_ne_bot.mpr h.ne_bot
  · intro y hy_lt
    by_cases hy_eq : y = x
    · intro hyx
      rw [hy_eq] at hyx
      exact lt_irrefl x hyx
    · intro hyx
      have hy_le : y ≤ x := le_of_lt hyx
      have hy_inf_x : x ⊓ y = y := inf_eq_right.mpr hy_le
      have hxdec : x = (x ⊔ y) ⊓ (yᶜ ⊔ y) := by
        rw [compl_sup_eq_top, inf_top_eq, sup_of_le_left hy_le]
      rw [← sup_inf_right x yᶜ y] at hxdec
      rcases h.2 hxdec.symm with hy_irr | h_inf_compl
      · have h_le_compl := le_of_inf_eq hy_irr
        have h_inf_le := inf_le_inf_right y (h_le_compl)
        rw [hy_inf_x] at h_inf_le
        rw [compl_inf_eq_bot] at h_inf_le
        rw [le_bot_iff] at h_inf_le
        rw [h_inf_le] at hy_lt
        exact lt_irrefl ⊥ hy_lt
      · rw [h_inf_compl] at hy_inf_x
        rw [h_inf_compl] at hyx
        exact lt_irrefl x hyx


/--
Informal: Same statement as `lemma_5_3_ii`, earlier autoformalised proof (kept for comparison).
-/
lemma lemma_5_3_ii_auto [BooleanAlgebra L] (x : L) :
  SupIrred x → ⊥ ⋖ x := by
    intro h
    constructor
    · exact bot_lt_iff_ne_bot.mpr h.ne_bot
    · intro c hc_lt
      by_cases hc_eq : c = x
      · intro hcx
        rw [hc_eq] at hcx
        exact lt_irrefl x hcx
      · intro hcx
        have hxdec : x = (x ⊓ c) ⊔ (x ⊓ cᶜ) := by
          rw [← inf_sup_left, sup_compl_eq_top, inf_top_eq]
        have xc_eq : x ⊓ c = c := inf_eq_right.mpr hcx.le
        rw [xc_eq] at hxdec
        rcases h.2 hxdec.symm with hecq | hinfx
        · exact absurd hecq hc_eq
        · have x_le_ccompl : x ≤ cᶜ := by
            have hle := inf_le_right (a := x) (b := cᶜ)
            rwa [hinfx] at hle
          have cle : c ≤ cᶜ := hcx.le.trans x_le_ccompl
          have c_le_bot : c ≤ ⊥ := by
            rw [← inf_compl_eq_bot']
            exact le_inf le_rfl cle
          have cbot : c = ⊥ := le_antisymm c_le_bot bot_le
          rw [cbot] at hc_lt
          exact lt_irrefl ⊥ hc_lt








/--
Informal (**lemma 5.4**): In a finite atomistic Boolean algebra, every element is the join of the atoms
that lie beneath it; no “hidden” part remains below an element once all atoms under it are joined.

Formally: for each `a`, `a` equals the supremum of atoms `x` with `x ≤ a`.
-/
lemma lemma_5_4 [CompleteBooleanAlgebra B] [IsAtomistic B] [Finite B] (a : B) :
  a = sSup { x | IsAtom x ∧ x ≤ a} := by
    rw [sSup_atoms_le_eq a]

/-
Informal (**theorem 5.4**, discarded stub): Intended to relate Boolean algebras to ideals with join-
irreducible carrier; kept only as a cautionary incomplete formalisation attempt.

The following was written by PantherAI for theorem_5_4.
It is TERRIBLE. Keeping it commented as an example of other LLM's attempts at lean4 proofs.
Especially since the proof is one line long (basically trivial)

theorem theorem_5_4 [BooleanAlgebra B] :
  Nonempty (B ≃o {I : Order.Ideal B // SupIrred (I : Set B)}) := by
  sorry
-/


-- S.toFinite.toFinset.sup is the finite sSup (otherwise would need to assume complete BA)
/--
Informal (**theorem 5.5**): Finite atomistic Boolean algebras look exactly like power sets of their
atoms: pick an isomorphism `η` sending each element to the subset of atoms below it; the hypotheses pin
down the inverse `η⁻¹` as “join this finite set of atoms”.

The representation theorem for finite Boolean algebras.
-/
theorem theorem_5_5 [BooleanAlgebra B] [Finite B] [IsAtomistic B]
  (η_inv : Set { x : B | IsAtom x } → B)
  (hη_inv : η_inv = fun S : Set { x : B | IsAtom x } =>
      S.toFinite.toFinset.sup (fun x : { x : B | IsAtom x } => (x : B))) :
   ∃ η : B ≃o Set { x : B | IsAtom x },
  (∀ a : B, η a = { x : { x : B | IsAtom x } | (x : B) ≤ a }) := by
    sorry


/--
Informal (**corollary 5.6**): For a bounded lattice, having Boolean structure, being representable as a
finite power set of atoms, and being a finite chain of power-set type are all equivalent characterisations
(once packaged as the standard TFAE list).
-/
lemma corollary_5_6 [Lattice B] [OrderBot B] [OrderTop B] : List.TFAE [
  Nonempty (BooleanAlgebra B),
  Nonempty (B ≃o Set { x : B | IsAtom x }),
  ∃ n : ℕ, 2 ≤ n ∧ Nonempty (B ≃o Fin n) ] := by
    tfae_have 1 → 2 := by sorry
    tfae_have 2 → 3 := by sorry
    tfae_have 3 → 1 := by sorry
    tfae_finish


/--
Informal (**theorem 5.9**): On a finite poset, sending an element to its principal down-set embeds the
poset order-isomorphically into the join-irreducible lower sets of the lattice of all down-sets (the
“points” inside the order of down-sets).

Let `P` be finite. Then `x ↦ ↓x` is an order-isomorphism from `P` onto the sup-irreducible lower sets
in `LowerSet P`.
-/
theorem theorem_5_9 [PartialOrder P] [Finite P] :
  ∃ e : P ≃o {x : LowerSet P | SupIrred x},
  ∀ x : P, (e x : {x : LowerSet P | SupIrred x}) = LowerSet.Iic x := by
    sorry

/--
Informal (**lemma 5.11**): In a distributive lattice with bottom, for any non-bottom `x`, being
join-irreducible, being join-prime (joins respect `x` like a prime ideal), and a finite version of that
prime property over `k`-ary joins are all the same thing.

Given a distributive lattice `L` and `x ≠ ⊥`, the following are equivalent:
* `x` is join-irreducible
* if `a,b ∈ L` and `x ≤ a ⊔ b`, then `x ≤ a` or `x ≤ b`
* for any `k : ℕ` and `a : Fin k → L`, if `x ≤` the join of the `a i`, then `x ≤ a i` for some `i`
-/
lemma lemma_5_11 [DistribLattice L] [OrderBot L] (x : L) (h : x ≠ ⊥) :
  List.TFAE
    [ SupIrred x,
      SupPrime x,
      (∀ k : ℕ, ∀ a : Fin k → L, x ≤ Finset.univ.sup a → ∃ i : Fin k, x ≤ a i) ] := by
    tfae_have 1 → 2 := by
      apply supPrime_iff_supIrred.mpr
    tfae_have 2 → 3 := by sorry
    tfae_have 3 → 1 := by sorry
    tfae_finish


/--
Informal (**theorem 5.12**, Birkhoff-style representation): A distributive lattice with bottom embeds into
the lattice of lower subsets of its join-irreducibles by sending `a` to `{ irreducible x | x ≤ a }`; the
formal conclusion packages this as an order isomorphism onto `LowerSet` of that subtype.

Related to Birkhoff's theorem for finite distributive lattices in the semiformal outline.
-/
theorem theorem_5_12 [DistribLattice L] [OrderBot L] :
  ∃ η : L ≃o LowerSet ({x : L | SupIrred x}), ∀ a : L,
  (η a : Set {x : L | SupIrred x}) = { x : L | SupIrred x ∧ x ≤ a } := by
    sorry


/--
Informal (**corollary 5.13**): For finite lattices, several naive “looks like subsets of something finite”
template properties—distributivity, isomorphism to lower-set lattices, power-set shaped sublattices—are
packaged as one TFAE chain.
-/
lemma corollary_5_13 [Lattice L] [Finite L] : List.TFAE [
  Nonempty (DistribLattice L),
  Nonempty (L ≃o LowerSet ({x : L | SupIrred x})),
  Nonempty (L ≃o LowerSet L),
  Nonempty (L ≃o Set L),
  ∃ n : ℕ, ∃ K : Sublattice (Set (Fin n)), Nonempty (L ≃o K)] := by
    tfae_have 1 → 2 := by sorry
    tfae_have 2 → 3 := by sorry
    tfae_have 3 → 4 := by sorry
    tfae_have 4 → 5 := by sorry
    tfae_have 5 → 1 := by sorry
    tfae_finish


/--
Informal (**lemma 5.18**): When a finite distributive lattice is presented as lower sets on its
irreducibles, being Boolean is the same as those irreducibles forming an antichain, and being totally
ordered as a lattice matches the irreducibles lying in a chain.
-/
lemma lemma_5_18 [DistribLattice L] [Finite L] (P : Set L)
  (hp : P = { x : L | SupIrred x }) (h : L ≃o LowerSet P) :
  (Nonempty (BooleanAlgebra L) ↔ IsAntichain (· ≤ ·) P) ∧
  (IsChain (· ≤ ·) (Set.univ : Set L) ↔ IsChain (· ≤ ·) P) := by
    sorry


/--
Informal (**theorem 5.19(1)**): For finite posets `P` and `Q`, any bounded lattice homomorphism between
down-set lattices comes from a monotone map on points: there is an order-preserving `φ : Q → P` that, at
each `y`, picks the least element `x` whose principal down-set is large enough for `y` to land in the
image down-set `f(↓x)`.

Formally: given `f` between `LowerSet P` and `LowerSet Q`, obtain `φ : Q →o P` so that for every `y`,
`φ y` is the least `x` with `y ∈ f (LowerSet.Iic x)`.
-/
theorem theorem_5_19_i [PartialOrder P] [Finite P] [PartialOrder Q]
    (f : BoundedLatticeHom (LowerSet P) (LowerSet Q)) :
    ∃ φ : Q →o P, ∀ y : Q, IsLeast {x : P | y ∈ f (LowerSet.Iic x)} (φ y) := by
    /-
    Proof strategy (MCP `lean_goal` on the `sorry` line and Mathlib search):
    * By `LowerSet.Iic_le`, for any `L : LowerSet Q` and `y : Q` we have `y ∈ L ↔ LowerSet.Iic y ≤ L`,
      so the witnessing set is `{x | LowerSet.Iic y ≤ f (LowerSet.Iic x)}` (semiformal ⋀ of such `x`).
    * `LowerSet P`, `LowerSet Q` are finite complete lattices when `P` is finite (only finitely many lower
      sets); one extends `f` to an `sSupHom` / `CompleteLatticeHom`, takes the Galois right adjoint,
      and matches principal lower sets via `OrderIso.supIrredLowerSet` from `Mathlib.Order.Birkhoff`
      (compare `LowerSet.supIrred_iff_of_finite`: sup-irreducible lower sets are principal `Iic a`).
    -/
    -- TODO: complete this proof
    sorry


/--
Informal (**theorem 5.19(2)**): From monotone data on points you recover a homomorphism on down-sets by
“pull back along `φ`”: declare `fφ(a)` to be those `y : Q` with `φ y ∈ a`. The extra map `φ_inv`
matches the semiformal symmetry clause (Lean still records both directions even though only `φ`
appears in the preimage formula). Mathematically “`φ⁻¹(a)`” means subset preimage `φ ⁻¹' a`, not inverse
function application; Lean writes that as `φ ⁻¹' (a : Set P)`.
-/
theorem theorem_5_19_ii [PartialOrder P] [PartialOrder Q] (φ : Q →o P) (φ_inv : P →o Q) :
    ∃ fφ : BoundedLatticeHom (LowerSet P) (LowerSet Q),
    ∀ a : LowerSet P, (fφ a : Set Q)= φ⁻¹' (a : Set P) := by
      sorry
