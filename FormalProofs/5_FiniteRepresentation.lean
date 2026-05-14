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

variable {L K P Q B : Type*}


/--
Let L be a lattice with a least element 0.
Then 0 ⋖ x in L implies x ∈ J(L)
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
Let L be a lattice with a least element 0.
Then if L is a Boolean lattice, x ∈ J(L) implies 0 ⋖ x.
-/
lemma lemma_5_3_ii [BooleanAlgebra L] (x : L) :
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
Let B be a finite Boolean lattice. Then, for each a ∈ B,
a = ⋁ {x ∈ A(B) | x ≤ a}.
-/
lemma lemma_5_4 [CompleteBooleanAlgebra B] [IsAtomistic B] [Finite B] (a : B) :
  a = sSup { x | IsAtom x ∧ x ≤ a} := by
    rw [sSup_atoms_le_eq a]

/-
The following was written by PantherAI for theorem_5_4.
It is TERRIBLE. Keeping it commented as an example of other LLM's attempts at lean4 proofs.
Especially since the proof is one line long (basically trivial)

theorem theorem_5_4 [BooleanAlgebra B] :
  Nonempty (B ≃o {I : Order.Ideal B // SupIrred (I : Set B)}) := by
  sorry
-/


-- S.toFinite.toFinset.sup is the finite sSup (otherwise would need to assume complete BA)
/-- The representation theorem for finite Boolean algebras. -/
theorem theorem_5_5 [BooleanAlgebra B] [Finite B] [IsAtomistic B]
  (η_inv : Set { x : B | IsAtom x } → B)
  (hη_inv : η_inv = fun S : Set { x : B | IsAtom x } =>
      S.toFinite.toFinset.sup (fun x : { x : B | IsAtom x } => (x : B))) :
   ∃ η : B ≃o Set { x : B | IsAtom x },
  (∀ a : B, η a = { x : { x : B | IsAtom x } | (x : B) ≤ a }) := by
    sorry



lemma corollary_5_6 [Lattice B] [OrderBot B] [OrderTop B] : List.TFAE [
  Nonempty (BooleanAlgebra B),
  Nonempty (B ≃o Set { x : B | IsAtom x }),
  ∃ n : ℕ, 2 ≤ n ∧ Nonempty (B ≃o Fin n) ] := by
    tfae_have 1 → 2 := by sorry
    tfae_have 2 → 3 := by sorry
    tfae_have 3 → 1 := by sorry
    tfae_finish


/--
Let P be a finite ordered set. Then the map ε : x ↦ ↓x is an order-isomorphism from P onto J(O(P)).
-/
theorem theorem_5_9 [PartialOrder P] [Finite P] :
  (∃ e : P ≃o Order.Ideal P, (e : P → Order.Ideal P) = Order.Ideal.principal) := by
    sorry

/--
Given a distributive lattice L, let x ∈ L with x ≠ 0 in the case that L has a zero.
Then the following are equivalent:
* x is join-irreducible
* if a,b ∈ L and x ≤ a ∨ b, then x ≤ a or x ≤ b
* for any k ∈ ℕ, if a₁, ..., aₖ ∈ L and x ≤ a₁ ∨ ... ∨ aₖ, then a ≤ aᵢ for some i (1 ≤ i ≤ k)
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


/-
Birkhof's representation theorem for finite distributive lattices.
-/
theorem theorem_5_12 [DistribLattice L] [OrderBot L] (η : L → Order.Ideal L)
  (hη : ∀ a : L, (η a : Set L) = { x : L | SupIrred x ∧ x ≤ a }) :
  ∃ e : L ≃o Order.Ideal L, e.toFun = η := by
    sorry


lemma corollary_5_13 [Lattice L] [Finite L] : List.TFAE [
  Nonempty (DistribLattice L),
  Nonempty (L ≃o Order.Ideal ({x : L | SupIrred x})),
  Nonempty (L ≃o Order.Ideal L),
  Nonempty (L ≃o LowerSet L), -- I don't know if this is correct
  ∃ n : ℕ, ∃ K : Sublattice (Set (Fin n)), Nonempty (L ≃o K)] := by
    tfae_have 1 → 2 := by sorry
    tfae_have 2 → 3 := by sorry
    tfae_have 3 → 4 := by sorry
    tfae_have 4 → 5 := by sorry
    tfae_have 5 → 1 := by sorry
    tfae_finish



-- might have to be fintype?
lemma lemma_5_18 [DistribLattice L] [Finite L] (P : Set L)
  (hp : P = { x : L | SupIrred x }) (h : L ≃o Order.Ideal P) :
  (Nonempty (BooleanAlgebra L) ↔ IsAntichain (· ≤ ·) P) ∧
  (IsChain (· ≤ ·) (Set.univ : Set L) ↔ IsChain (· ≤ ·) P) := by
    sorry




theorem theorem_5_19_i [PartialOrder P] [Finite P] [PartialOrder Q]
    (f : BoundedLatticeHom (LowerSet P) (LowerSet Q)) :
    ∃ φ : Q →o P, ∀ y : Q, IsLeast {x : P | y ∈ f (LowerSet.Iic x)} (φ y) := by
    sorry



/-
Mathematically, φ⁻¹(a) is preimage of a subset, not application of an inverse function to a.
In Lean, that distinction is exactly φ ⁻¹' (a : Set P).
-/
theorem theorem_5_19_ii [PartialOrder P] [PartialOrder Q] (φ : Q →o P) (φ_inv : P →o Q) :
    ∃ fφ : BoundedLatticeHom (LowerSet P) (LowerSet Q),
    ∀ a : LowerSet P, (fφ a : Set Q)= φ⁻¹' (a : Set P) := by
      sorry
