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

    Optional bridge (-bridge.md): transitional; see *Retiring `-bridge.md`*
```

### Formalize

**Direction:** `SemiformalProof/<Chapter>-ai.md` → `FormalProofs/<Chapter>.lean`

**Goal:** Turn semiformal statements and proof sketches in `-ai.md` into Lean declarations and proofs (or `sorry` placeholders with a clear plan).

**Typical steps:**

1. Read the relevant `-ai.md` section (dual-name heading gives the Lean target).
2. Add or update the Lean statement to match the semiformal claim (modulo mathlib conventions).
3. Prove, or leave `sorry` with a short doc comment on strategy.
4. Run `lake build` (or file-level check) before finishing.
5. Ensure the `-ai.md` section has the correct **dual-name heading** (add the Lean line if missing). Update `-bridge.md` only while that file still exists.

**Triggers:** New or revised proof sketch in `-ai.md`; you ask to “formalize `lemma_5_4`”; closing a `sorry` from an earlier formalize pass.

**Does not** edit the human `*.md` unless you explicitly ask.

### Informalize

**Direction:** `FormalProofs/<Chapter>.lean` → `SemiformalProof/<Chapter>-ai.md`

**Goal:** Write or refresh semiformal proof text in `-ai.md` that explains what Lean says and does.

**Copy the human section first (required when it exists):**

If the item appears in human `.md`, the matching `-ai.md` section must **start from a verbatim copy** of the full human block (heading lines, statement, `*Remark:*`, proof label, all `>` lines). See *Semiformal section layout*. Rename bare `*Proof:*` to `*Proof (human):*` on copy. Add a Lean heading line only when the declaration name differs from the human **id** line. Then **extend** the copy and set the label to `*Proof (human–ai–lean collaboration):*` once any step changes.

If the item exists only in Lean (no human section), write a new `-ai.md` section using the human file elsewhere as a **style sample**; heading is the Lean name only (one bold line).

**Typical steps:**

1. If the item appears in human `.md`, copy its full semiformal block into `-ai.md` (or merge without discarding human lines); use `*Proof (human):*` until steps change.
2. Read the Lean declaration (statement, proof, doc comments).
3. Complete or correct proof steps; set `*Proof (human–ai–lean collaboration):*` if any step was added or changed, or `*Proof (semiformalized from lean):*` if there was no human section.
4. If Lean is `sorry`, keep the human copy and mark remaining gaps (`> TODO:`); label is still **collaboration** if you changed any human line, otherwise **human**.
5. Set the **dual-name heading** (human line + Lean line when names differ). Update `-bridge.md` only while that file still exists.

**Triggers:** New Lean lemma with no `-ai.md` section; proof completed and prose is stale; bridge row with `—` in the human column but Lean present; you ask to “informalize `lemma_5_4`”.

**Does not** edit the human `*.md` unless you explicitly ask.

### Running the loop

| Situation | Usual next step |
|-----------|-----------------|
| Semiformal idea exists only in human `.md` | **Informalize** (copies human block into `-ai.md`, then completes from Lean) or you paste into `-ai.md`, then **formalize** |
| Sketch in `-ai.md`, no Lean yet | **Formalize** |
| Lean exists, `-ai.md` missing or outdated | **Informalize** |
| Lean proof changed materially | **Informalize** (refresh `-ai.md`) |
| `-ai.md` sketch revised for strategy | **Formalize** again |
| Happy with AI layer for pedagogy | Optional promotion into human `.md` (your edit) |

The loop may run many times per lemma. **`-ai.md` is not discarded** when you promote to human prose or when Lean catches up.

Role cards: `notes/agents/formalize.md`, `notes/agents/informalize.md`, `notes/agents/compare.md`.

### Compare (read-only alignment check)

**Compare** reads semiformal and Lean side by side and reports **alignment** by tier (statement, structural, step-complete, packaging, formal parity). Default project tolerance—“**close enough**” in conversation—means **statement + structural** alignment for human `.md` vs Lean, and **step-complete** for `-ai.md` vs Lean when proved. The human may tighten or loosen tiers; assistants start from defaults in `notes/agents/compare.md` and adapt when the user refines them.

Run compare after informalize/formalize or when accepting a proof in human `.md` without promoting every gap to `-ai.md`. Compare does not edit proofs unless explicitly asked (e.g. to add a `*Remark:*` table in `-ai.md`).

## Filenaming convention

Use the **same chapter stem** across layers. Example for chapter 5:

| Layer | Path pattern | Example |
|-------|--------------|---------|
| Human | `SemiformalProof/<Chapter>.md` | `SemiformalProof/5_FiniteRepresentation.md` |
| AI | `SemiformalProof/<Chapter>-ai.md` | `SemiformalProof/5_FiniteRepresentation-ai.md` |
| Lean | `FormalProofs/<Chapter>.lean` | `FormalProofs/5_FiniteRepresentation.lean` |
| Bridge (optional, transitional) | `SemiformalProof/<Chapter>-bridge.md` | `SemiformalProof/5_FiniteRepresentation-bridge.md` |

**Rules:**

- `<Chapter>` matches between semiformal and formal files (e.g. `5_FiniteRepresentation`).
- Human layer: suffix **`.md`** only.
- AI layer: suffix **`-ai.md`** only.
- Lean layer: **`FormalProofs/`**, extension **`.lean`**.
- Bridge: suffix **`-bridge.md`** — optional; see *Retiring `-bridge.md`*.
- Human ↔ Lean name mapping belongs in **`-ai.md` section headings**, not only in the bridge table.
- Formal-only scaffolding belongs in the Lean namespace **`ai`**.

## What goes in each file

### Human — `SemiformalProof/<Chapter>.md`

- Semiformal proofs you curate; follow *Semiformal section layout (human)*.
- Use `*Proof (human):*` in new or revised sections (not bare `*Proof:*`). Existing `*Proof:*` counts as human when copied into `-ai.md`.
- High friction for automated edits; change only with your explicit consent.
- Not required to stay in lockstep with every formalize/informalize pass.

### AI — `SemiformalProof/<Chapter>-ai.md`

- Full semiformal sections; primary **informalize** target and **formalize** source.
- **When human `.md` has the same item:** verbatim copy of the human section (headings, statement, `*Remark:*`, proof label, `>` steps), then extend; see *Semiformal section layout (AI)*.
- **When human `.md` has no item:** new section in human file style only.
- **Human ↔ Lean names** are recorded in the heading block (*Section headings and dual names*); this replaces the bridge table over time.
- One major section per logical item unless you ask to bundle.
- Kept permanently; promotion to human `.md` is optional.

## Semiformal section layout

Canonical pattern (chapter 5 example: `lemma_5_3_i` in `5_FiniteRepresentation.md`).

### Semiformal section layout (human)

Each item is one block, separated from the next by `---` when helpful.

```markdown
**Lemma (atoms are join-irreducible)**
**lemma_5_3_i**
Let L be a lattice with least element 0. If $x$ is an atom, then $x$ is join-irreducible.

