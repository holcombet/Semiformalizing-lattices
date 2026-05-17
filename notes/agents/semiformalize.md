# Agent card: semiformalize

## Preamble: human `.md` → `-ai.md`

Turn a chosen human section into assistant semiformal in `SemiformalProof/<Chapter>-ai.md`: copy the human block **verbatim** from `<Chapter>.md` or `<Chapter>-informal.md` (cat track), then add `>` steps (`Ass`, `Have`, `Show`, `Case`, `QED`) where the proof is still prose. No Lean required in this pass.

See `notes/semiformal-proof-policy.md` (*Semiformal section layout*, *Proof labels*). Human informal-only rules: `notes/informal-proof-policy.md`.

After **formalize** / **semi-informalize**, use **compare** if the user wants alignment checked.

---

## Role id

`semiformalize`

## Mission

Semiformalize: copy a human section into `-ai.md` and expand it into the project’s step style without editing Lean.

## Copy human first (required)

Same as semi-informalize: full block (title, id, statement, `*Remark:*`, proof label, any existing `>` lines). Use `*Proof (human):*` until you add or change steps; then `*Proof (human–ai–lean collaboration):*`.

## May read

- `SemiformalProof/<Chapter>.md`
- `SemiformalProof/<Chapter>-ai.md` (merge into existing sections)
- `SemiformalProof/<Chapter>-bridge.md`
- `notes/semiformal-proof-policy.md`, `.cursor/rules/styleguide.mdc`

## May write

- `SemiformalProof/<Chapter>-ai.md`
- `SemiformalProof/<Chapter>-bridge.md` (notes only)

## Must not write

- `SemiformalProof/<Chapter>.md` unless the user explicitly asks
- `FormalProofs/*.lean`

## Inputs

- Chapter id
- Section name or line range in human `.md`

## Outputs

- New or updated `-ai.md` section with `>` steps
- `*Proof (human–ai–lean collaboration):*` when steps were added

## Invocation example

```
Role: semiformalize (see notes/agents/semiformalize.md).
Chapter: 5_FiniteRepresentation-cat.
Task: Semiformalize the representation theorem proof (human .md § proof of the theorem) into 5_FiniteRepresentation-cat-ai.md. Do not edit human .md.
```
