# Chapter 5

**lemma_5_3_i** If $x$ is an atom, then $x$ is join-irreducible

*Proof:*

> Ass: $x$ is an atom.
> Have: $\bot < x$
> Have: $\bot < y \le x \ \Rightarrow y=x$.
> Show: $y\le x\ \Rightarrow y=x$ 
> > ...
> 
> Show: $b\sqcup c = x \ \Rightarrow b=x \vee c=x$.
> > Case: $b = x$
> > Have: $b = x$ QED
>
> > Case $b\not=x$
> > Have: $b\le x$
> > Have: $b=\bot$
> > Have: $b\sqcup c = c = x$ QED
> 
> QED

---

**theorem_5_19**
Let $P$ and $Q$ be finite partially ordered sets.
Let $L$ be the lattice of downsets of $P$ and let $K$ be the lattice of downsets of $Q$.

1. Let $f:L\to K$ be a lattice homomorphism.
    Then there is an order-preserving map $\phi:Q\to P = \bigwedge \{ x\in P \mid y\in f({\downarrow}(x))\}$. 

2. Let ϕ:Q→P be an order-preserving map.
Then there is a bounded lattice morphism f:L→K defined by $f(a)=ϕ^{−1}(a)$ for all $a\in L$.
Equivalently, $ϕ(y)\in a$ if and only if $y ∈f(a)$ for all $a∈L, y ∈Q$.

3. This establishes a bijection between bounded lattice homomorphisms and monotone maps.

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

*Proof:* Follows from Lemma (left-adjoint) applied to $f^o:A^o\to B^o$ and the fact that $h^o\dashv f^o$ implies $f\dashv h$.

**Lemma (join-irred):** Let $f:A\to B$ be a complete lattice homomorphism.
Let $g\dashv f$. 
Then $g$ preserves join-prime elements.

*Proof*. 
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

We can turn this into a wider project of formalizing duality theorems.

- Autoformalizing Stone duality.
  - What is the SOTA on autormalizing with open source tools?
  - What happens if we apply this to the vast literature of duality theorems?
  - How much help does autorformalization need from semiformal proof specs?
  - Benchmark against different styles of informal and semiformal proofs.
  - Benchmark against different designs and different LLMs.
  - Benchmark autoformalization against human-in-the-loop interactive methods.
  - Is there, or should we create, a markdown editor that can fold in an out indented subproofs? 
    - Another useful feature would be the ability to import latex packages or even just small files with personal macrodefinitions.
