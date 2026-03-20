import Mathlib.Order.Basic
import Mathlib.Order.Lattice
import Mathlib.Order.CompleteLattice.Basic
import Mathlib.Order.CompleteLattice.Defs
import Mathlib.Order.Hom.CompleteLattice
import Mathlib.Order.WellFounded
import Mathlib.Order.UpperLower.Basic
import Mathlib.Order.UpperLower.CompleteLattice
import Mathlib.Order.Ideal

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


-- page 47
lemma lemma_2_30 [Preorder α] (S : Set α) (hInf : ∀ S : Set α, S.Nonempty →
  ∃ x, IsGLB S x) : ∀ S : Set α, BddAbove S → ∃ x, IsLUB S x := by
  sorry

-- should this be a lemma?
-- page 52
theorem lemma_2_39 [Preorder α] :
  WellFoundedGT α ↔ ∀ A : Set α, A.Nonempty → ∃ a ∈ A, IsMax a := by
  constructor
  -- the first intro was written by Cursor agent and compiles without error
  · intro h A nonempty_A
    obtain ⟨a₁, ha₁, hmin⟩ := h.wf.has_min A nonempty_A
    exact ⟨a₁, ha₁, sorry⟩
  · intro h
    sorry



-- this does not feel correct. It could definitely be improved/simplified
theorem exercise_2_6_i [Preorder α] [InfSet α] (A : Set α) (hInf : ∃ x, IsGLB A x) :
  Set.sInter ((fun a : α => (Order.Ideal.principal a : Set α)) '' A) =
    (Order.Ideal.principal (sInf A) : Set α) := by
  sorry
