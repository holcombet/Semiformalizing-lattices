import Mathlib.Data.Set.Image
import Mathlib.Order.Bounds.Basic
import Mathlib.Order.CompleteLattice.Basic
import Mathlib.Order.CompleteLattice.Defs
import Mathlib.Order.Hom.CompleteLattice
import Mathlib.Order.Closure
import Mathlib.Order.GaloisConnection.Basic
import Mathlib.Order.GaloisConnection.Defs
import Mathlib.Order.Directed
import Mathlib.Order.CompactlyGenerated.Basic
import FormalProofs.«2_Lattices»



variable {P Q L X : Type*}



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



namespace AlgInterStructure
open InterStructure

variable {X : Type*}

/-- `L` is closed under unions of directed subfamilies (directed under `⊆`). -/
def ClosedUnderDirectedUnion (L : Set (Set X)) : Prop :=
  ∀ S : Set (Set X), S ⊆ L → DirectedOn (· ⊆ ·) S → Set.sUnion S ∈ L

/-- A non-empty family `L` of subsets of `X` is an algebraic `⋂`-structure if it is closed under
nonempty arbitrary intersections and closed under directed unions (under inclusion). -/
def IsAlgInterStructure (L : Set (Set X)) : Prop :=
  L.Nonempty ∧ ClosedUnderNonemptyInter L ∧ ClosedUnderDirectedUnion L

lemma isAlgInterStructure_iff (L : Set (Set X)) :
    IsAlgInterStructure L ↔
      L.Nonempty ∧ ClosedUnderNonemptyInter L ∧ ClosedUnderDirectedUnion L := by
  constructor
  · intro h
    exact ⟨h.1, h.2.1, h.2.2⟩
  · intro h
    exact ⟨h.1, ⟨h.2.1, h.2.2⟩⟩


def IsToppedAlgInterStructure (L : Set (Set X)) : Prop :=
  Set.univ ∈ L ∧ IsAlgInterStructure L


lemma isToppedAlgInterStructure_iff (L : Set (Set X)) :
    IsToppedAlgInterStructure L ↔
      L.Nonempty ∧ ClosedUnderNonemptyInter L ∧ ClosedUnderDirectedUnion L ∧ Set.univ ∈ L := by
  constructor
  · intro h
    exact ⟨h.2.1, h.2.2.1, h.2.2.2, h.1⟩
  · intro h
    exact ⟨h.2.2.2, ⟨h.1, ⟨h.2.1, h.2.2.1⟩⟩⟩


end AlgInterStructure

open AlgInterStructure

namespace AlgebraicClosureOperator

variable {X : Type*}