*Remark:* Lean says $x$ covers $\bot$ instead of “$x$ is an atom”. Lean says $\bot$ instead of $0$.

*Proof (human):*

> Ass: …
> Have: …
> Show: …
> > Case: …
> > Have: … QED
>
> QED
```

| Part | Rule |
|------|------|
| **Title line** | Optional readable label: `**Lemma (…)**`, `**Theorem (…)**`, etc. |
| **Id line** | Stable book id: `**lemma_5_3_i**`, `**theorem_5_19**`, … (matches Lean when formalized under that name). |
| **Statement** | One or more prose lines with maths; period after “0.” etc. |
| **`*Remark:*`** | Optional; *before* the proof. Short alignment notes (human wording vs Lean/mathlib). Omit if there is nothing to say. |
| **Proof label** | `*Proof (human):*` then a blank line. |
| **Proof steps** | Indented blockquotes; see *Proof step vocabulary*. |

You may use only an **id line** (no title line) for minimal entries; add a title line when it helps readers.

### Semiformal section layout (AI)

Copy the **entire** human block into `-ai.md` when it exists (both bold heading lines, statement, `*Remark:*`, proof label, all `>` lines). On copy, rename `*Proof:*` / `*Proof (human):*` to `*Proof (human):*` until steps change.

Then apply *Section headings and dual names* (extra Lean line if needed) and *Proof labels (provenance)*.

### Proof step vocabulary

Use blockquotes (`>`) with fixed step keywords (roman or consistent casing within a chapter):

| Keyword | Role |
|---------|------|
| `Ass:` | Assumption or case hypothesis. |
| `Have:` | Derived fact. |
| `Show:` | Current subgoal. |
| `Case:` | Case split (often nested with extra `>`). |
| `Define:` | Definition introduced in proof (optional). |
| `Goal:` | Explicit goal (optional; e.g. in longer proofs). |
| `QED` | Subgoal or whole proof complete. |

Nesting: one extra `>` per level (`> Show:` then `> > Case:` then `> > > Have:`). Prefer one main `Show:` for the join-irreducibility (or similar) goal, then cases underneath—not unrelated `Show:` lines that do not match the lemma statement.

### Section headings and dual names

**Human `.md`:** up to two bold lines at the top — **title** (optional), then **id** (e.g. `lemma_5_3_i`).

**`-ai.md`:** copy those lines verbatim from human when the section was copied.

**Lean declaration line** (only in `-ai.md`): add a **third** bold line when the Lean name is **not** the same as the human **id** line:

```markdown
**Lemma (adjunction)**
**`galoisConnection_iff_mono`**
…
```

Here the human file might use `**Lemma (adjunction)**` with no separate `lemma_*` id; the Lean line carries the declaration name.

When the Lean declaration **equals** the human id line (both `lemma_5_3_i`), **do not** repeat it:

```markdown
**Lemma (atoms are join-irreducible)**
**lemma_5_3_i**
Let L be a lattice …
```

**Lean-only** item (no human section): one bold line with the declaration in backticks, then statement:

```markdown
**`lemma_5_4`**
Every element is the join of the atoms below it.
```

**Rules:**

- Do not merge title, id, and Lean name onto one line with slashes or parentheses.
- `*Remark:*` in human `.md` is copied into `-ai.md`; assistants may add or extend it when informalizing exposes a mismatch (prefer editing `-ai.md`, not human `.md`).
- Large human blocks (e.g. **theorem_5_19**) may keep one outer heading; each sub-lemma with its own Lean declaration gets its own heading block (title and/or id + Lean line when names differ) when split in `-ai.md`.

### Retiring `-bridge.md`

The bridge file is a **transitional** index. The long-term layout is: correspondence in **`-ai.md` headings**, proofs in **`-ai.md` bodies**, mathematics in **`.lean`**.

| Bridge column / role | Eventual home |
|---------------------|---------------|
| Human label ↔ Lean name | Dual-name heading lines in `-ai.md` |
| One-line summary | First sentence of the statement under the heading |
| Status (`proved` / `sorry` / `partial`) | Lean + optional `> Status:` line in `-ai.md`, or bridge until retired |
| Notes (namespace, mismatches) | End of section in `-ai.md` |
| Proposed human-outline updates | `## Proposed human-outline updates` at end of `-ai.md` or end of chapter `-bridge.md` until retired |

