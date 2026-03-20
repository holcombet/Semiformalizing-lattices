import Mathlib.Order.Basic
import Mathlib.Order.Antichain
import Mathlib.Order.Ideal
import Mathlib.Order.Hom.Basic
import Mathlib.Order.UpperLower.Basic
import Mathlib.CategoryTheory.Category.Basic



variable {α β : Type*}  --{π : ι → Type*}



-- with typeclasses declared in the statement
theorem exercise_1_7 [PartialOrder α] {a₁ a₂ b₁ b₂ : α} :
  (a₁, b₁) ⋖ (a₂, b₂) ↔ (a₁ = a₂ ∧ b₁ ⋖ b₂) ∨ (a₁ ⋖ a₂ ∧ b₁ = b₂) := by
    constructor
    . intro h
      sorry
    . intro h
      sorry



/-
Show that ϕ: P → Q is order-preserving if and only if
ϕ−1(A) is a down-set in P whenever A is a down-set in Q.
-/
theorem exercise_1_24_i [PartialOrder α] [PartialOrder β] (φ : α → β) :
  Monotone φ ↔ ∀ A : LowerSet β, IsLowerSet (φ ⁻¹' (A : Set β)) :=
  by
    sorry

theorem exercise_1_24_ii_a [PartialOrder α] [PartialOrder β]
    (φ : α → β) (preimage : LowerSet β → LowerSet α) :
  (∃ e : α ↪o β, e.toFun = φ) ↔ Function.Surjective preimage :=
  by
    sorry


theorem exercise_1_24_ii_b [PartialOrder α] [PartialOrder β] (φ : α → β)
  (preimage : LowerSet β → LowerSet α) : Function.Surjective φ ↔ Function.Injective preimage :=
  by
    sorry


def exercise_1_26 {P Q R : Type*} [PartialOrder P] [PartialOrder Q] [PartialOrder R] :
  (P →o (Q →o R)) ≃o ((P × Q) →o R) :=
by
  sorry
