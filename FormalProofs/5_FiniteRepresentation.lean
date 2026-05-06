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
    sorry



-- OrderBot L means that L has a bottom element
-- lemma lemma_5_3 [Lattice L] [OrderBot L] (x : L) :
--   (⊥ ⋖ x → SupIrred x)  ∧ (SupIrred x → ⊥ ⋖ x) := by
--     constructor
--     · intro h
--       simp
      -- simp only [bot_covBy_iff] at h
      -- refine ⟨?_, ?_⟩
      -- -- `⊥ < x`, so `x` is not minimal
      -- · exact (IsAtom.bot_lt h).not_isMin
      -- -- if `b ⊔ c = x` and `b < x` then `b = ⊥`; similarly if `c < x` then `x = ⊥`, impossible
      -- · intro b c heq
      --   have hb : b ≤ x := heq.symm ▸ le_sup_left
      --   have hc : c ≤ x := heq.symm ▸ le_sup_right
      --   by_cases hb_eq : b = x
      --   · exact Or.inl hb_eq
      --   · right
      --     have b_lt : b < x := lt_of_le_of_ne hb hb_eq
      --     have b_bot : b = ⊥ := h.2 b b_lt
      --     by_cases hc_eq : c = x
      --     · exact hc_eq
      --     · have c_lt : c < x := lt_of_le_of_ne hc hc_eq
      --       have c_bot : c = ⊥ := h.2 c c_lt
      --       refine False.elim (h.ne_bot (Eq.trans (Eq.symm heq) ?_))
      --       rw [b_bot, c_bot]
      --       exact sup_bot_eq (a := (⊥ : L))
    -- · intro h
    --   -- Reverse direction fails for arbitrary lattices; e.g. a chain gives `SupIrred x` without
    --   -- `CovBy ⊥ x`. TODO: weaken the claim or add hypotheses (modularity/distributivity, etc.).
    --   sorry


-- ¬IsMin a ∧ ∀ ⦃b c⦄, b ⊔ c = a → b = a ∨ c = a
-- IsMin a = ∀ ⦃b : α⦄, b ≤ a → a ≤ b

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



lemma lemma_5_18 [DistribLattice L] [Finite L] (P : Set L)
  (hp : P = { x : L | SupIrred x }) (h : L ≃o Order.Ideal P) :
  (Nonempty (BooleanAlgebra L) ↔ IsAntichain (· ≤ ·) P) ∧
  (IsChain (· ≤ ·) (Set.univ : Set L) ↔ IsChain (· ≤ ·) P) := by
    sorry


-- theorem theorem_5_19 [PartialOrder P] [PartialOrder Q] [Finite P] [Finite Q]
--   (L : Order.Ideal P) (K : Order.Ideal Q) (f : BoundedLatticeHom L K)
--   (φf : P → Q) : φf = fun (y : Q) => min { x : P | y ∈ f (Order.Ideal.principal x) } := by
--     sorry
