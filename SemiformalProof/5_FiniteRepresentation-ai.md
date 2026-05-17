# Chapter 5 — assistant semiformal layer

Permanent assistant-authored semiformal proofs (human-reviewed). This file is kept even after items are promoted into the human outline.

Sibling files:

- Human semiformal outline: `SemiformalProof/5_FiniteRepresentation.md`.
- Bridge table: `SemiformalProof/5_FiniteRepresentation-bridge.md`.
- Formal Lean: `FormalProofs/5_FiniteRepresentation.lean`.
- Policy: `notes/semiformal-proof-policy.md`. Semi-informalize: `notes/agents/semi-informalize.md`.

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

---

**Lemma (atoms are join-irreducible)**
**lemma_5_3_i**
Let L be a lattice with least element 0.If $x$ is an atom, then $x$ is join-irreducible.

*Remark:* Lean says $x$ covers $\bot$ instead of $x$ is an atom. Lean says $\bot$ instead of $0$.

*Proof (human):*

> Ass: $x$ is an atom.
> Have: $\bot < x$
> Have: $\bot < y \le x \ \Rightarrow y=x$.
> Show: $b\sqcup c = x \ \Rightarrow b=x \vee c=x$.
> > Ass:  $b\sqcup c = x$
> > > Case: $b = x$
> > > Have: $b = x$ 
> >
> > > Case $b\not=x$
> > > Have: $b\le x$
> > > Have: $b=\bot$
> > > 
> > Have: $b=x \vee c=x$
> 
> Have: $b\sqcup c = x \ \Rightarrow b=x \vee c=x$.
> 
> QED

---

**lemma_5_3_ii** Let L be a lattice with least element 0. Then if $L$ is a Boolean lattice, $x \in \mathcal{J}(L)$ implies that $x$ is an atom (i.e. $0 \lessdot x$).

*Proof (human):*

> Ass: $L$ is a Boolean lattice and $x$ is join-irreducible \
> Goal: $0 < x$ and  $0 \leq y < x$ implies $y = 0$ for some $y \in L$ \
> Show: $0 < x$ 
>> Have: $x$ is join-irreducible implies $x \neq 0$ \
>> QED
>
> Show: $0 \leq y < x$
>> Have: $y = x \sqcap y$ \
>> Have: $x = x \sqcup y$ \
>> Have: $x = (x \sqcup y) \sqcap (y^c \sqcup y)$ \
>> Have: $x = (x \sqcap y^c) \sqcup y$ 
>>> Case: $x = x \sqcap y^c$ 
>>>> Have: $x \leq y^c$ \
>>>> Have: $x \sqcap y \leq y^c \sqcap y$ \
>>>> Have: $y \leq y^c \sqcap y$ \
>>>> Have: $y \leq 0$ \
>>>> Have: $y = 0$ \
>>>> QED
>>>
>>
>>> Case: $x = y$ 
>>>> Have: $x = x \sqcup x$ \
>>>> Have: $x = x$ \
>>>> QED
>>>
>>> QED
>>
>> QED
>
> QED

---

**theorem_5_5** Representation

---

**theorem_5_19**
Let $P$ and $Q$ be finite partially ordered sets.
Let $L$ be the lattice of downsets of $P$ and let $K$ be the lattice of downsets of $Q$.

1. Let $f:L\to K$ be a lattice homomorphism.
    Then there is an order-preserving map $\phi:Q\to P = \bigwedge \{ x\in P \mid y\in f({\downarrow}(x))\}$. 

2. Let ϕ:Q→P be an order-preserving map.
Then there is a bounded lattice morphism f:L→K defined by $f(a)=ϕ^{−1}(a)$ for all $a\in L$.
Equivalently, $ϕ(y)\in a$ if and only if $y ∈f(a)$ for all $a∈L, y ∈Q$.

1. This establishes a bijection between bounded lattice homomorphisms and monotone maps.

We prove this in several steps.

**Lemma (adjunction):** If $f:A\to B$ and $g:B\to A$ are monotone functions between posets, then $f\dashv g$ if and only if $a\le gfa$ and $fgb\le b$.

