# Duality for Finite Bounded Distributive Lattices

Chapter id: `5_FiniteRepresentation-cat`. Semiformal lemmas (`>` steps). Informal proof of the main theorem: `5_FiniteRepresentation-cat-informal.md`.

---

The first propositions are a warmup, partly to fix the notation and style of semiformal proofs.

**Prop (atoms are join-irreducible)**
Let L be a lattice with least element 0.If $x$ is an atom, then $x$ is join-irreducible.

*Proof:*

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

**Prop (in a BA, join-irreducibles are atoms)**
Let L be a lattice with least element 0. Then if $L$ is a Boolean lattice, $x \in \mathcal{J}(L)$ implies that $x$ is an atom.

*Proof:*
> Ass: $L$ is a Boolean lattice
> Ass: $x$ is join-irreducible 
> Show: $0 < x$ and  $0 \leq y < x$ implies $y = 0$
> Show: $y < x$ implies $y = 0$
>  Have: $0 < x$
> Have: $b\sqcup c = x \ \Rightarrow b=x \vee c=x$
>> Ass: $y < x$
> Show: $y = 0$
> Idea: Let $b=x\sqcap \neg y$ and $c = y$
> > Have: $(x \wedge \neg y)\vee y = x\vee y = x$
> > Have: $(x \wedge \neg y)=x$ or $y=x$.
> > > Case: $(x \wedge \neg y)=x$
> > > Have: $x\le \neg y$
> > > Have: $y \le \neg x$
> > > Have: $y \le \neg x \wedge x$
> > > Have: $y = 0$
> > 
> > > Case: $y=x$
> > > Have: Contradiction
> > > Have: $y = 0$
> >
> > QED
> 
> QED

--- 

**Lemma (Galois adjunction):** 
If $f:A\to B$ and $g:B\to A$ are monotone functions between posets, then $f\dashv g$ if and only if $a\le gfa$ and $fgb\le b$.

*Proof:* Hopefully that is already in mathlib

**Lemma (left-adjoint):** If $A,B$ are complete lattices and $f:A\to B$ preserves meets, then $f$ has a left-adjoint $g:B\to A$.

*Proof:*

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

**Lemma (right-adjoint):** 
If $A,B$ are complete lattices and $f:A\to B$ preserves joins, then $f$ has a right-adjoint $h:B\to A$.

*Proof:* Follows from Lemma (left-adjoint) applied to $f^o:A^o\to B^o$ and the fact that $h^o\dashv f^o$ implies $f\dashv h$.

**Lemma (join-irred):** 
Let $f:A\to B$ be a complete lattice homomorphism.
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
