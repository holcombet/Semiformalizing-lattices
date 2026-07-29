# Informal to Lean notation

Translation table for the closure-operator theorem (Ch. 7): if `C` is a closure operator on `Set X`, then the family `𝓛_C = {A ⊆ X | C(A) = A}` of closed subsets is a topped `⋂`-structure and forms a complete lattice under inclusion, with `⋀_{i ∈ I} A_i = ⋂_{i ∈ I} A_i` and `⋁_{i ∈ I} A_i = C(⋃_{i ∈ I} A_i)`.

| Informal | Lean |
|---|---|
| Closure operator on `Set X` | `C : ClosureOperator (Set X)` |
| `C(A) = A` | `C.IsClosed A` |
| `𝓛_C = {A ⊆ X \| C(A) = A}` | `C.Closeds` (subtype) or `{A \| C.IsClosed A}` |
| topped `⋂`-structure | `IsToppedInterStructure (closedFamily C)` |
| complete lattice under `⊆` | `CompleteLattice C.Closeds` |
| `⋀ Aᵢ = ⋂ Aᵢ` | `(↑(sInf S) : Set X) = sInf (Subtype.val '' S)` |
| `⋁ Aᵢ = C(⋃ Aᵢ)` | `(↑(sSup S) : Set X) = C (sSup (Subtype.val '' S))` |

## Algebraic closure operator

Translation table for the definition (Ch. 7): a closure operator `C` on `Set X` is **algebraic** if for all `A ⊆ X`, `C(A) = ⋃ {C(B) | B ⊆ A, B finite}`.

| Informal | Lean |
|---|---|
| Closure operator on `Set X` | `C : ClosureOperator (Set X)` |
| `A ⊆ X` | `A : Set X` |
| `B ⊆ A`, `B` finite | `B ⊆ A ∧ B.Finite` |
| `{B ⊆ A \| B finite}` | `finiteSubsets A` |
| `C(B)` | `C B` |
| `⋃ {C(B) \| …}` | `sSup (C '' finiteSubsets A)` or `⋃₀ (C '' finiteSubsets A)` |
| `C` is algebraic | `IsAlgebraic C` |

On `Set X`, `sSup` of a family of sets is `⋃₀`, so the union in the definition is `sSup (C '' finiteSubsets A)`.