**While `-bridge.md` still exists:** keep it in sync when you touch a row, but **prefer adding or fixing dual-name headings in `-ai.md`** on every formalize/informalize pass. Do not create bridge-only mappings with no `-ai.md` section.

**When a chapter’s `-ai.md` has dual-name headings for every Lean declaration you care about**, you may stop updating or delete that chapter’s `-bridge.md`.

### Proof labels (provenance)

Do not use bare `*Proof:*` in `-ai.md`. Place the proof label **after** the optional `*Remark:*` and **before** the `>` proof steps. Use exactly one of:

| Label | When to use |
|-------|-------------|
| `*Proof (human):*` | Verbatim copy from human `.md`; no assistant or Lean-driven edits to the proof steps yet. |
| `*Proof (semiformalized from lean):*` | No human section to copy; proof text written from Lean only. |
| `*Proof (human–ai–lean collaboration):*` | Human block was copied and then extended or corrected using informalize/formalize (filled `...`, new steps, Lean alignment). |

**Rules:**

- After **informalize** on an item that exists in human `.md`, upgrade the label to `*Proof (human–ai–lean collaboration):*` once any proof step is added or changed beyond the human copy (including replacing `> ...`).
- If you only refresh wording without changing the human proof lines, keep `*Proof (human):*` or note at the end of the section.
- One label per section (not multiple `*Proof …*` blocks for the same lemma unless you deliberately split parts—say so in a one-line note under the heading).
- **Formalize** does not change the label by itself; re-run **informalize** after material Lean changes if the semiformal text should catch up, then use **collaboration** if steps changed.

