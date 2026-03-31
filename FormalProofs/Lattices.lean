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

variable {α β L K P : Type*}


lemma lemma_2_8 [Lattice L] (a b : L) : List.TFAE [a ≤ b, a ⊔ b = b, a ⊓ b = a] := by
  tfae_have 1 → 2 := by sorry
  tfae_have 2 → 3 := by sorry
  tfae_have 3 → 1 := by sorry
  tfae_finish


-- Cursor agent wrote this proof (it compiles)
theorem proposition_2_19_i [Lattice L] [Lattice K] (f : L → K) :
  List.TFAE [Monotone f, (∀ a b, f (a ⊓ b) = f a ⊓ f b), (∀ a b, f (a ⊔ b) = f a ⊔ f b)] := by
  tfae_have 1 → 2 := by sorry
  tfae_have 2 → 3 := by sorry
  tfae_have 3 → 1 := by sorry
  tfae_finish

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


-- cursor agent wrote this proof (it compiles)
lemma lemma_2_22_i [PartialOrder P] (S : Set P)
  (sSupS : P) (hsSupS : IsLUB S sSupS)
  (sInfS : P) (hsInfS : IsGLB S sInfS) :
  ∀ s : S, s ≤ sSupS ∧ s ≥ sInfS := by
  intro s
  apply And.intro
  · apply hsSupS.1
    simp
  · apply hsInfS.1
    simp



lemma lemma_2_22_ii [PartialOrder P] (S : Set P) (x : P)
  (sSupS : P) (hsSupS : IsLUB S sSupS)
  (sInfS : P) (hsInfS : IsGLB S sInfS) :
  x ≤ sInfS ↔ ∀ s : S, x ≤ s := by
  constructor
  · intro h s
    sorry
  · intro h
    sorry



lemma lemma_2_22_iii [PartialOrder P] (S : Set P) (x : P)
  (sSupS : P) (hsSupS : IsLUB S sSupS)
  (sInfS : P) (hsInfS : IsGLB S sInfS) :
  x ≥ sSupS ↔ ∀ s : S, x ≥ s := by
  sorry

lemma lemma_2_22_iv [PartialOrder P] (S T : Set P)
  (sSupS : P) (hsSupS : IsLUB S sSupS)
  (sInfS : P) (hsInfS : IsGLB S sInfS)
  (sSupT : P) (hsSupT : IsLUB T sSupT)
  (sInfT : P) (hsInfT : IsGLB T sInfT) :
  sSupS ≤ sSupT ↔ ∀ s t, s ∈ S → t ∈ T → s ≤ t := by
  -- idk if this is correct for declaring ∀ for two variables
  sorry


lemma lemma_2_22_v [PartialOrder P] (S T : Set P)
  (sSupS : P) (hsSupS : IsLUB S sSupS)
  (sInfS : P) (hsInfS : IsGLB S sInfS)
  (sSupT : P) (hsSupT : IsLUB T sSupT)
  (sInfT : P) (hsInfT : IsGLB T sInfT) :
  S ⊆ T → sSupS ≤ sSupT ∧ sInfS ≥ sInfT := by
  sorry




lemma lemma_2_24 [Lattice P] (F : Set P) :
  Nonempty F → (∃ sup, IsLUB F sup) ∧  (∃ inf, IsGLB F inf) := by
  sorry



-- page 47
lemma lemma_2_30 [PartialOrder P] (S : Set P) (hInf : ∀ S : Set P, S.Nonempty →
  ∃ x, IsGLB S x) : ∀ S : Set P, BddAbove S → ∃ x, IsLUB S x := by
  sorry


theorem theorem_2_31 [PartialOrder P] :
    List.TFAE
      [Nonempty (CompleteLattice P),
        ∀ S : Set P, ∃ x, IsLUB S x,
        (∃ t : P, ∀ y, y ≤ t) ∧ ∀ S : Set P, S.Nonempty → ∃ x, IsGLB S x] := by
  tfae_have 1 → 2 := by sorry
  tfae_have 2 → 3 := by sorry
  tfae_have 3 → 1 := by sorry
  tfae_finish

-- should this be a lemma?
-- page 52
theorem lemma_2_39 [PartialOrder P] :
  WellFoundedGT P ↔ ∀ A : Set P, A.Nonempty → ∃ a ∈ A, IsMax a := by
  constructor
  -- the first intro was written by Cursor agent and compiles without error
  · intro h A nonempty_A
    obtain ⟨a₁, ha₁, hmin⟩ := h.wf.has_min A nonempty_A
    exact ⟨a₁, ha₁, sorry⟩
  · intro h
    sorry



-- this does not feel correct. It could definitely be improved/simplified
theorem exercise_2_6_i [PartialOrder P] [InfSet P] (A : Set P) (hInf : ∃ x, IsGLB A x) :
  Set.sInter ((fun a : P => (Order.Ideal.principal a : Set P)) '' A) =
    (Order.Ideal.principal (sInf A) : Set P) := by
  sorry


theorem exercise_2_11 [Lattice L] :
    List.TFAE
      [IsChain (· ≤ ·) (Set.univ : Set L), -- Cursor wrote this line
        ∀ S : Set L, S.Nonempty → IsSublattice S,
        ∀ a b : Set L, IsSublattice (a ∪ b)] := by
  sorry


-- Cursor fixed the proof statement and proved it
theorem exercise_2_19_i [Lattice L] [Lattice K] (S : Sublattice L) (M : L) (f : LatticeHom L K)
    (hM : M ∈ S) : f M ∈ S.map f :=
  S.mem_map_of_mem f hM


-- theorem exercise_2_19_ii [Lattice L] [Lattice K] (S : Sublattice K) (N : K) (f : LatticeHom L K)
--     (hN : N ∈ S) : N ∈ S.comap f :=
--   S.mem_comap.mpr hN
