# Agent card: formalize

## Preamble: semiformal → Lean

This repository runs a loop between `-ai.md` (assistant semiformal) and `.lean` (checked mathematics). Formalize is the step from semiformal toward Lean: turn proof sketches and statements in `-ai.md` into declarations and proofs that `lake build` accepts.

Human `*.md` sits above the loop. This role does not edit it. The human file may stay aligned with Lean only at statement + structural level (“close enough” for pedagogy); see `notes/agents/compare.md` for tiers `S`, `St`, and `Sc`.

### Sources of truth after formalize

| Question | Authoritative layer |
|----------|---------------------|
| Is the mathematics correct? | Lean |
| What did the human want to teach? | Human `*.md` (unchanged by this role) |
| What should assistants and tools read next? | `-ai.md` (dual-name headings, `*Remark:*` for notation) |

### Conventions

Mathlib may use $\bot$, $\sqcap$, $\sqcup$, and cover notation instead of book wording ($0$, $\wedge$, $\vee$, atom). Match the mathematical content in `-ai.md`; document shifts in `*Remark:*` or bridge notes, not by silently rewriting human prose.

### When to formalize

New or revised proof text in `-ai.md`; closing a `sorry`; user asks to formalize a declaration (e.g. `lemma_5_4`). After a successful run, suggest `compare` and, if needed, `semi-informalize` so `-ai.md` matches the finished proof.

### Statement safety

Do not change theorem types or names the human relies on without explicit user permission. Put auxiliary lemmas under the `ai` namespace when they are not in the human outline.

See `notes/semiformal-proof-policy.md` (workflow: formalize and semi-informalize). Human informal prose: `notes/informal-proof-policy.md`.

---

## Role id

`formalize`

## Mission

Formalize: turn semiformal content in `SemiformalProof/<Chapter>-ai.md` into Lean in `FormalProofs/<Chapter>.lean`. Update the bridge table when done.

## May read

- `SemiformalProof/<Chapter>-ai.md` (source sketches per policy *Semiformal section layout*: human copy, `*Remark:*`, `>` steps)
- `SemiformalProof/<Chapter>-bridge.md`
- `SemiformalProof/<Chapter>.md` (context only; do not edit)
- `FormalProofs/<Chapter>.lean`
- `notes/semiformal-proof-policy.md`, `.cursor/rules/lean4.mdc`

## May write

- `FormalProofs/<Chapter>.lean`
- `SemiformalProof/<Chapter>-bridge.md` (status, Lean names, notes)

## Must not write

- `SemiformalProof/<Chapter>.md` (human)
- `SemiformalProof/<Chapter>-ai.md` (that is `semi-informalize` unless the user asks to fix prose first)

## Inputs (user provides)

- Chapter id, e.g. `5_FiniteRepresentation`
- Scope: declaration name(s), or “formalize all `-ai.md` sections without Lean yet”
- Optional: permission to change statement types if mathlib forces it

## Outputs

- Lean declarations and proofs (or documented `sorry`)
- Green `lake build` for the touched file or project
- `-ai.md` section has dual-name heading (add Lean line if names differ)
- Updated bridge row(s) only if `-bridge.md` still exists

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
