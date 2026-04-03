import Mathlib.Order.Basic
import Mathlib.Order.Antichain
import Mathlib.Order.Ideal
import Mathlib.Order.Hom.Basic
import Mathlib.Order.UpperLower.Basic
import Mathlib.CategoryTheory.Category.Basic
import Mathlib.Tactic.TFAE



variable {α β P Q R: Type*}  --{π : ι → Type*}



-- "Nonempty" is needed to allow this to be a theorem rather than a def.
-- I don't know if this is the best solution, but it works.
-- other solutions are possible
theorem example_1_29_3 [PartialOrder P] (r : P → P → Prop) (s : Set P) (h : IsAntichain r s) :
    Nonempty (Order.Ideal P ≃ Set P ) := by
  sorry


-- this is a terrible proof skeleton...
-- TODO: use Order.Ideal instead of LowerSet because Order.Ideal is a bundled strictire
--       of a set with the proof that it is a lower set.
lemma lemma_1_30 [PartialOrder α] (x y : α) :
  (x ≤ y) ↔
    (({z : α | z ≤ x} ⊆ {z : α | z ≤ y}) ↔
      (∀ Q : Order.Ideal α, y ∈ Q → x ∈ Q)) := by
  constructor
  . intro h
    constructor
    . intro z lower
      simp at z
      sorry
    . intro Q y_in_Q
      sorry
  . intro z_iff_q
    sorry


-- TFAE version makes the proof much more similar to the informal proof.
-- TFAE = "the following (propositions) are equivalent"
lemma lemma_1_30' [PartialOrder P] (x y : P) : List.TFAE [x ≤ y, ({z : P | z ≤ x} ⊆ {z : P | z ≤ y}), (∀ Q : Order.Ideal P, y ∈ Q → x ∈ Q)] := by
  tfae_have 1 → 2 := by sorry
  tfae_have 2 → 3 := by sorry
  tfae_have 3 → 1 := by sorry
  tfae_finish

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
  Monotone φ ↔ ∀ A : Order.Ideal β, Order.IsIdeal (φ ⁻¹' (A : Set β)) :=
  by
    sorry


-- TODO: change LowerSet to Order.Ideal
theorem exercise_1_24_ii_a [PartialOrder α] [PartialOrder β]
    (φ : α → β) (preimage : Order.Ideal β → Order.Ideal α) :
  (∃ e : α ↪o β, e.toFun = φ) ↔ Function.Surjective preimage :=
  by
    sorry

-- TODO: change LowerSet to Order.Ideal
theorem exercise_1_24_ii_b [PartialOrder α] [PartialOrder β] (φ : α → β)
  (preimage : Order.Ideal β → Order.Ideal α) :
  Function.Surjective φ ↔ Function.Injective preimage := by
    sorry

def exercise_1_25_ii [PartialOrder P] : (P →o Bool)ᵒᵈ ≃o (Pᵒᵈ →o Bool) := by
  sorry

def exercise_1_26 {P Q R : Type*} [PartialOrder P] [PartialOrder Q] [PartialOrder R] :
  (P →o (Q →o R)) ≃o ((P × Q) →o R) :=
by
  sorry
