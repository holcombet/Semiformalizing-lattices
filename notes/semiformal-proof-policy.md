# Semiformal proof policy

This repository keeps **three proof layers** per chapter. Day-to-day work on mathematics runs in a **loop between the AI and Lean layers**; the human layer sits above that loop.

## Three layers

| Layer | What it is | Authoritative for |
|-------|------------|-------------------|
| **Human** | Curated semiformal proof in natural language with mathematical notation | Pedagogy, narrative, notation choices, what you want readers to see first |
| **AI** | Assistant-authored semiformal proof, human-reviewed; kept permanently | Working semiformal truth between you and the checker; gap-fill, expansions, alternates |
| **Lean** | Machine-checked proof in `FormalProofs/` | Correctness once prose and code disagree |

When statements conflict, **Lean wins for mathematics**; the human file wins for **what you choose to teach**.

The **human** layer is outside the formalize/informalize loop: assistants do not edit it by default. You may seed `-ai.md` from the human file, or promote sections upward when you choose.

## Workflow: formalize and informalize

The active loop is between **`-ai.md`** and **`.lean`**.

```
                 Human (.md)
                      │
           you: seed, promote, consent
                      ▼
    ┌─────────────────────────────────────┐
    │         AI  (-ai.md)                │
    └──────────────┬──────────────────────┘
                   │
         formalize  │  informalize
         (-ai → Lean)│  (Lean → -ai)
                   ▼
    ┌─────────────────────────────────────┐
    │         Lean  (.lean)               │
    └─────────────────────────────────────┘

    Bridge (-bridge.md): correspondence + status for all three layers
```

### Formalize

**Direction:** `SemiformalProof/<Chapter>-ai.md` → `FormalProofs/<Chapter>.lean`

**Goal:** Turn semiformal statements and proof sketches in `-ai.md` into Lean declarations and proofs (or `sorry` placeholders with a clear plan).

**Typical steps:**

1. Read the relevant `-ai.md` section (and the bridge row if present).
2. Add or update the Lean statement to match the semiformal claim (modulo mathlib conventions).
3. Prove, or leave `sorry` with a short doc comment on strategy.
4. Run `lake build` (or file-level check) before finishing.
5. Update `-bridge.md`: Lean name, status (`proved` / `sorry` / `partial`), notes.

**Triggers:** New or revised proof sketch in `-ai.md`; you ask to “formalize `lemma_5_4`”; closing a `sorry` from an earlier formalize pass.

**Does not** edit the human `*.md` unless you explicitly ask.

### Informalize

**Direction:** `FormalProofs/<Chapter>.lean` → `SemiformalProof/<Chapter>-ai.md`

**Goal:** Write or refresh semiformal proof text in `-ai.md` that explains what Lean says and does.

**Typical steps:**

1. Read the Lean declaration (statement, proof, doc comments).
2. Add or update the matching `**heading**` block in `-ai.md` (same style as the human file: `*Proof:*`, `> Show:` / `> Have:`).
3. If Lean is `sorry`, give a plausible sketch and mark gaps (`> TODO:`).
4. If Lean is proved, the sketch must be consistent with the formal proof.
5. Update `-bridge.md` notes (e.g. “proof in `-ai.md` § …”).

**Triggers:** New Lean lemma with no `-ai.md` section; proof completed and prose is stale; bridge row with `—` in the human column but Lean present; you ask to “informalize `lemma_5_4`”.

**Does not** edit the human `*.md` unless you explicitly ask.

### Running the loop

| Situation | Usual next step |
|-----------|-----------------|
| Semiformal idea exists only in human `.md` | You copy or paraphrase into `-ai.md`, then **formalize** |
| Sketch in `-ai.md`, no Lean yet | **Formalize** |
| Lean exists, `-ai.md` missing or outdated | **Informalize** |
| Lean proof changed materially | **Informalize** (refresh `-ai.md`) |
| `-ai.md` sketch revised for strategy | **Formalize** again |
| Happy with AI layer for pedagogy | Optional promotion into human `.md` (your edit) |

The loop may run many times per lemma. **`-ai.md` is not discarded** when you promote to human prose or when Lean catches up.

Role cards: `notes/agents/formalize.md`, `notes/agents/informalize.md`.