/--
The finite subsets of a set `A
-/
def finiteSubsets (A : Set X) : Set (Set X) :=
  {B | B ⊆ A ∧ B.Finite}


/--
The union of the set of closed, finite subsets of a set `A`
-/
def finiteClosureUnion (C : ClosureOperator (Set X)) (A : Set X) : Set X :=
  sSup (C '' finiteSubsets A)

/--
A closure operator `C` on a `Set X` is **algebraic** if
`C(A) = ⋃ {C(B) | B ⊆ A, B finite}` for every `A ⊆ X`.
-/
def IsAlgebraic (C : ClosureOperator (Set X)) : Prop :=
  ∀ A : Set X, C A = finiteClosureUnion C A



/--
Definitional unfolding of `IsAlgebraic`.
-/
lemma isAlgebraic_iff (C : ClosureOperator (Set X)) :
    IsAlgebraic C ↔ ∀ A : Set X, C A = sSup (C '' finiteSubsets A) := by
  rfl

/--
Equivalent set-builder notation.
-/
lemma isAlgebraic_iff_biUnion (C : ClosureOperator (Set X)) :
    IsAlgebraic C ↔ ∀ A : Set X, C A = ⋃ B ∈ finiteSubsets A, C B := by
  constructor
  · intro h A
    rw [h A, finiteClosureUnion]
    simp [Set.sSup_eq_sUnion, Set.sUnion_image]
  · intro h A
    rw [finiteClosureUnion, h A]
    simp [Set.sSup_eq_sUnion, Set.sUnion_image]



/-- Monoticity of the finite union side (useful for one direction of algebraic → directed). -/
lemma finiteClosureUnion_mono (C : ClosureOperator (Set X)) {A B : Set X} (hAB : A ⊆ B) :
    finiteClosureUnion C A ⊆ finiteClosureUnion C B := by
  simp only [finiteClosureUnion, Set.sSup_eq_sUnion, Set.subset_def]
  intro x hx
  rcases hx with ⟨s, hs, hxs⟩
  rcases hs with ⟨a, ha, rfl⟩
  refine ⟨C a, ?_, hxs⟩
  have haB : a ∈ finiteSubsets B := by
    simp only [finiteSubsets, Set.mem_setOf_eq]
    simp only[finiteSubsets, Set.mem_setOf_eq] at ha
    rcases ha with ⟨haAB, haFin⟩
    exact ⟨Set.Subset.trans haAB hAB, haFin⟩
  exact Set.mem_image_of_mem C haB


/--
Every algebraic operator satisfies `C A` equals the union over finite subsets of `A`.
-/
lemma isAlgebraic_apply (C : ClosureOperator (Set X)) (hC : IsAlgebraic C) (A : Set X) :
    C A = finiteClosureUnion C A :=
  hC A

/-- A bundled structure: a closure operator together with algebraicity. -/
structure Algebraic (X : Type*) where
  toClosureOperator : ClosureOperator (Set X)
  isAlgebraic : IsAlgebraic toClosureOperator




/-- Coercion from `Algebraic X` to `ClosureOperator (Set X)`. -/
instance : Coe (Algebraic X) (ClosureOperator (Set X)) :=
  ⟨fun C => C.toClosureOperator⟩

end AlgebraicClosureOperator


open AlgebraicClosureOperator
open InterStructure

theorem theorem_7_14 {ι : Type*} (C : ClosureOperator (Set X)) :
    List.TFAE [
      IsAlgebraic C,
      (∀ A : ι → Set X, C (⋃ i, A i) = ⋃ i, C (A i)),
      IsToppedAlgInterStructure (closedFamily C)
    ] := by
  sorry


/-
Def of finiteness has theorem in mathlib:
`CompleteLattice.isCompactElement_iff_le_of_directed_sSup_le`
-/
def isFiniteElement [CompleteLattice L] (k : L) : Prop :=
  ∀ (s : Set L), s.Nonempty → DirectedOn (fun (x1 x2 : L) =>
    x1 ≤ x2) s → k ≤ sSup s → ∃ x ∈ s, k ≤ x


lemma isFiniteElement_iff [CompleteLattice L] (k : L) :
    isFiniteElement k ↔ ∀ (s : Set L), s.Nonempty → DirectedOn (fun (x1 x2 : L) =>
      x1 ≤ x2) s → k ≤ sSup s → ∃ x ∈ s, k ≤ x := by
  rfl

lemma isFiniteElement_iff_IsCompactElement [CompleteLattice L] (k : L) :
    isFiniteElement k ↔ IsCompactElement k := by
  rw [isFiniteElement_iff]
  exact (CompleteLattice.isCompactElement_iff_le_of_directed_sSup_le (α := L) k).symm


def setOfFiniteElements [CompleteLattice L] : Set L :=
  {k | isFiniteElement k}

def setOfCompactElements [CompleteLattice L] : Set L :=
  {k | IsCompactElement k}



lemma lemma_7_16_i [CompleteLattice L] (F : Set L) (hF : F = setOfFiniteElements) (K : Set L)
    (hK : K = setOfCompactElements) : F = K := by
  ext k
  rw [hF, hK]
  simp only [setOfCompactElements, setOfFiniteElements, isFiniteElement_iff_IsCompactElement]


lemma lemma_7_16_ii [CompleteLattice L] (F : Set L) (hF : F = setOfFiniteElements) (k₁ k₂ : L)
    (h₁ : k₁ ∈ F) (h₂ : k₂ ∈ F) : k₁ ⊔ k₂ ∈ F := by
  rw [hF] at h₁ h₂ ⊢
  simp only [setOfFiniteElements, Set.mem_setOf_eq] at h₁ h₂ ⊢
  rw [isFiniteElement_iff_IsCompactElement]
  have hk₁ := (isFiniteElement_iff_IsCompactElement k₁).mp h₁
  have hk₂ := (isFiniteElement_iff_IsCompactElement k₂).mp h₂
  rw [CompleteLattice.isCompactElement_iff_le_of_directed_sSup_le]
  intro s hs hdir hle
  have hk₁' := (CompleteLattice.isCompactElement_iff_le_of_directed_sSup_le (α := L) k₁).mp hk₁
  have hk₂' := (CompleteLattice.isCompactElement_iff_le_of_directed_sSup_le (α := L) k₂).mp hk₂
  obtain ⟨x, hxs, hx₁⟩ := hk₁' s hs hdir (le_trans le_sup_left hle)
  obtain ⟨y, hys, hy₂⟩ := hk₂' s hs hdir (le_trans le_sup_right hle)
  obtain ⟨z, hzs, hxzy⟩ := hdir x hxs y hys
  obtain ⟨hxz, hyz⟩ := hxzy
  exact ⟨z, hzs, sup_le (hx₁.trans hxz) (hy₂.trans hyz)⟩


namespace AlgebraicLattice

variable {X : Type*}

def IsAlgebraicLattice [CompleteLattice L] : Prop :=
  ∀ a : L, a = sSup { k ∈ setOfCompactElements | k ≤ a }


end AlgebraicLattice

namespace AlgebraicClosureOperator

variable {X : Type*}

/-- Closure of a union agrees with the join of closures in `C.Closeds`. -/
lemma closure_union_eq_sup (C₀ : ClosureOperator (Set X)) (A B : Set X) :
    (⟨C₀ (A ∪ B), C₀.isClosed_closure _⟩ :
      C₀.Closeds) = ⟨C₀ A, C₀.isClosed_closure A⟩ ⊔ ⟨C₀ B, C₀.isClosed_closure B⟩ := by
  apply Subtype.ext
  dsimp [closedCompleteLattice]
  exact (ClosureOperator.closure_sup_closure C₀ A B).symm

/-- If `x` lies in the closure of a directed union of closed sets, it lies in some member. -/
lemma mem_sUnion_of_mem_closure_sUnion
    (C₀ : ClosureOperator (Set X)) (hAlg : IsToppedAlgInterStructure (closedFamily C₀))
    {s : Set C₀.Closeds} (hdir : DirectedOn (· ≤ ·) s) {x : X}
    (hx : x ∈ C₀ (Set.sUnion (Subtype.val '' s))) :
    ∃ z ∈ s, x ∈ (z : Set X) := by
  have hSsub : Subtype.val '' s ⊆ closedFamily C₀ := by
    intro _ hB
    rcases hB with ⟨z, hz, rfl⟩
    exact z.2
  have hdir' : DirectedOn ((· ⊆ ·) : Set X → Set X → Prop) (Subtype.val '' s) := by
    rintro _ ⟨a, ha, rfl⟩ _ ⟨b, hb, rfl⟩
    obtain ⟨c, hc, hac, hbc⟩ := hdir a ha b hb
    exact ⟨_, Set.mem_image_of_mem _ hc, hac, hbc⟩
  have hsUnion_mem : Set.sUnion (Subtype.val '' s) ∈ closedFamily C₀ :=
    hAlg.2.2.2 (Subtype.val '' s) hSsub hdir'
  have hclosed : C₀ (Set.sUnion (Subtype.val '' s)) = Set.sUnion (Subtype.val '' s) :=
    hsUnion_mem.closure_eq
  rw [hclosed] at hx
  rcases Set.mem_sUnion.mp hx with ⟨B, hBmem, hxB⟩
  rcases hBmem with ⟨z, hz, rfl⟩
  exact ⟨z, hz, hxB⟩

/-- The carrier of a join in `C.Closeds` is the closure of the set-theoretic union. -/
lemma coe_sSup_closeds (C₀ : ClosureOperator (Set X)) (s : Set C₀.Closeds) :
    ((sSup s : C₀.Closeds) : Set X) = C₀ (Set.sUnion (Subtype.val '' s)) := by
  haveI := closedCompleteLattice (P := Set X) C₀
  change (proposition_7_2_ii.sSupClosed (c := C₀) s).1 = C₀ (Set.sUnion (Subtype.val '' s))
  simp [proposition_7_2_ii.sSupClosed, Set.sSup_eq_sUnion]

/-- The closure of a singleton is compact. -/
lemma isCompactElement_closure_singleton (C : Algebraic X)
    (hAlg : IsToppedAlgInterStructure (closedFamily C.toClosureOperator)) (a : X) :
    IsCompactElement
      (⟨C.toClosureOperator {a}, C.toClosureOperator.isClosed_closure {a}⟩ :
        C.toClosureOperator.Closeds) := by
  let C₀ := C.toClosureOperator
  rw [CompleteLattice.isCompactElement_iff_le_of_directed_sSup_le]
  intro s hs hdir hle
  rw [Subtype.mk_le_mk] at hle
  have ha_in : a ∈ C₀ {a} := (C₀.le_closure {a}) (Set.mem_singleton a)
  have ha' : a ∈ ((sSup s : C₀.Closeds) : Set X) := hle ha_in
  rw [coe_sSup_closeds C₀ s] at ha'
  obtain ⟨z, hz, haz⟩ := mem_sUnion_of_mem_closure_sUnion C₀ hAlg hdir ha'
  refine ⟨z, hz, ?_⟩
  rw [Subtype.mk_le_mk]
  intro x hx
  have hzsub : C₀ {a} ⊆ (z : Set X) :=
    (C₀.monotone (Set.singleton_subset_iff.mpr haz)).trans z.2.closure_eq.le
  exact hzsub hx

/-- The closure of a finite set is a compact element of `C.Closeds`. -/
lemma isCompactElement_closure_finite (C : Algebraic X)
    (hAlg : IsToppedAlgInterStructure (closedFamily C.toClosureOperator)) {Y : Set X}
    (hY : Y.Finite) :
    IsCompactElement
      (⟨C.toClosureOperator Y, C.toClosureOperator.isClosed_closure Y⟩ :
        C.toClosureOperator.Closeds) := by
  classical
  let C₀ := C.toClosureOperator
  refine Set.Finite.induction_on Y hY ?empty ?insert
  · rw [CompleteLattice.isCompactElement_iff_le_of_directed_sSup_le]
    intro s hs _ hle
    obtain ⟨z, hz⟩ := hs
    exact ⟨z, hz, bot_le⟩
  · intro a Y ha _ ih
    have hsa := isCompactElement_closure_singleton C hAlg a
    rw [show insert a Y = Y ∪ {a} from by rw [Set.insert_eq, Set.union_comm]]
    rw [closure_union_eq_sup]
    let KY : C₀.Closeds := ⟨C₀ Y, C₀.isClosed_closure Y⟩
    let Ka : C₀.Closeds := ⟨C₀ {a}, C₀.isClosed_closure {a}⟩
    have hcompact :=
      CompleteLattice.isCompactElement_finsetSup (f := id) ({KY, Ka} : Finset C₀.Closeds) (by
        intro x hx
        simp only [Finset.mem_insert, Finset.mem_singleton] at hx
        rcases hx with rfl | rfl
        · exact ih
        · exact hsa)
    simpa [Finset.sup_insert, Finset.sup_singleton, id_eq] using hcompact

/-- Every closed set is the `sSup` of closures of its finite subsets. -/
lemma closed_sSup_finiteClosures (C : Algebraic X)
    (hAlg : IsToppedAlgInterStructure (closedFamily C.toClosureOperator))
    (A : C.toClosureOperator.Closeds) :
    A =
      sSup
        ((fun B : Set X => ⟨C.toClosureOperator B, C.toClosureOperator.isClosed_closure B⟩) ''
          (finiteSubsets (A : Set X))) := by
  let C₀ := C.toClosureOperator
  set s : Set C₀.Closeds :=
    (fun B : Set X => ⟨C₀ B, C₀.isClosed_closure B⟩) '' finiteSubsets (A : Set X)
  apply Subtype.ext
  have hval : Subtype.val '' s = C₀ '' finiteSubsets (A : Set X) := by
    ext B
    simp [s, Set.mem_image]
  have hdir :
      DirectedOn ((· ⊆ ·) : Set X → Set X → Prop) (C₀ '' finiteSubsets (A : Set X)) := by
    rintro _ ⟨B₁, h₁, rfl⟩ _ ⟨B₂, h₂, rfl⟩
    rcases h₁ with ⟨h₁sub, h₁fin⟩
    rcases h₂ with ⟨h₂sub, h₂fin⟩
    refine ⟨C₀ (B₁ ∪ B₂), ⟨B₁ ∪ B₂, ?_, rfl⟩, ?_, ?_⟩
    · simp [finiteSubsets, Set.mem_setOf_eq, h₁sub, h₂sub, h₁fin, h₂fin]
    · exact C₀.monotone (fun _ hx => Set.mem_union_left _ hx)
    · exact C₀.monotone (fun _ hx => Set.mem_union_right _ hx)
  have hsUnion_closed :
      Set.sUnion (C₀ '' finiteSubsets (A : Set X)) ∈ closedFamily C₀ := by
    simpa [closedFamily, Set.mem_setOf_eq] using
      hAlg.2.2.2 (C₀ '' finiteSubsets (A : Set X)) (by
        intro _ hB
        rcases hB with ⟨B, _, rfl⟩
        exact C₀.isClosed_closure B) hdir
  have hsUnion_eq :
      C₀ (Set.sUnion (C₀ '' finiteSubsets (A : Set X))) =
        Set.sUnion (C₀ '' finiteSubsets (A : Set X)) :=
    hsUnion_closed.closure_eq
  calc
    (A : Set X) = C₀ (A : Set X) := A.2.closure_eq.symm
    _ = finiteClosureUnion C₀ (A : Set X) := C.isAlgebraic (A : Set X)
    _ = Set.sUnion (C₀ '' finiteSubsets (A : Set X)) := by
      rw [finiteClosureUnion, Set.sSup_eq_sUnion]
    _ = ((sSup s : C₀.Closeds) : Set X) := by
      have hcoe := coe_sSup_closeds C₀ s
      rw [hval] at hcoe
      exact (hcoe.trans hsUnion_eq).symm

end AlgebraicClosureOperator

open AlgebraicClosureOperator


/-- If `C` is an algebraic closure operator on `X`, then `L` is an algebraic lattic. -/
theorem theorem_7_19_i (C : Algebraic X) (L : Set (Set X))
    (hL : L = closedFamily C.toClosureOperator) (hAlg : IsToppedAlgInterStructure L) :
    IsCompactlyGenerated C.toClosureOperator.Closeds := by
  have hAlg' : IsToppedAlgInterStructure (closedFamily C.toClosureOperator) := hL ▸ hAlg
  refine ⟨fun A => ?_⟩
  let C₀ := C.toClosureOperator
  let s : Set C₀.Closeds :=
    (fun B : Set X => ⟨C₀ B, C₀.isClosed_closure B⟩) '' finiteSubsets (A : Set X)
  refine ⟨s, ?_, (closed_sSup_finiteClosures C hAlg' A).symm⟩
  rintro _ ⟨B, hBmem, rfl⟩
  simpa [finiteSubsets, Set.mem_setOf_eq] using
    isCompactElement_closure_finite C hAlg' hBmem.2

/-- If `C` is an algebraic closure operator on `X`, then `A` is compact in `L` if and only if it is
the closure of a finite subset of `X`. -/
theorem theorem_7_19_ii (C : Algebraic X) (L : Set (Set X))
    (hL : L = closedFamily C.toClosureOperator)
    (hAlg : IsToppedAlgInterStructure L) (A : C.toClosureOperator.Closeds) :
    IsCompactElement A ↔ ∃ Y : Set X, Y.Finite ∧ C.toClosureOperator Y = (A : Set X) := by
  sorry

theorem theorem_7_20_i (L : Set (Set X)) (C : ClosureOperator (Set X)) (hL : L = closedFamily C) :
    IsToppedAlgInterStructure L → IsCompactlyGenerated C.Closeds := by
  sorry
