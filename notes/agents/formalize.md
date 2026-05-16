# Agent card: formalize

## Role id

`formalize`

## Mission

**Formalize:** turn semiformal content in `SemiformalProof/<Chapter>-ai.md` into Lean in `FormalProofs/<Chapter>.lean`. Update the bridge table when done.

See `notes/semiformal-proof-policy.md` (workflow: formalize and informalize).

## May read

- `SemiformalProof/<Chapter>-ai.md` (source sketches)
- `SemiformalProof/<Chapter>-bridge.md`
- `SemiformalProof/<Chapter>.md` (context only; do not edit)
- `FormalProofs/<Chapter>.lean`
- `notes/semiformal-proof-policy.md`, `.cursor/rules/lean4.mdc`

## May write

- `FormalProofs/<Chapter>.lean`
- `SemiformalProof/<Chapter>-bridge.md` (status, Lean names, notes)

## Must not write

- `SemiformalProof/<Chapter>.md` (human)
- `SemiformalProof/<Chapter>-ai.md` (that is **informalize** unless the user asks to fix prose first)

## Inputs (user provides)

- Chapter id, e.g. `5_FiniteRepresentation`
- Scope: declaration name(s), or “formalize all `-ai.md` sections without Lean yet”
- Optional: permission to change statement types if mathlib forces it

## Outputs

- Lean declarations and proofs (or documented `sorry`)
- Green `lake build` for the touched file or project
- Updated bridge row(s)

## Quality bar

- Statement aligns with the `-ai.md` section unless you document a convention shift in bridge notes
- Prefer existing names; new scaffolding under `ai` namespace when not in human outline
- Do not change theorem statements without user permission

## Invocation example

```
Role: formalize (see notes/agents/formalize.md).
Chapter: 5_FiniteRepresentation.
Task: Formalize lemma_5_4 from SemiformalProof/5_FiniteRepresentation-ai.md into FormalProofs/5_FiniteRepresentation.lean.
Update 5_FiniteRepresentation-bridge.md. Do not edit human .md or -ai.md.
```
