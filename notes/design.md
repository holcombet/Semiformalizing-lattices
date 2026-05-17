# Design 

## Three levels

- The **informal** level has informal proos, roughly textbook style. [Example](../InformalProofs/5_FiniteRepresentation-cat.md).
- The **semiformal** has two files
  - `.md` written by human 
  - `-ai.md` maintained by human with ai
- The **formal** level has a `.lean`-file maintained by human with ai.

## Workflow between levels

Work does not stay inside one folder. Typical flow:

```
InformalProof.md (written by human)
        │  
        │  human semiformalizes
        ▼
SemiformalProof.md  ----------──-----------------------──┐
        │                                                │
        │  ai-guided-by-human semiformalizes             │
        ▼                                                │
SemiformalProof-ai.md ◄──── ai semideformalizes  ◄──---──┤
        │                                                │
        │  ai-guided-by-human formalizes                 │
        ▼                                                │
FormalProof.lean ---------------------------─────────────┘
```

There are two agent-cards specifying the "ai-agent-by-human" transformations. The agent-card

- [`formalize`](./agents/formalize.md): rules for an ai-agent helping human to translate a semiformal proof in `-ai.md` to a formal proof in `.lean`.
- [`semi-informalize](./agents/semi-informalize.md): rules for an ai-agent helping human to translate a a formal proof in `.lean` to a semiformal proof in `-ai.md`.

These will be the important ones. Two other ones are much more experimental:
- [`semi-formalize`](./agents/semi-formalize.md) might help with translating informal proofs to semiformal ones.
- [`informalize`](./agents/informalize.md) may help with informalizing a semi-formal proof.

---

This file: Entry point for how proof material moves through this repository. **Normative rules** live in the policy files below; this note is the map and the **cross-level workflow**. A separate architecture note may be added later for structure-only description; design decisions stay here or in policy over time.
