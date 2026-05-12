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

**theorem_5_19_right**
Let $P$ and $Q$ be finite partially ordered sets.
Let $L$ be the lattice of downsets of $P$ and let $K$ be the lattice of downsets of $Q$.
Let $f:L\to K$ be a lattice homomorphism.
Then there is an order-preserving map $\phi:Q\to P = \bigwedge \{ x\in P \mid y\in f({\downarrow}(x))\}$. 

---

