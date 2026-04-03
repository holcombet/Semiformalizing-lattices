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

import Mathlib.Order.Irreducible



variable {L K P B : Type*}


-- OrderBot L means that L has a bottom element
lemma lemma_5_3_i [Lattice L] [OrderBot L] (x : L) : ⊥ ⋖ x → SupIrred x := by
  sorry


lemma lemma_5_3_ii [Lattice L] [OrderBot L] (x : L) (h : BooleanAlgebra L) : SupIrred x → ⊥ ⋖ x := by
  sorry

-- partially written by PantherAI (Sonnet 4.5)
-- not sure if it will work out when proving...
theorem theorem_5_4 [BooleanAlgebra B] :
  Nonempty (B ≃o {I : Order.Ideal B // SupIrred (I : Set B)}) := by
  sorry
