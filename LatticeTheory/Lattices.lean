import Mathlib.Order.Basic
import Mathlib.Order.Lattice
import Mathlib.Order.CompleteLattice.Basic
import Mathlib.Order.CompleteLattice.Defs
import Mathlib.Order.Hom.CompleteLattice
import Mathlib.Order.WellFounded

variable {α β : Type*}




/- I don't know which one is better, assuming either is correct at all -/
theorem proposition_2_19_ii [Lattice α] [Lattice β] (f : α → β) :
  (∃ e : α ≃o β, e.toFun = f) ↔
  ((Function.Bijective f) ∧
    (∀ x y, f (x ⊓ y) = f x ⊓ f y) ∧
    (∀ x y, f (x ⊔ y) = f x ⊔ f y)) := by
  sorry


theorem proposition_2_19_ii' [Lattice α] [Lattice β] (f : α → β) :
  Function.Bijective f ↔ ∃ e : α ≃o β, e.toFun = f := by
  sorry


theorem lemma_2_39 [Preorder α] :
  WellFoundedGT α ↔ ∀ A : Set α, A.Nonempty → ∃ a ∈ A, IsMax a := by
  sorry

-- theorem exercise_2_6_i [Preorder α] (A : Set α) := by sorry
