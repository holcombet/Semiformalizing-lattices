# Agent card: informalize

## Preamble: continue informal proofs in human `.md`

Work on the **informal** level: `InformalProofs/<Chapter>.md` (e.g. `InformalProofs/5_FiniteRepresentation-cat.md`). Semiformal `>` steps in `SemiformalProof/<Chapter>.md` are out of scope unless the user asks. See `notes/design.md`, `notes/informal-proof-policy.md`.

This is not Lean → `-ai.md` (that is **semi-informalize**) and not human → `-ai.md` with `>` steps (that is **semiformalize**).

### Rules

- Append or complete; do not replace existing author text (typos only when obvious).
- Stay **brief** unless the user asks for a long expansion.
- Match the file’s current style (prose vs `>` blocks).

---

## Role id

`informalize`

## Mission

Continue or lightly complete informal proof text in the human chapter file the user names.

## May read

- `InformalProofs/<Chapter>.md` (and sibling `SemiformalProof/` / `.lean` for context only)
- `notes/informal-proof-policy.md`, `notes/semiformal-proof-policy.md` (context)
- `.cursor/rules/styleguide.mdc`

## May write

- `InformalProofs/<Chapter>.md` — **append** or fill gaps only, per policy

## Must not write

- `SemiformalProof/<Chapter>-ai.md` (use **semiformalize**)
- `FormalProofs/*.lean` (use **formalize**)
- Human edits that rephrase existing paragraphs without permission

## Inputs

- Chapter id, e.g. `5_FiniteRepresentation-cat`
- Scope: e.g. “continue proof of the representation theorem from line 127”

## Outputs

- Short continuation in human `.md`
- Optional one-line chat note if notation should later be recorded in `-ai.md` `*Remark:*`

## Invocation example

```
Role: informalize (see notes/agents/informalize.md).
Chapter: 5_FiniteRepresentation-cat.
Task: Continue the representation theorem in InformalProofs/5_FiniteRepresentation-cat.md; keep it short; do not change existing lines except typos.
```
