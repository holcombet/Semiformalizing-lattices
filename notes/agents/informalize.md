# Agent card: informalize

## Preamble: Lean → semiformal

This repository runs a loop between `.lean` (checked mathematics) and `-ai.md` (assistant semiformal). Informalize is the step from Lean toward semiformal: explain what the formal proof does in the project’s `>` step style (`Ass`, `Have`, `Show`, `Case`, `QED`).

Human `*.md` is the curated narrative. This role does not edit it unless the user explicitly asks to promote or merge a section. When a human section exists, copy it verbatim into `-ai.md` first, then extend—never replace human wording with a fresh draft from Lean alone.

### Alignment target for `-ai.md`

When Lean is proved, aim for step-complete alignment (`Sc` in `notes/agents/compare.md`): same main argument as Lean, no silent gaps (`...`) left unfilled. The human file may remain at structural + statement alignment only (“close enough” for the human layer); step-level detail lives in `-ai.md`.

### Proof labels

Record provenance with exactly one of:

- `*Proof (human):*` — copy only, no step changes yet.
- `*Proof (human–ai–lean collaboration):*` — human copy plus added or corrected steps (including filling `...`).
- `*Proof (semiformalized from lean):*` — no human section to copy.

After filling `...` or changing any `>` line, use `*Proof (human–ai–lean collaboration):*`.

### Remarks

Use `*Remark:*` or a Lean | Math table for notation and statement mismatches (atom vs $x$ covers $\bot$, $0$ vs $\bot$). Prefer editing `-ai.md`, not human `*.md`.

### When to informalize

Lean exists but `-ai.md` is missing or stale; after formalize changes a proof; user asks to informalize a declaration (e.g. `lemma_5_3_i`). Suggest `compare` afterward if the user asks whether the result is “close enough”.

See `notes/semiformal-proof-policy.md` (*Semiformal section layout*, *Proof labels*).

---

## Role id

`informalize`

## Mission

Informalize: write or refresh semiformal proofs in `SemiformalProof/<Chapter>-ai.md` from `FormalProofs/<Chapter>.lean`. Update the bridge table when done.

## Copy human first (required)

When the bridge row names an item in the human column (not `—`):

1. Copy verbatim from `SemiformalProof/<Chapter>.md` into `-ai.md`: title + id headings, statement, `*Remark:*`, proof label, and every existing `>` line. Rename bare `*Proof:*` to `*Proof (human):*` on copy.
2. Then extend: fill `...` / gaps, add steps, align the argument with Lean.

Do not draft a replacement section from Lean alone when human prose already exists.

When the human column is `—`, write a new `-ai.md` section using other human sections as style only.

## Proof labels (required in `-ai.md`)

Never use bare `*Proof:*`. Use exactly one of the three labels in the preamble. After any step change beyond the human copy, use `*Proof (human–ai–lean collaboration):*`.

## Section layout (required)

Copy the full human block when it exists: title line, id line, statement, `*Remark:*`, proof label, all `>` steps. See policy *Semiformal section layout*.

Headings in `-ai.md`: copy human bold lines; add `` **`lean_name`** `` as an extra line only when Lean ≠ human id line. Do not duplicate the Lean line when id and declaration already match (e.g. both `lemma_5_3_i`).

Preserve or add `*Remark:*` for human vs Lean wording (e.g. atom vs ⊥ ⋖ x).

## May read

- `SemiformalProof/<Chapter>.md` (copy source when present; style sample otherwise; do not edit)
- `FormalProofs/<Chapter>.lean`
- `SemiformalProof/<Chapter>-bridge.md`
- `notes/semiformal-proof-policy.md`, `.cursor/rules/styleguide.mdc`

## May write

- `SemiformalProof/<Chapter>-ai.md`
- `SemiformalProof/<Chapter>-bridge.md` (notes, pointers to sections)

## Must not write

- `SemiformalProof/<Chapter>.md` (human) unless the user explicitly says to promote or merge
- `FormalProofs/*.lean` (that is `formalize` unless the user explicitly asks)

## Inputs (user provides)

- Chapter id, e.g. `5_FiniteRepresentation`
- Scope: one declaration, a list, bridge rows with human labels, or “refresh all proved lemmas”

## Outputs

- `-ai.md` sections with correct dual-name heading, human block when it exists, correct `*Proof (…):*` label, completed proof steps
- Update `-bridge.md` only if that file still exists and you changed a row (especially statement mismatches vs Lean)

## Quality bar

- Human copy preserved unless a line must change for Lean consistency; then change only that line and note why
- If Lean is `sorry`, keep human text and mark `> TODO:` for missing steps
- If Lean is proved, completed steps must match the formal proof
- One major heading per Lean declaration unless the user asks to bundle

## Invocation example

```
Role: informalize (see notes/agents/informalize.md).
Chapter: 5_FiniteRepresentation.
Task: Informalize lemma_5_3_i into SemiformalProof/5_FiniteRepresentation-ai.md.
Copy the full lemma_5_3_i block from 5_FiniteRepresentation.md first, then fill "> ..."
from FormalProofs/5_FiniteRepresentation.lean. Do not edit human .md. Update bridge Notes.
```