### Lean — `FormalProofs/<Chapter>.lean`

- Primary **formalize** target; primary input for **informalize**.
- Doc comments anchor meaning next to code.

### Bridge — `SemiformalProof/<Chapter>-bridge.md` (optional)

- Transitional table: human `.md` | summary | lean | status | notes.
- Prefer dual-name headings in `-ai.md` instead of growing the bridge.
- Safe to omit once `-ai.md` headings cover the chapter (see *Retiring `-bridge.md`*).

## Principles

1. **One human-facing semiformal source** per chapter (`*.md`).
2. **Lean is authoritative for correctness** when prose and code disagree.
3. **Routine work cycles between `-ai.md` and `.lean`** via formalize and informalize.
4. **Assistants do not rewrite human semiformal by default.**

## What assistants should do by default

| Mode | Writes | Reads |
|------|--------|-------|
| **Formalize** | `FormalProofs/<Chapter>.lean`, `-ai.md` headings | `-ai.md`, human `.md` (context); `-bridge.md` if present |
| **Informalize** | `SemiformalProof/<Chapter>-ai.md` (headings + body) | `.lean`, human `.md` (style); `-bridge.md` if present |
| Either | — | Do not edit human `*.md` without explicit instruction |

Say which mode you want in chat (“formalize `theorem_5_5`”, “informalize everything with `sorry` in chapter 5”).

### Human consent and rare prose suggestions

Ideas for the human `*.md` go in **`## Proposed human-outline updates`** at the end of `-ai.md` (preferred) or in `-bridge.md` while it exists. Changing `SemiformalProof/<Chapter>.md` requires **explicit instruction**.

## Keeping alignment

| Mechanism | Role |
|-----------|------|
| Formalize / informalize loop | Keep `-ai.md` and `.lean` in sync |
| Compare (`notes/agents/compare.md`) | Alignment verdict before accepting “close enough” |
| Dual-name headings in `-ai.md` | Human ↔ Lean lookup (replaces bridge over time) |
| `*-bridge.md` | Optional until headings are complete |
| Lean doc comments | Stable anchors for informalize |
| Occasional human merge | Fold stable material into `*.md` when you choose |

## When to edit the human layer

Update `SemiformalProof/<Chapter>.md` when you want pedagogy or narrative changed, when formal work exposed a real error in your outline, or during a deliberate editorial pass—not after every loop iteration.

## Who “agents” means

Any automated assistant may run **formalize** or **informalize** under this policy. **You** own the human layer. For role ids and harness patterns, see `notes/multi-agent-specifications.md`.

## Summary

Three layers: **human** `.md`, **AI** `-ai.md`, **Lean** `.lean`. The working loop is **formalize** and **informalize**. Shared **section layout**: title + id headings, optional `*Remark:*`, `*Proof (…):*`, indented `Ass` / `Have` / `Show` / `Case` steps. **`-ai.md`** copies human blocks and adds a Lean bold line only when the declaration name ≠ the id line. **Bridge** `-bridge.md` is optional and may be retired. Human prose stays yours unless you say otherwise.
