# Chapter 2: Lattices

### Lemma 2.8

> Let $L$ be a lattice and let $a, b \in L$. Then the following are equivalent:
> (i) $a \leq b$ \
> (ii) $a \vee b = b$ \
> (iii) $a \wedge b = a$

...

### Proposition 2.19(i)

> Let $L$ and $K$ be lattices and $f : L \to K$ a map. \
> The following are equivalent: \
> (a) $f$ is order-preserving \
> (b) ($\forall a, b \in L$) $f(a \vee b) = f(a) \vee f(b)$ \
> (c) ($\forall a, b \in L$) $f(a \wedge b) = f(a) \wedge f(b)$

...

### Proposition 2.19(ii)

> Let $L$ and $K$ be lattices and $f : L \to K$ a map. \
> $f$ is a lattice isomorphism if and only if it is an order isomorphism.

...


### Lemma 2.22

> Let $P$ be an ordered set, let $S, T \subseteq P$ and assume that $\bigvee S$, $\bigvee T$, $\bigwedge S$, and $\bigwedge T$ exist in P. \
> (i) $s \leq \bigvee S$ and $s \geq \bigwedge S$ for all $s \in S$ \
> (ii) Let $x \in P$; then $x \leq \bigwedge S$ if and only if $x \leq s$ for all $s \in S$ \
> (iii) Let $x \in P$; then $x \geq \bigvee S$ if and only if $x \geq s$ for all $s \in S$ \
> (iv) $\bigvee S \leq \bigvee T$ if and only if $s \leq t$ for all $s \in S$ and all $t \in T$ \
> (v) If $S \subseteq T$, then $\bigvee S \leq \bigvee T$ and $\bigwedge S \geq \bigwedge T$

...


### Lemma 2.24

> Let $P$ be a lattice. Then $\bigvee F$ and $\bigwedge F$ exist for every finite, non-empty subset $F$ of $P$.

...


### Lemma 2.30

> Let P be an ordered set such that $\bigwedge S$ exists in $P$ for every non-empty subset $S$ of $P$. Then $\bigvee S$ exists in $P$ for every subset $S$ of $P$ which has an upper bound in $P$; indeed $\bigvee S = \bigwedge S^{u}$.

...

### Theorem 2.31

> Let $P$ be a non-empty ordered set. Then the following are equivalent: \
> (i) P is a complete lattice \
> (ii) $\bigwedge S$ exists in $P$ for every subset $S$ of $P$ \
> (ii) $P$ has a top element, $\top$, and $\bigwedge S$ exists in P for every non-empty subset $S$ of $P$.

...


### Lemma 2.39

> An ordered set $P$ satisfies (ACC) if and only if every non-empty subset $A$ of $P$ has a maximal element.

...

### Exercise 2.6(i)

> Let $P$ be an ordered set.  \
> (i) Prove that if $A \subseteq P$ and $\bigwedge A$ exists in $P$, then $\bigcap \{ \downarrow a | a \in A\} = \ \downarrow (\bigwedge A)$.

...


### Exercise 2.11

> Let $L$ be a lattice. Prove that the following are equivalent: \
> (i) $L$ is a chain; \
> (ii) every non-empty subset of $L$ is a sublattice; \
> (iii) every two-element subset of $L$ is a sublattice.

...


### Exercise 2.19(i)

> Let $f : L \to K$ be a lattice homomorphism. \
> (i) Show that if $M \in \text{Sub } L$, then $f(M) \in \text{Sub } K$.

