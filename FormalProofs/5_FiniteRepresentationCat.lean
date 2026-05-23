import Mathlib.CategoryTheory.Functor.Basic
import Mathlib.CategoryTheory.Opposites
import Mathlib.CategoryTheory.Types.Basic
import Mathlib.Order.Category.BddDistLat
import Mathlib.Order.Category.FinBddDistLat
import Mathlib.Order.Category.FinPartOrd
import Mathlib.Order.Category.PartOrd
import Mathlib.Data.Fintype.Pi
import Mathlib.Order.Hom.BoundedLattice
import Mathlib.Order.Hom.Order

/-!
# Finite representation — category-theoretic track

Informal source: `InformalProofs/5_FiniteRepresentation-cat.md` (lines 13–17).

Layers for `P` (informal `Pos(-,2)` factoring through `DL`):

1. Fibres `Pos(X,2)` as bounded distributive lattices (`homIntoTwo`).
2. Contravariant hom-functor into types (`homIntoTwo_functor`).
3. `P : FinPartOrdᵒᵖ ⥤ BddDistLat` — same assignment, values in `BddDistLat`.
-/

namespace FiniteRepresentationCat

universe u

open CategoryTheory

/-- Extract a `FinPartOrd` from an object of `FinPartOrdᵒᵖ` (avoid `OrderDual` name clash on `unop`). -/
abbrev unopFinPartOrd (X : FinPartOrdᵒᵖ) : FinPartOrd :=
  (X : Opposite FinPartOrd).unop

/-! ### Informal categories (mathlib names) -/

/-- Informal `Pos` / `fPos`: finite posets (`Mathlib.Order.Category.FinPartOrd`). -/
abbrev Pos := FinPartOrd

abbrev fPos := FinPartOrd

/-- Informal `DL`: bounded distributive lattices (`Mathlib.Order.Category.BddDistLat`). -/
abbrev DL := BddDistLat

/-- Informal `fDL`: finite bounded distributive lattices. -/
abbrev fDL := FinBddDistLat

/-! ### Hom into 2 (informal `Pos(X,2)`) -/

/-- The two-element chain (informal 2). -/
abbrev Two := Bool

/-- Informal `Pos(X,2)`: order-preserving maps `X → 2`. -/
abbrev homIntoTwo (X : Type u) [PartialOrder X] := X →o Two

noncomputable instance homIntoTwo_lattice (X : Type u) [PartialOrder X] :
    Lattice (homIntoTwo X) :=
  inferInstanceAs (Lattice (X →o Bool))

-- Pointwise lattice from `Mathlib.Order.Hom.Order` (`OrderHom.lattice`).
noncomputable instance homIntoTwo_distribLattice (X : Type u) [PartialOrder X] :
    DistribLattice (homIntoTwo X) :=
  DistribLattice.ofInfSupLe fun a b c => by
    refine le_of_eq ?_
    ext x
    simp only [OrderHom.coe_sup, OrderHom.coe_inf]
    exact inf_sup_left _ _ _

noncomputable instance homIntoTwo_boundedOrder (X : Type u) [PartialOrder X] :
    BoundedOrder (homIntoTwo X) where
  toOrderTop := inferInstanceAs (OrderTop (X →o Bool))
  toOrderBot := inferInstanceAs (OrderBot (X →o Bool))