## Filenaming convention

Use the **same chapter stem** across layers. Example for chapter 5:

| Layer | Path pattern | Example |
|-------|--------------|---------|
| Human | `SemiformalProof/<Chapter>.md` | `SemiformalProof/5_FiniteRepresentation.md` |
| AI | `SemiformalProof/<Chapter>-ai.md` | `SemiformalProof/5_FiniteRepresentation-ai.md` |
| Lean | `FormalProofs/<Chapter>.lean` | `FormalProofs/5_FiniteRepresentation.lean` |
| Bridge (coordination) | `SemiformalProof/<Chapter>-bridge.md` | `SemiformalProof/5_FiniteRepresentation-bridge.md` |

**Rules:**

- `<Chapter>` matches between semiformal and formal files (e.g. `5_FiniteRepresentation`).
- Human layer: suffix **`.md`** only.
- AI layer: suffix **`-ai.md`** only.
- Lean layer: **`FormalProofs/`**, extension **`.lean`**.
- Bridge: suffix **`-bridge.md`** (correspondence and status—not a fourth proof layer).
- Declaration names in Lean should track the human or AI outline when possible. Formal-only scaffolding belongs in the Lean namespace **`ai`**.

## What goes in each file

### Human — `SemiformalProof/<Chapter>.md`

- Semiformal proofs you curate.
- High friction for automated edits; change only with your explicit consent.
- Not required to stay in lockstep with every formalize/informalize pass.

### AI — `SemiformalProof/<Chapter>-ai.md`

- Full semiformal sections; primary **informalize** target and **formalize** source.
- One major heading per Lean item unless you ask to bundle.
- Kept permanently; promotion to human `.md` is optional.

### Lean — `FormalProofs/<Chapter>.lean`

- Primary **formalize** target; primary input for **informalize**.
- Doc comments anchor meaning next to code.

### Bridge — `SemiformalProof/<Chapter>-bridge.md`

- Table: human `.md` | summary | lean | status | notes (`—` where a counterpart is missing).
- Updated after formalize or informalize passes.
- “Proposed human-outline updates (awaiting author)” for batched suggestions about the human layer.

## Principles

1. **One human-facing semiformal source** per chapter (`*.md`).
2. **Lean is authoritative for correctness** when prose and code disagree.
3. **Routine work cycles between `-ai.md` and `.lean`** via formalize and informalize.
4. **Assistants do not rewrite human semiformal by default.**

## What assistants should do by default

| Mode | Writes | Reads |
|------|--------|-------|
| **Formalize** | `FormalProofs/<Chapter>.lean`, bridge status | `-ai.md`, `-bridge.md`, human `.md` (context) |
| **Informalize** | `SemiformalProof/<Chapter>-ai.md`, bridge notes | `.lean`, `-bridge.md`, human `.md` (style) |
| Either | — | Do not edit human `*.md` without explicit instruction |

Say which mode you want in chat (“formalize `theorem_5_5`”, “informalize everything with `sorry` in chapter 5”).

### Human consent and rare prose suggestions

Ideas for the human `*.md` go in **`-bridge.md`**, batched. Changing `SemiformalProof/<Chapter>.md` requires **explicit instruction**.

## Keeping alignment

| Mechanism | Role |
|-----------|------|
| Formalize / informalize loop | Keep `-ai.md` and `.lean` in sync |
| `*-bridge.md` | Single lookup for human ↔ AI ↔ Lean and status |
| Lean doc comments | Stable anchors for informalize |
| Occasional human merge | Fold stable material into `*.md` when you choose |

## When to edit the human layer

Update `SemiformalProof/<Chapter>.md` when you want pedagogy or narrative changed, when formal work exposed a real error in your outline, or during a deliberate editorial pass—not after every loop iteration.

## Who “agents” means

Any automated assistant may run **formalize** or **informalize** under this policy. **You** own the human layer. For role ids and harness patterns, see `notes/multi-agent-specifications.md`.

## Summary

Three layers: **human** `.md`, **AI** `-ai.md`, **Lean** `.lean`. The working loop is **formalize** (AI → Lean) and **informalize** (Lean → AI). **Bridge** `-bridge.md` records correspondence. Human prose stays yours unless you say otherwise.
