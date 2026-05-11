import Mathlib.Order.Basic
import Mathlib.Order.Ideal
import Mathlib.Order.Lattice
import Mathlib.Order.Notation
import Mathlib.Order.SetNotation
import Mathlib.Order.CompleteLattice.Basic
import Mathlib.Order.CompleteLattice.Defs
import Mathlib.Order.Hom.CompleteLattice
import Mathlib.Order.WellFounded
import Mathlib.Order.UpperLower.Basic
import Mathlib.Order.UpperLower.CompleteLattice
import Mathlib.Tactic.TFAE
import Mathlib.Order.Preorder.Chain
import Mathlib.Order.Sublattice

import Mathlib.Order.Atoms
import Mathlib.Order.CompleteBooleanAlgebra
import Mathlib.Order.Irreducible

variable {L K P Q B : Type*}

/-
TODO: Figure out which is better: Finite, Fintype, Finset, Fin, OrderBot + OrderTop, etc.
  - Finite is a typeclass that requires a proof that the set is finite.
  - Fintype is a typeclass that requires a proof that the set is finite.
  - Finset is a typeclass that requires a proof that the set is finite.
  - Fin is a typeclass that requires a proof that the set is finite.
  - OrderBot is a typeclass that requires a proof that the set has a bottom element.
  - OrderTop is a typeclass that requires a proof that the set has a top element.
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

lemma lemma_5_4 [CompleteBooleanAlgebra B] [IsAtomistic B] (a : B) :
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


/-- The representation theorem for finite Boolean algebras. -/
theorem theorem_5_5 [CompleteBooleanAlgebra B] [IsAtomistic B]
  (η : B → Set B) (ε : Set B → B)
  (hη : η = fun (c : B) => { x : B | IsAtom x ∧ x ≤ c})
  (hη_inverse : ε = fun (S : Set B) => sSup S) :
  ∃ e : B ≃o Set B, e.toFun = η := by
    sorry

lemma corollary_5_6 [Lattice B] [OrderBot B] [OrderTop B]: List.TFAE [
  Nonempty (BooleanAlgebra B),
  Nonempty (B ≃o Set { x : B | IsAtom x }),
  ∃ n : ℕ, 2 ≤ n ∧ Nonempty (B ≃o Fin n) ] := by
    tfae_have 1 → 2 := by sorry
    tfae_have 2 → 3 := by sorry
    tfae_have 3 → 1 := by sorry
    tfae_finish

/-- `Order.Ideal.principal` as a map into ideals; compare with `Ideal ≃o P` only under extra
hypotheses (e.g. distributivity / finiteness), so this remains a placeholder. -/
theorem theorem_5_9 [PartialOrder P] [Finite P] [OrderBot P] (ε : P → Order.Ideal P)
    (hε : ε = Order.Ideal.principal) :
    ∃ e : P ≃o Order.Ideal P, e.toFun = ε := by
  sorry


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



-- theorem theorem_5_19_right [PartialOrder P] [PartialOrder Q] [Finite P] [Finite Q]
--   (L : Order.Ideal P) (K : Order.Ideal Q) (f : Order.Ideal P → Order.Ideal Q)

-- not happy with this -- need to look at it again

-- theorem theorem_5_19_left [PartialOrder P] [PartialOrder Q]
