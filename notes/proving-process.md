# Proving process notes

This file records how selected sorries were proved: tools, search strategy, and step-by-step reasoning.

---

## [2L-03] — `lemma_2_30` (`FormalProofs/2_Lattices.lean`)

**Informal source:** Lemma 2.30 in `InformalProofs/Lattices.md`: if every nonempty subset of `P` has a greatest lower bound, then every subset `S` that is bounded above has a least upper bound; moreover \(\bigvee S = \bigwedge S^u\) where \(S^u\) is the set of upper bounds of `S`.

### Tools used

- **Read / Grep (repo + mathlib path):** Read the Lean goal and informal text; used shell `rg` on `.lake/packages/mathlib` (workspace `grep` often skips `.lake`) to find lemmas involving `upperBounds`, `IsLUB`, `IsGLB`, and `BddAbove`.
- **`lake env lean FormalProofs/2_Lattices.lean`:** Full-file typecheck after edits; surfaced the wrong direction on the `↔` lemma once.
- **Existing imports:** `Mathlib.Order.CompleteLattice.Basic` / `Defs` and `Mathlib.Order.Bounds` material already pulled in via the file’s order imports — no new `import` lines were required once the right lemma name was known.

### Thought process (discovery of each step)

1. **Unpack the conclusion.** The goal is `∀ S : Set P, BddAbove S → ∃ x, IsLUB S x`. So fix `S` and assume `S` is bounded above.

2. **What is `BddAbove S`?** By definition in mathlib, `BddAbove S` means the set of upper bounds of `S` is nonempty: there exists at least one upper bound. That is exactly `Nonempty (upperBounds S)`.

3. **Apply the hypothesis `hInf`.** It gives a GLB for every **nonempty** set. Instantiate it on `upperBounds S`, which is nonempty by step 2. So we obtain some `x` with `IsGLB (upperBounds S) x` — i.e. \(x = \bigwedge S^u\) in the informal notation.

4. **Recognize the standard order fact.** In a preorder, the GLB of all upper bounds of `S` is the same thing as the LUB of `S` (when it exists). This is the content of the equivalence lemma `isGLB_upperBounds` in `Mathlib/Order/Bounds/Basic.lean` (dual to `isLUB_lowerBounds`).

5. **Close the goal.** `obtain ⟨x, hx⟩ := hInf (upperBounds S) hne` and then prove `IsLUB S x` via `(isGLB_upperBounds (s := S)).1 hx`.

6. **First-direction mistake.** Initially `(…).2` was used, which is the **reverse** direction (`IsLUB S x → IsGLB (upperBounds S) x`). The compiler reported a type mismatch on `hx`. Switching to `.1` (forward `mp`) fixed it.

7. **Nonempty of `upperBounds S`.** Used `simpa [BddAbove, upperBounds] using hS` to unfold `BddAbove` to the existential / `Nonempty` form expected by `hInf`.

8. **Housekeeping.** The lemma statement had a stray unused parameter `(S : Set P)` before `hInf` (shadowed by the inner `∀ S`). Renamed to `_S` to satisfy the unused-variable linter without changing the logical content of the `hInf` assumption or the conclusion.

### Final proof shape (conceptual)

Introduce `S` and `hS : BddAbove S`; turn `hS` into `Nonempty (upperBounds S)`; apply `hInf` to `upperBounds S`; convert `IsGLB (upperBounds S) x` to `IsLUB S x` with `isGLB_upperBounds`.

---

## Lean LSP MCP and lean4-skills — why they were under-used (and what to do instead)

This section records an explicit agent reflection: **in this repo’s early sorry-closing work, lean-lsp-mcp and lean4-skills were often not invoked**, even though the project rules and lean4 skill prefer LSP-first workflows.

### Why that tended not to happen

1. **Habit and “good enough” feedback**  
   For many sorries the underlying mathematics was standard (bounds, `IsLUB` / `IsGLB`, finset folds, etc.), and **`lake env lean` / `lake build`** already gave precise errors (wrong direction on an `↔`, missing typeclass, etc.). That path worked quickly, so the agent did not reach for extra machinery.

2. **MCP is an extra step, not automatic**  
   Using **lean-lsp-mcp** properly means checking tool schemas under the MCP descriptors folder, then calling tools with the correct file and line. That was not treated as mandatory unless the user asked for live goals or the proof was stuck—so the default drifted to **file read + compiler**.

3. **lean4-skills are mostly user- or host-invoked workflows**  
   Slash commands such as `/lean4:prove` or `/lean4:autoprove` are **not** something the agent silently runs unless the host wires them in. When the user uses `/lean4:draft` (etc.), the agent can follow that intent manually in the editor without a separate “run the whole prove loop” integration.

4. **No failure forcing escalation**  
   The lean4 skill describes escalating to LSP goal inspection, `lean_multi_attempt`, and search tools when stuck or for heavy mathlib discovery. If **`lake env lean`** resolves the issue in one or two iterations, the agent may skip that escalation.

### What the agent *should* do instead

When proving in Lean in this project, the agent **should** use **lean-lsp-mcp** more systematically:

- **`lean_diagnostic_messages`** after substantive edits  
- **`lean_goal`** when the proof state matters (not only when `lake` is ambiguous)  
- **`lean_local_search`**, **`lean_loogle`**, or other search tools **before** guessing lemma names for non-trivial goals  

That matches the repo’s lean4 rules (“LSP-first”, search before prove) and reduces reliance on blind `lake` cycles.

### Optional project default (for the user)

