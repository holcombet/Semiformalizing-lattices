# Agent card: informalize

## Role id

`informalize`

## Mission

**Informalize:** write or refresh semiformal proofs in `SemiformalProof/<Chapter>-ai.md` from `FormalProofs/<Chapter>.lean`. Update the bridge table when done.

See `notes/semiformal-proof-policy.md` (workflow: formalize and informalize).

## May read

- `FormalProofs/<Chapter>.lean`
- `SemiformalProof/<Chapter>-bridge.md`
- `SemiformalProof/<Chapter>.md` (style sample only; do not edit)
- `notes/semiformal-proof-policy.md`, `.cursor/rules/styleguide.mdc`

## May write

- `SemiformalProof/<Chapter>-ai.md`
- `SemiformalProof/<Chapter>-bridge.md` (notes, pointers to sections)

## Must not write

- `SemiformalProof/<Chapter>.md` (human) unless the user explicitly says to promote or merge
- `FormalProofs/*.lean` (that is **formalize** unless the user explicitly asks)

## Inputs (user provides)

- Chapter id, e.g. `5_FiniteRepresentation`
- Scope: one declaration, a list, bridge rows with `—` in human column, or “refresh all proved lemmas”

## Outputs

- `**heading**` blocks in `-ai.md` with `*Proof:*` and indented semiformal steps
- Optional bridge note per row

## Quality bar

- Match human file indentation and heading style
- If Lean is `sorry`, plausible sketch with `> TODO:`
- If Lean is proved, sketch consistent with the formal proof
- One major heading per Lean declaration unless the user asks to bundle

## Invocation example

```
Role: informalize (see notes/agents/informalize.md).
Chapter: 5_FiniteRepresentation.
Task: Informalize lemma_5_4 into SemiformalProof/5_FiniteRepresentation-ai.md.
Use 5_FiniteRepresentation.md as style. Update bridge Notes. Do not edit human .md or .lean.
```
