# Chapter 5 — bridge (assistant ledger)

Sibling files:

- Human semiformal outline: `SemiformalProof/5_FiniteRepresentation.md` (do not edit here; record pointers only).
- Assistant semiformal layer: `SemiformalProof/5_FiniteRepresentation-ai.md` (permanent; human-reviewed).
- Formal Lean: `FormalProofs/5_FiniteRepresentation.lean`.
- Policy (file tiers, consent, naming): `notes/semiformal-proof-policy.md`.

**Bridge:** one table per chapter in `*-bridge.md` with columns for human markdown and Lean. Either column may be empty (—): that means no counterpart yet, not an error. Sort rows in a stable order (e.g. textbook number, then outline order within a theorem block).

## Naming convention (Lean)

Formal-only scaffolding from assisted sessions lives under the `ai` namespace so full names read `ai.<subnamespace>.<declaration>`. Declarations that intentionally mirror a named item in the human outline may keep human-style names at the root of the file (for example `lemma_5_3_i`).

## Bridge (chapter 5)

Human column: label in the human `.md` if it exists. Summary: one informal sentence. Lean: declaration name(s) exactly as in `FormalProofs/5_FiniteRepresentation.lean` (several names comma-separated if needed). Notes: namespace `ai.*`, extra lemmas in a stack, mismatches, or pointer to a section in `-ai.md`. Put summary before lean so previews wrap the prose column.

| Human `.md` | Summary | Lean | Status | Notes |
|-------------|---------|------|--------|-------|
| `lemma_5_3_i` | If ⊥ is covered only by x, then x is join-irreducible. | `lemma_5_3_i` | proved | md says “atom”; Lean uses ⊥ ⋖ x |
| `lemma_5_3_ii` | Join-irreducible elements in a Boolean algebra are atoms. | `lemma_5_3_ii` | proved | |
| — | Same statement; autoformalised proof. | `lemma_5_3_ii_auto` | proved | no row in human `.md` |
| — | Every element is the join of the atoms below it. | `lemma_5_4` | proved | no semiformal write-up yet |
| `theorem_5_5` (stub) | Finite Boolean algebra ≅ power set of its atoms. | `theorem_5_5` | sorry | |
| — | Several “finite power set” characterisations are equivalent. | `corollary_5_6` | sorry | |
| — | x ↦ ↓x embeds a finite poset into join-irreducible lower sets. | `theorem_5_9` | sorry | |
| — | Join-irreducible, join-prime, finite join-refinement agree. | `lemma_5_11` | partial | |
| — | Birkhoff: distributive lattice with ⊥ ≅ lower sets of join-irreducibles. | `theorem_5_12` | sorry | |
| — | Finite lattice: distributive vs lower-set vs subset-shaped. | `corollary_5_13` | sorry | |
| — | Via irreducibles, Boolean ↔ antichain and chain conditions. | `lemma_5_18` | sorry | |
| `theorem_5_19` (1) | Downset hom → monotone map on points (least preimage). | `theorem_5_19_i` | sorry | |
| `theorem_5_19` (2) | Monotone maps → downset hom by preimage. | `theorem_5_19_ii` | sorry | |
| Lemma (adjunction) | Monotone f,g adjoint iff unit and counit hold. | `galoisConnection_iff_mono` | proved | `ai.theorem_5_19_md_lemmas` |
| Lemma (left-adjoint) | Meet-preserving f has partner g(b)=⋀ of preimages. | `galoisConnection_sInfHom_leftAdjoint` | proved | `ai.theorem_5_19_md_lemmas`; also `leftAdjointₛInfHom`, … |
| Lemma (right-adjoint) | Join-preserving case by order dual. | `galoisConnection_sInfHom_dual` | proved | also `galoisConnection_sSupHom_rightAdjoint`, … |
| Lemma (join-irred) | Upper adjoint g preserves sup-prime elements. | `supPrime_comap_of_gc_completeLatticeHom` | proved | `ai.theorem_5_19_md_lemmas` |
Galois note: Mathlib uses `l ⊣ u` with `l a ≤ b ↔ a ≤ u b`; doc comments on the Lean side align the md “left/right” wording where needed.

## Proposed human-outline updates (awaiting author)

None yet. When formal work suggests a prose fix, add a row here (claim / why / pointer) per `notes/semiformal-proof-policy.md`.
