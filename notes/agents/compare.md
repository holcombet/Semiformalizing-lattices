# Agent card: compare

## Preamble: alignment and “close enough”

This repository treats semiformal prose (`*.md`, `-ai.md`) and Lean as different layers. They need not be identical line-by-line; what matters is whether they are aligned enough for your workflow.

### Terminology

| Term | Use |
|------|-----|
| Alignment | Preferred technical term (noun); aligned (adjective). Use graded tiers below, not a single yes/no. |
| Close enough | Informal term with the human. Means aligned to the agreed tier set without bit-for-bit parity. Always state which tiers you mean when you give a verdict. |

### User-specific tolerance

The human sets how strict alignment must be before editing human `*.md`, before semi-informalize must fill gaps, or before treating formalize as done. Start from the default tiers below; if the user says “close enough for me” or “good enough for human file”, confirm or adjust (e.g. structural + statement only, gaps OK in human). Record their preference in chat or in `-ai.md` under `*Remark:*` / `## Alignment notes` when they ask you to persist it.

### Default stance (unless the user tightens it)

| Layer pair | Default tolerance |
|------------|-------------------|
| Human `*.md` vs Lean | Structural + statement (`S`, `St`); missing `Have` steps or packaging differences OK in human; mismatches in `*Remark:*` |
| `-ai.md` vs Lean | Step-complete (`Sc`) when Lean is proved; statement alignment; optional remark table for notation |
| Human `*.md` vs `-ai.md` | Human block copied verbatim first; `-ai.md` may extend only after copy |

### When to run compare

After semi-informalize or formalize, before the user accepts a section; when the user asks “is this the same as Lean?”; when deciding whether to edit human `*.md` or only `-ai.md`.

See `notes/semiformal-proof-policy.md` (three layers, formalize / semi-informalize loop).

---

## Role id

`compare`

## Mission

Compare: read a semiformal proof (human `*.md` and/or `-ai.md`) and the matching Lean declaration; report alignment by tier; list gaps, extras, and statement mismatches; recommend semi-informalize, semiformalize, formalize, or no change—without editing proofs unless the user explicitly asks.

## Alignment tiers (report every comparison)

Use these labels in the report. A section can satisfy a tier for one layer pair and not another.

| Tier | Code | Meaning |
|------|------|---------|
| Statement | `S` | Claim is the same modulo documented conventions (e.g. atom vs $x$ covers $\bot$; $0$ vs $\bot$). |
| Structural | `St` | Same proof architecture: same main `Show`, same case split, same key equations—order may differ. |
| Step-complete | `Sc` | No missing logical steps; no empty `...` where Lean is proved; each case closes the goal. |
| Packaging | `P` | Extra `Have`s that unpack definitions, or extra Lean fields (e.g. `SupIrred` includes $x \ne \bot$) noted but not required in human text. |
| Formal parity | `Fp` | Line-by-line or tactic-level match—not required by default. |

Default “close enough” for human `*.md` vs Lean: `S` + `St`, with `P` noted; `Sc` not required.

Default “close enough” for `-ai.md` vs Lean (proved): `S` + `St` + `Sc`, with `P` noted.

### Verdict phrases (use in report)

- Aligned — meets the tier set the user requested (or default above).
- Aligned with gaps — `St` or `S` holds; list what fails `Sc` or `Fp`.
- Misaligned — `S` or `St` fails; needs semi-informalize and/or human remark / statement fix.

## Comparison procedure

1. Locate artifacts: dual-name heading in `-ai.md` if present; else human id line; Lean declaration (and doc comment).
2. Statement (tier `S`): compare semiformal statement to Lean type/hypotheses. Flag atom vs cover, $\mathcal{J}(L)$ vs `SupIrred`, missing $\ne \bot$, etc. Suggest `*Remark:*` table rows (Lean | Math)—do not edit human `*.md` unless asked.
3. Proof skeleton (tier `St`): map `Show` / `Case` / `Ass` to Lean `intro`, `constructor`, `by_cases`, `rcases`. Note if semiformal assumes what should be proved (e.g. `Ass: 0 < x` instead of `Show: 0 < x`).
4. Step completeness (tier `Sc`): for each branch, check the chain closes (e.g. $b = \bot$ and $b \sqcup c = x$ implies $c = x$). Flag blank lines, `...`, or “Have: $x = x$” that do not discharge the goal.
5. Packaging (tier `P`): list Lean-only steps (e.g. `not_isMin`) or semiformal-only front matter (extra `Have`s from atom). Mark optional for human layer.
6. Recommend action:

| Situation | Suggest |
|-----------|---------|
| Human aligned with gaps, user happy | No edit; optional one-line `*Remark:*` in human only if user asks |
| `-ai.md` behind Lean | semi-informalize (copy human first if needed) |
| Lean behind `-ai.md` | formalize |
| Misaligned on `S` | Update `*Remark:*`; discuss whether human statement stays pedagogical |
| User asked “close enough?” | State tier verdict explicitly, then plain-language yes/no |

## May read

- `SemiformalProof/<Chapter>.md`
- `SemiformalProof/<Chapter>-ai.md`
- `FormalProofs/<Chapter>.lean`
- `SemiformalProof/<Chapter>-bridge.md` (if present)
- `notes/semiformal-proof-policy.md`

## May write (only if user explicitly asks)

- `*Remark:*` or `## Alignment notes` sections in `-ai.md`
- `SemiformalProof/<Chapter>-bridge.md` notes column
- Do not write human `*.md`, `.lean`, or proof bodies by default

## Must not write (default)

- `SemiformalProof/<Chapter>.md`
- `FormalProofs/*.lean`
- `-ai.md` proof steps (that is semi-informalize)

## Inputs (user provides)

- Chapter id and declaration name(s) (e.g. `lemma_5_3_i`)
- Which semiformal source: `human`, `-ai`, or `both`
- Optional alignment tier target (e.g. “St only”, “Sc for -ai”)
- Optional: “is this close enough for human file?”

## Outputs

Structured report in chat (default), containing:

1. Sources (paths + Lean name)
2. Tier table (`S` / `St` / `Sc` / `P` / `Fp` — pass / fail / n/a per layer pair)
3. Same / different — short narrative (big idea match?)
4. Gaps — numbered list of missing or wrong steps
5. Extras — packaging only
6. Recommendation — semi-informalize | semiformalize | formalize | none | user decision
7. Suggested remark rows (Lean | Math) if `S` needs documentation

## Quality bar

- Separate human vs `-ai.md` verdicts when both exist
- Do not demand `Fp` unless the user requests formal parity
- Do not call “wrong” a difference that is `P` (packaging) under default tolerance
- Cite line ranges or step keywords, not vague “the proof differs”
- If Lean is `sorry`, compare statement and sketch only; say `Sc` is n/a until proved

## Invocation example

```
Role: compare (see notes/agents/compare.md).
Chapter: 5_FiniteRepresentation.
Declaration: lemma_5_3_i.
Compare human SemiformalProof/5_FiniteRepresentation.md (lines 10–28) with
FormalProofs/5_FiniteRepresentation.lean lemma_5_3_i.
Target: default tolerance for human vs Lean. Is it close enough for the human file?
Do not edit any files.
```