**Lemma (left-adjoint):** If $A,B$ are complete lattices and $f:A\to B$ preserves meets, then $f$ has a left-adjoint $g:B\to A$.

> Show: There is a left-adjoint $g$.
> Define: $g(b)=\bigwedge\{a \mid f(a)\le b\}$.
>> Show $g$ is left-adjoint.
>> Use Lemma (adjunction).
>>> Show: $fgb\le b$.
>>> $fgb = f(\bigwedge\{a \mid f(a)\le b\})$
>>> $=\bigwedge\{fa \mid f(a)\le b\}$
>>> $\le b$.
>>> QED
>>
>>> Show $a\le gfa$:
>>> $gfa = \bigwedge\{a' \mid fa'\le fa\} \ge a$
>>> QED
>>
>> QED
>
> QED

**Lemma (right-adjoint):** If $A,B$ are complete lattices and $f:A\to B$ preserves joins, then $f$ has a right-adjoint $h:B\to A$.

*Proof (human):* Follows from Lemma (left-adjoint) applied to $f^o:A^o\to B^o$ and the fact that $h^o\dashv f^o$ implies $f\dashv h$.

**Lemma (join-irred):** Let $f:A\to B$ be a complete lattice homomorphism.
Let $g\dashv f$. 
Then $g$ preserves join-prime elements.

*Proof (human):*
> Show: $g$ preserves join-prime elements
>> Ass: $b\le c\vee c' \ \Rightarrow \ (b\le c) \vee (b\le c')$
>> Show: $gb\le a\vee a' \ \Rightarrow \ (gb\le a) \vee (gb\le a')$
>>> Ass: $gb\le a\vee a'$
>>> Show: $(gb\le a) \vee (gb\le a')$
>>> Have $b\le f(a\vee a')$
>>> Have $b\le fa\vee fa'$
>>> Have $b\le fa$ or $b\le fa'$
>>> Have $gb\le a$ or $gb\le a'$
>>> QED
>>
>> QED
>
> QED

There are still some bits missing to prove the theorem, but the idea is clear now: the left-adjoint restricted to join-irreducibles is going to be the $\phi$ of the theorem.

The bijection between the arrows follows from the isomorphism $\hom(fa,b)\cong\hom(a,gb)$.

---

**lemma_5_3_ii_auto** (stub) Same statement as `lemma_5_3_ii`; alternate autoformalised proof in Lean only.

*Proof (semiformalized from lean):*

> TODO: optional sketch (duplicate of human lemma; may omit)

---

**lemma_5_4** (stub) Every element is the join of the atoms below it (`lemma_5_4` in Lean; proved).

*Proof (semiformalized from lean):*

> TODO

---

**corollary_5_6** (stub) Equivalent characterisations of finite Boolean / power-set shape.

*Proof (semiformalized from lean):*

> TODO

---

**theorem_5_9** (stub) x ↦ ↓x embeds a finite poset into join-irreducible lower sets.

*Proof (semiformalized from lean):*

> TODO

---

**lemma_5_11** (stub) Join-irreducible, join-prime, and finite join-refinement (partial in Lean).

*Proof (semiformalized from lean):*

> TODO

---

**theorem_5_12** (stub) Birkhoff representation for distributive lattices.

*Proof (semiformalized from lean):*

> TODO

---

**corollary_5_13** (stub) Finite lattice equivalences (distributive, lower sets, etc.).

*Proof (semiformalized from lean):*

> TODO

---

**lemma_5_18** (stub) Boolean vs antichain / chain conditions via irreducible presentation.

*Proof (semiformalized from lean):*

> TODO

---

**theorem_5_19_i** (stub) Part (1) of **theorem_5_19** above. Lean: `theorem_5_19_i` (sorry).

*Proof (semiformalized from lean):*

> TODO: formalize part (1); human outline is in **theorem_5_19** above.

---

**theorem_5_19_ii** (stub) Part (2) of **theorem_5_19** above. Lean: `theorem_5_19_ii` (sorry).

*Proof (semiformalized from lean):*

> TODO: formalize part (2); human outline is in **theorem_5_19** above.
