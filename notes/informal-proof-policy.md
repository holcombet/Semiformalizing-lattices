# Informal proof policy

Human informal proofs may live in `SemiformalProof/<Chapter>.md` or, on the cat track, `SemiformalProof/<Chapter>-informal.md` (prose only; semiformal `>` steps stay in `<Chapter>.md`). This layer is for thinking on the page—not the `-ai.md` / Lean loop.

## What counts as informal here

- Narrative proof sketches: “define …”, “we show …”, short case splits without full `Ass` / `Show` scaffolding.
- Category-theoretic or book-style exposition the author is still shaping.
- Not required to match Lean or `-ai.md` line by line.

Semiformal layout (`*Proof (human):*`, `Ass` / `Have` / `Show`, dual-name headings) lives in `notes/semiformal-proof-policy.md` and targets `-ai.md` via **semiformalize** / **semi-informalize**.

## Assistant rules (human `.md`)

1. Do not rewrite the author’s paragraphs; **append** continuations or fill explicit gaps (`...`, “TODO”).
2. Fix **typos** only when obvious; do not “improve” wording or notation without permission.
3. Keep continuations **short** (rough guide: a few sentences or one small idea per request unless the user asks for more).
4. Prefer the author’s notation (`fDL`, `DL(A,2)`, etc.) even if Mathlib would spell it differently; note mismatches in chat or in `-ai.md` later, not by silently editing human prose.

## When to use which role

| Goal | Role |
|------|------|
| Continue or tidy informal proof in human `.md` | **informalize** (`notes/agents/informalize.md`) |
| Turn a human section into `-ai.md` with `>` steps (no Lean yet) | **semiformalize** (`notes/agents/semiformalize.md`) |
| Refresh `-ai.md` from proved Lean | **semi-informalize** (`notes/agents/semi-informalize.md`) |
| `-ai.md` → Lean | **formalize** |
| Check alignment | **compare** |

## Tracks

Chapter id may include a suffix (e.g. `5_FiniteRepresentation-cat`). Same rules; only edit the files for the track named in the task.
