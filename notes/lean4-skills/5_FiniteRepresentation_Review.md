# Lean4 review: `lemma_5_3_ii'`

**File:** `FormalProofs/5_FiniteRepresentation.lean` (lines 79–105)  
**Command:** `/lean4:review` (read-only)  
**Date:** 2026-05-22

**Declaration:** `lemma_5_3_ii' [BooleanAlgebra L] (x : L) : SupIrred x → ⊥ ⋖ x`

---

## Verdict

**Mathematically sound and complete.** The argument matches the standard Boolean-algebra cover proof: show `⊥ < x`, then for `y < x` either `y = x` (contradiction) or decompose `x` using `y ≤ x` and join-irreducibility to force `y = ⊥`. The decomposition via `(x ⊔ y) ⊓ (yᶜ ⊔ y)` is the semiformal route noted in the comment; `lemma_5_3_ii` uses the equivalent `(x ⊓ c) ⊔ (x ⊓ cᶜ)` form.

**Build:** No diagnostics on this declaration; the proof typechecks.

---

## What works well

1. **Clear case split** on `y = x` vs `y ≠ x`, mirroring `lemma_5_3_ii`.
2. **Correct use of `SupIrred`** via `rcases h.2 hxdec.symm` on the Boolean rewrite.
3. **First branch** (`y = x`): clean `lt_irrefl` after `rw [hy_eq]`.
4. **Second branch, first subcase:** good chain `le_of_inf_eq` → `inf_le_inf_right` → `compl_inf_eq_bot` → `le_bot_iff` → `lt_irrefl ⊥`.
5. **No sorries, no custom axioms** on this lemma.

---

## Project-style gaps (`proof-rules.mdc`)

| Issue | Severity | Detail |
|--------|----------|--------|
| No declaration docstring | Medium | `lemma_5_3_ii` has no `/-- … -/` either; project rules ask for one sentence minimum on theorems/lemmas. |
| No step comments | Medium | Non-trivial `have` / `rcases` steps lack the required “mathematical purpose” one-liners (e.g. decomposition, “hence `y ≤ yᶜ`”, “hence `y = ⊥`”). |
| No short-proof comment | Low | Rules suggest an optional collapsed proof comment below when a shorter version exists (as with `lemma_5_3_ii`). |

---

## Proof engineering notes

**Duplicate coverage.** `lemma_5_3_ii` and `lemma_5_3_ii'` prove the same statement. Keeping both is fine if one is the “autoformalized” reference and one tracks the semiformal proof—but without a docstring on `lemma_5_3_ii'`, readers may not know which to maintain.

**Redundant binders.** After `intro y hy_lt`, each branch does `intro hyx` with `hyx : y < x` (same as `hy_lt`). Likely the second component of `⊥ ⋖ x` is a dependent `∀` and both appear in the goal; still, the proof can often be flattened to a single `intro y hy` (as in `lemma_5_3_ii` with `c` / `hc_lt` only once).

**Indentation.** `lemma_5_3_ii` uses 4-space `by` blocks; `lemma_5_3_ii'` uses 2-space. Minor inconsistency in one file.

**Second subcase (lines 103–105).** Correct if `h_inf_compl` rewrites `hyx` to `x < x`, but this is the least readable step in the proof—a one-line comment (“`x ⊓ yᶜ = x` forces `y ≤ x` and clashes with `y < x`”) would help, or aligning with `lemma_5_3_ii`’s `x ≤ cᶜ` + `inf_compl_eq_bot'` route for parallel structure.

**`le_of_inf_eq`.** Used only here in the repo; it is Mathlib’s standard move from `a ⊓ b = b` to `a ≤ b`. Fine, but worth a short comment the first time it appears in the file.

---

## Side-by-side with `lemma_5_3_ii`

| Aspect | `lemma_5_3_ii` | `lemma_5_3_ii'` |
|--------|----------------|-----------------|
| Decomposition | `(x ⊓ c) ⊔ (x ⊓ cᶜ)` + `inf_sup_left` | `(x ⊔ y) ⊓ (yᶜ ⊔ y)` + `sup_of_le_left` |
| Below-`x` step | `c ≤ cᶜ` → `c ≤ ⊥` | `y ≤ yᶜ` via `le_of_inf_eq` |
| Readability | Slightly more direct | Closer to semiformal, slightly more rewrites |
| Length | ~27 lines | ~27 lines |

Neither is clearly superior; choose one canonical proof unless you want both for pedagogy.

**Proof under review (excerpt):**

```lean
lemma lemma_5_3_ii' [BooleanAlgebra L] (x : L) :
  SupIrred x → ⊥ ⋖ x := by
  intro h
  constructor
  · exact bot_lt_iff_ne_bot.mpr h.ne_bot
  · intro y hy_lt
    by_cases hy_eq : y = x
    · intro hyx
      rw [hy_eq] at hyx
      exact lt_irrefl x hyx
    · intro hyx
      have hy_le : y ≤ x := le_of_lt hyx
      have hy_inf_x : x ⊓ y = y := inf_eq_right.mpr hy_le
      have hxdec : x = (x ⊔ y) ⊓ (yᶜ ⊔ y) := by
        rw [compl_sup_eq_top, inf_top_eq, sup_of_le_left hy_le]
      rw [← sup_inf_right x yᶜ y] at hxdec
      rcases h.2 hxdec.symm with hy_irr | h_inf_compl
      · have h_le_compl := le_of_inf_eq hy_irr
        have h_inf_le := inf_le_inf_right y (h_le_compl)
        rw [hy_inf_x] at h_inf_le
        rw [compl_inf_eq_bot] at h_inf_le
        rw [le_bot_iff] at h_inf_le
        rw [h_inf_le] at hy_lt
        exact lt_irrefl ⊥ hy_lt
      · rw [h_inf_compl] at hy_inf_x
        rw [h_inf_compl] at hyx
        exact lt_irrefl x hyx
```

---

## Recommendations (optional)

1. Add a brief `/--` docstring: alternate proof of Lemma 5.3(ii), from semiformal decomposition.
2. Add step comments on decomposition, `rcases`, and the ⊥-contradiction chain.
3. Drop the extra `intro hyx` if the goal allows a single `y < x` hypothesis.
4. If only one lemma is needed in the project, deprecate or remove the duplicate after picking a favorite (`/lean4:golf` or `/lean4:refactor`).

---

## Out of scope for this review

File-level sorries and the unused `φ_inv` variable in `theorem_5_19_ii` elsewhere in the file are unrelated; this review does not block on them.

---

## Follow-up commands

- `/lean4:prove` — guided sorry-filling elsewhere in the file  
- `/lean4:golf` — unify or shorten `lemma_5_3_ii` vs `lemma_5_3_ii'`  
- `/lean4:refactor` — extract shared Boolean decomposition lemma
