import Mathlib.Data.Set.Image
import Mathlib.Order.Bounds.Basic
import Mathlib.Order.CompleteLattice.Basic
import Mathlib.Order.CompleteLattice.Defs
import Mathlib.Order.Hom.CompleteLattice
import Mathlib.Order.Closure
import Mathlib.Order.GaloisConnection.Basic
import Mathlib.Order.GaloisConnection.Defs
import Mathlib.Order.Directed
import FormalProofs.«2_Lattices»

variable {P Q : Type*}



lemma proposition_7_2_i [PartialOrder P] [OrderTop P] {c : ClosureOperator P}
  (pc : Set P) (hpc : pc = Set.range c) :
  ∀ x, c x ∈ pc ∧ ⊤ ∈ pc := by
 sorry

lemma proposition_7_2_ii_a [CompleteLattice P] {c : ClosureOperator P} (x : P)
  (pc : Set P) (hpc : pc = Set.range c) :
  c x = sInf {y ∈ pc | x ≤ y} := by
  sorry

namespace proposition_7_2_ii

variable [CompleteLattice P] {c : ClosureOperator P}

private def sInfClosed (S : Set c.Closeds) : c.Closeds :=
  ⟨sInf (Subtype.val '' S), c.sInf_isClosed fun x hx => by
    rw [Set.mem_image] at hx
    rcases hx with ⟨y, hy, rfl⟩
    exact y.2⟩

private def sSupClosed (S : Set c.Closeds) : c.Closeds :=
  ⟨c (sSup (Subtype.val '' S)), c.isClosed_closure _⟩

private lemma isGLB_sInf_closeds (S : Set c.Closeds) : IsGLB S (sInfClosed S) := by
  rw [IsGLB, IsGreatest]
  constructor
  · intro z hz
    rw [Subtype.mk_le_mk, sInfClosed]
    exact sInf_le (Set.mem_image_of_mem _ hz)
  · intro w hw
    rw [mem_lowerBounds] at hw
    rw [Subtype.mk_le_mk, sInfClosed]
    apply le_sInf
    intro b hb
    rw [Set.mem_image] at hb
    rcases hb with ⟨z, hz, rfl⟩
    simpa [Subtype.mk_le_mk] using hw z hz

private lemma isLUB_sSup_closeds (S : Set c.Closeds) : IsLUB S (sSupClosed S) := by
  rw [IsLUB, IsLeast]
  constructor
  · intro z hz
    rw [Subtype.mk_le_mk, sSupClosed]
    calc
      (z : P) = c (z : P) := z.2.closure_eq.symm
      _ ≤ c (sSup (Subtype.val '' S)) := c.monotone (le_sSup (Set.mem_image_of_mem _ hz))
  · intro w hw
    rw [mem_upperBounds] at hw
    rw [Subtype.mk_le_mk, sSupClosed]
    calc
      c (sSup (Subtype.val '' S)) ≤ c (↑w) :=
        c.monotone <| sSup_le fun x hx => by
          rw [Set.mem_image] at hx
          rcases hx with ⟨z, hz, rfl⟩
          simpa [Subtype.mk_le_mk] using hw z hz
      _ = ↑w := w.2.closure_eq

noncomputable instance instInfSet : InfSet c.Closeds where
  sInf := sInfClosed

noncomputable instance instSupSet : SupSet c.Closeds where
  sSup := sSupClosed

end proposition_7_2_ii

/-- $P_c =$ `c.Closeds` is a complete lattice (inherited order). -/
noncomputable instance closedCompleteLattice [CompleteLattice P] (c : ClosureOperator P) :
    CompleteLattice c.Closeds :=
  { completeLatticeOfInf c.Closeds (proposition_7_2_ii.isGLB_sInf_closeds (c := c)) with
    sup a b := ⟨c (a.1 ⊔ b.1), c.isClosed_closure _⟩
    le_sup_left a b := by
      rw [Subtype.mk_le_mk]
      calc
        (a : P) ≤ a.1 ⊔ b.1 := le_sup_left
        _ ≤ c (a.1 ⊔ b.1) := c.le_closure _
    le_sup_right a b := by
      rw [Subtype.mk_le_mk]
      calc
        (b : P) ≤ a.1 ⊔ b.1 := le_sup_right
        _ ≤ c (a.1 ⊔ b.1) := c.le_closure _
    sup_le a b w hwa hwb := by
      rw [Subtype.mk_le_mk] at hwa hwb ⊢
      calc
        c (↑a ⊔ ↑b) ≤ c (↑w) := c.monotone (sup_le hwa hwb)
        _ = ↑w := w.2.closure_eq
    sSup := proposition_7_2_ii.sSupClosed (c := c)
    isLUB_sSup S := proposition_7_2_ii.isLUB_sSup_closeds (c := c) S
    top := ⟨⊤, c.isClosed_top⟩
    le_top a := by
      rw [Subtype.mk_le_mk]
      exact OrderTop.le_top _
    bot := ⟨c ⊥, c.isClosed_closure _⟩
    bot_le a := by
      rw [Subtype.mk_le_mk]
      calc
        c ⊥ ≤ c (a : P) := c.monotone bot_le
        _ = (a : P) := a.2.closure_eq }

/-- Meet and join in $P_c$: $\bigwedge_{P_c} S = \bigwedge_P S$, $\bigvee_{P_c} S = c(\bigvee_P S)$. -/
lemma proposition_7_2_ii_b [CompleteLattice P] (c : ClosureOperator P) (S : Set c.Closeds) :
    (↑(sInf S) : P) = sInf (Subtype.val '' S) ∧
    (↑(sSup S) : P) = c (sSup (Subtype.val '' S)) := by
  sorry


/-- If `C` is a closure operator on `Set X`, then the family `L_C = {A | C A = A}` of closed sets
    is a topped `⋂`-structure and hence a complete lattice under inclusion, with
    `⨅_{i ∈ I} A_i = ⋂_{i ∈ I} A_i` and `⨆_{i ∈ I} A_i = C (⋃_{i ∈ I} A_i)`. -/
theorem theorem_7_3_a {X : Type*} (C : ClosureOperator (Set X)) :
    C.IsClosed Set.univ ∧
    (∀ S : Set (Set X), (∀ A ∈ S, C.IsClosed A) → C.IsClosed (sInf S)) ∧
    (∃ _ : CompleteLattice C.Closeds,
      (∀ S : Set C.Closeds, (↑(sInf S) : Set X) = sInf (Subtype.val '' S)) ∧
      (∀ S : Set C.Closeds, (↑(sSup S) : Set X) = C (sSup (Subtype.val '' S)))) := by
  -- Strategy: (i) topped ∩-structure via `C.isClosed_top` and `C.sInf_isClosed`;
  -- (ii) complete lattice on `C.Closeds` via `completeLatticeOfInf` and the GLB property of `sInf`;
  -- (iii) meet/join on carriers via `sInf_image'` and `ClosureOperator.closure_iSup_closure`.
  sorry