/-- `OrderHom` as the subtype of monotone maps into `Bool`. -/
noncomputable def monotoneOrderHomEquiv (X : Type u) [PartialOrder X] :
    { f : X → Bool // Monotone f } ≃ homIntoTwo X where
  toFun := fun ⟨f, hf⟩ => ⟨f, hf⟩
  invFun := fun g => ⟨g.toFun, g.monotone'⟩
  left_inv := fun _ => rfl
  right_inv := fun _ => rfl

noncomputable instance homIntoTwo_fintype (X : Type u) [PartialOrder X] [Fintype X] :
    Fintype (homIntoTwo X) := by
  classical
  haveI : Fintype { f : X → Bool // Monotone f } := Subtype.fintype _
  exact Fintype.ofEquiv _ (monotoneOrderHomEquiv X)

/-- Bundle `Pos(X,2)` as an object of `DL`. -/
noncomputable def P_obj (X : PartOrd) : BddDistLat :=
  BddDistLat.of (homIntoTwo X)

/-- Bundle `Pos(X,2)` for a finite poset. -/
noncomputable def P_obj_fin (X : FinPartOrd) : BddDistLat :=
  P_obj X.toPartOrd

/-! ### Precomposition (informal arrow part of `P`) -/

/-- Precomposition induced by `f : X ⟶ Y` in `FinPartOrd` (contravariant on homs-into-2). -/
def P_map_precomp_fin {X Y : FinPartOrd} (f : X ⟶ Y) (g : homIntoTwo Y) : homIntoTwo X :=
  g.comp f.hom.hom

lemma P_map_precomp_fin_id (X : FinPartOrd) (g : homIntoTwo X) :
    P_map_precomp_fin (𝟙 X) g = g := by
  simp only [P_map_precomp_fin, FinPartOrd.hom_hom_id, OrderHom.comp_id]

lemma P_map_precomp_fin_comp {A B C : FinPartOrd} (φ : B ⟶ A) (ψ : C ⟶ B) (g : homIntoTwo A) :
    P_map_precomp_fin (ψ ≫ φ) g = P_map_precomp_fin ψ (P_map_precomp_fin φ g) := by
  simp only [P_map_precomp_fin, FinPartOrd.hom_hom_comp, OrderHom.comp_assoc]

/-- `P_map_precomp_fin` as a bounded lattice homomorphism (needs lattice lemmas on `homIntoTwo`). -/
noncomputable def P_map_precomp_boundedLatticeHom_fin {X Y : FinPartOrd} (f : X ⟶ Y) :
    BoundedLatticeHom (homIntoTwo Y) (homIntoTwo X) where
  toFun := P_map_precomp_fin f
  map_sup' g₁ g₂ := by
    ext x
    simp only [P_map_precomp_fin, OrderHom.comp_coe, Function.comp_apply, OrderHom.coe_sup,
      Pi.sup_apply]
  map_inf' g₁ g₂ := by
    ext x
    simp only [P_map_precomp_fin, OrderHom.comp_coe, Function.comp_apply, OrderHom.coe_inf,
      Pi.inf_apply]
  map_top' := by
    ext x
    change true = true
    rfl
  map_bot' := by
    ext x
    change false = false
    rfl

/-! ### Functor `P` -/

/-- Informal `P : Pos → DL` on objects; on morphisms, precomposition (`Posᵒᵖ ⥤ DL`). -/
noncomputable def P : FinPartOrdᵒᵖ ⥤ BddDistLat where
  obj X := P_obj_fin (unopFinPartOrd X)
  map {X Y} φ := BddDistLat.ofHom (P_map_precomp_boundedLatticeHom_fin φ.unop)
  map_id X := by
    simp only [P_obj_fin, unopFinPartOrd]
    rw [← BddDistLat.ofHom_id]
    apply congr_arg BddDistLat.ofHom
    apply BoundedLatticeHom.ext
    intro g
    change (P_map_precomp_boundedLatticeHom_fin (𝟙 (unopFinPartOrd X)) g) =
        (BoundedLatticeHom.id (homIntoTwo (unopFinPartOrd X).toPartOrd)) g
    simp only [P_map_precomp_boundedLatticeHom_fin, BoundedLatticeHom.id_apply]
    exact P_map_precomp_fin_id (unopFinPartOrd X) g
  map_comp {X Y Z} φ ψ := by
    apply BddDistLat.hom_ext
    simp only [CategoryTheory.unop_comp]
    apply BoundedLatticeHom.ext
    intro g
    change (P_map_precomp_boundedLatticeHom_fin (ψ.unop ≫ φ.unop) g) =
        ((P_map_precomp_boundedLatticeHom_fin ψ.unop).comp
          (P_map_precomp_boundedLatticeHom_fin φ.unop)) g
    simp only [P_map_precomp_boundedLatticeHom_fin, BoundedLatticeHom.comp_apply]
    exact P_map_precomp_fin_comp φ.unop ψ.unop g

/-- Underlying hom-set functor `Pos(-,2)` into bare types (forget `DL` structure). -/
noncomputable def homIntoTwo_functor : FinPartOrdᵒᵖ ⥤ Type* where
  obj X := homIntoTwo (unopFinPartOrd X)
  map {X Y} φ := TypeCat.ofHom (P_map_precomp_fin φ.unop)
  map_id X := by
    apply ConcreteCategory.hom_ext
    intro g
    apply OrderHom.ext
    funext x
    simp only [TypeCat.ofHom_apply, CategoryTheory.unop_id, unopFinPartOrd, P_map_precomp_fin_id,
      CategoryTheory.types_id_apply]
  map_comp {X Y Z} φ ψ := by
    apply ConcreteCategory.hom_ext
    intro g
    apply OrderHom.ext
    funext x
    simp only [TypeCat.ofHom_apply, CategoryTheory.unop_comp, CategoryTheory.types_comp_apply,
      P_map_precomp_fin_comp]

/-! ### Informal Prop (P) -/

/-- Informal **Prop (P)**: `P` preserves identities (functor axiom). -/
theorem prop_P_map_id (X : FinPartOrdᵒᵖ) : P.map (𝟙 X) = 𝟙 (P.obj X) := by
  exact P.map_id X

/-- Informal **Prop (P)**: `P` preserves composition (functor axiom). -/
theorem prop_P_map_comp {X Y Z : FinPartOrdᵒᵖ} (φ : X ⟶ Y) (ψ : Y ⟶ Z) :
    P.map (φ ≫ ψ) = P.map φ ≫ P.map ψ := by
  exact P.map_comp φ ψ

/-- Informal **Prop (P)**, finite restriction: fibre bundled in `fDL`. -/
noncomputable def P_fin_obj (X : FinPartOrd) : FinBddDistLat :=
  FinBddDistLat.of (homIntoTwo X)

/-- TODO: link `P_fin_obj` with `P.obj` after forgetting `FinBddDistLat → BddDistLat`. -/
theorem prop_P_restricts_fin (X : FinPartOrd) :
    P_fin_obj X = FinBddDistLat.of (homIntoTwo X) := by
  rfl

end FiniteRepresentationCat