If the user wants this baked in as a standing instruction, a one-line preference works well, for example: **“Always use LSP for sorries in this repo”** — meaning: check MCP tool schemas when needed, then treat **`lean_diagnostic_messages` + `lean_goal`** (and search tools as appropriate) as part of the **routine** for each `sorry`, not only when stuck.

---

## [2L-04] — `theorem_2_31` (TFAE `1 → 2`) (`FormalProofs/2_Lattices.lean`)

This section records the first time in this repo where **lean-lsp-mcp** was used directly while
closing a sorry.

### Tools used (lean-lsp-mcp)

- **`lean_goal`**: Queried the goal state around the `tfae_have 1 → 2 := by ...` line to confirm the
  exact target after introducing the hypothesis.
- **`lean_diagnostic_messages`**: Checked a narrow line range around the proof to catch parse errors
  (notably an invalid `?_` placeholder) and then a type mismatch once the proof term was in place.
- **(schema reads)**: Before calling these tools, the MCP tool descriptor JSON files were read
  (e.g. `lean_goal.json`, `lean_diagnostic_messages.json`) to ensure correct argument formats.

### Thought process (discovery and repair)

1. **Initial proof idea:** from `Nonempty (CompleteLattice P)` pick a `CompleteLattice` instance and
   use `⟨sSup S, isLUB_sSup S⟩`.
2. **Issue found via diagnostics:** the naive `letI := cl` caused an **order-instance mismatch**:
   `isLUB_sSup` was producing `IsLUB` with respect to `cl`’s `PartialOrder`, but the goal’s `IsLUB`
   was with respect to the ambient `[PartialOrder P]`.
3. **Statement correction:** strengthened the first TFAE item to ensure the `CompleteLattice` structure
   is **compatible with the ambient order**:
   `Nonempty { cl : CompleteLattice P // cl.toCompleteSemilatticeSup.toPartialOrder = (inferInstance : PartialOrder P) }`.
   This makes the “pick a complete lattice” step safe.
4. **Final proof:** `rintro ⟨cl, hcl⟩; cases hcl; letI := cl; intro S; exact ⟨sSup S, isLUB_sSup S⟩`.

---

## The “classical layer” in proofs (e.g. `theorem_5_19_i`)

Some sorries are closed using **`open Classical`**, **`Classical.choose` / `choose_spec`**, **`Classical.decEq`**, and **`Fintype.ofFinite`**. This section explains what that layer is, why it helps, why it limits you, and what it means for theorems that depend on such proofs.

### What the classical layer is

1. **`open Classical` / `Classical.choice`**  
   Constructive logic does not assume that every nonempty type has a chosen witness. **Choice** lets you pick an element whenever you know `∃ x, P x`—for example picking a **minimal** feasible witness per `y` via `Classical.choose` after proving a nonempty finite set has a minimal element.

2. **`Classical.decEq` / `DecidableEq`**  
   On an arbitrary type, equality may not be decidable. **Classical** logic makes every proposition decidable, so you can obtain `DecidableEq P` and `DecidableEq Q` even without a real decision procedure. That supports **`Finset.filter`**, **`Finset` membership**, and lemmas expecting decidable predicates.

3. **Promoting `Finite P` to `Fintype P`**  
   `[Finite P]` asserts existence of a finitness witness; many tools want a fixed **`Fintype`** (e.g. `Finset.univ`). **`Fintype.ofFinite`** uses classical ideas to supply that instance so you can work with `Finset` uniformly.

Together: **choice**, **decidable equality “by logic”**, and **convenient finite infrastructure** for `Finset`/`univ`.

### Why it is helpful

- Matches **everyday textbook steps** (“for each `y`, pick a minimal element of a nonempty finite set”).
- Unlocks **`Finset`**-based arguments without hand-building enumerations and `DecidableEq` instances.
- Keeps proofs **shorter**; avoiding it often means extra constructive structure or a different proof.

### Why it is a limitation

- **Not computationally meaningful**: `Classical.choose` does not yield an algorithm from the existence proof; you do not get executable “compute `φ(y)`” from that proof alone.
- **`DecidableEq` can be “fake”**: instances may exist only classically, which can conflict with goals that need **real** computational decidability or clean extraction.
- **Axiom footprint**: these proofs sit on the usual classical stack (`Classical.choice`, often `propext`, etc.). That is normal in Mathlib-style math but matters if you aim for **choice-free**, **HoTT-style**, or **minimal-axiom** developments.

**One-line summary:** classical machinery makes theorems **easy to state and prove like on paper**; it does not, by itself, give **programs** or **canonical computable witnesses**.

### How this affects theorems that use such a proof

**What propagates:** A later theorem that **uses** a lemma proved with choice does **not** get a different logical *type*. The conclusion is still a normal `Prop`. What propagates is **non-constructivity** and the **axiom dependency chain**: your final theorem is typically **no more constructive** than the lemmas it uses (check with “list axioms” style tools if you care).

**Usually harmless (Mathlib-style work):** If the project already treats mathematics classically and you only care about **truth of implications**, depending on classical lemmas is **standard** and not a logical problem.

**Where it bites:**

1. **Code extraction / computation** — you cannot turn `Classical.choose` into runnable code without a separate constructive definition or explicit algorithm.
2. **Strict foundational hygiene** — proofs that **forbid choice** cannot depend on these lemmas without refactoring.
3. ** Decidable instances** — downstream code that assumes **operational** `Decidable` behavior may be disappointed if instances came only from classical blanket decidability.

**Short summary:** Downstream theorems keep the **same statements** and remain **valid classically**; they generally **do not** inherit **computable witnesses** unless you strengthen proofs or assumptions later.

---

*Add new sections below for future sorries using the same template: tag, location, tools, reasoning, pitfalls.*

