# Chapter 5 — assistant semiformal layer (category-theoretic track)

Chapter id: `5_FiniteRepresentation-cat`. Permanent assistant-authored semiformal proofs (human-reviewed). This file is kept even after items are promoted into the human outline.

Sibling files (this track):

- Human semiformal outline: `SemiformalProof/5_FiniteRepresentation-cat.md`.
- Human informal proofs: `SemiformalProof/5_FiniteRepresentation-cat-informal.md`.
- Bridge table: `SemiformalProof/5_FiniteRepresentation-cat-bridge.md`.
- Formal Lean: `FormalProofs/5_FiniteRepresentationCat.lean` (declarations in namespace `FiniteRepresentationCat`).

Book-aligned track (unchanged names): `5_FiniteRepresentation.md`, `5_FiniteRepresentation-ai.md`, `5_FiniteRepresentation-bridge.md`, `FormalProofs/5_FiniteRepresentation.lean`.
- Policy: `notes/semiformal-proof-policy.md`, `notes/informal-proof-policy.md`. Roles: `notes/agents/semiformalize.md`, `notes/agents/semi-informalize.md`.

When an item exists in the human `.md`, copy the **full** block (title + id headings, statement, `*Remark:*`, proof, `>` steps) per `notes/semiformal-proof-policy.md` (*Semiformal section layout*). Add a third bold `` **`lean_name`** `` line only when Lean ≠ the human id line. Use `*Proof (human):*`, `*Proof (semiformalized from lean):*`, or `*Proof (human–ai–lean collaboration):*` — not bare `*Proof:*`.

Sections below are stubs until drafted. Remove `(stub)` from the heading when a proof is written; update the bridge Notes column (e.g. “proof in `-ai.md` § lemma_5_4”).

---

**Remark (Lean vs math):**

| Lean | Math |
|------|------|
| $\bot$ | $0$ |
| $\sqcap$ | $\wedge$ |
| $\sqcup$ | $\vee$ |
| $x$ covers $\bot$ | $x$ is an atom |
