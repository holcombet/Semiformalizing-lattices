# Duality for finite bounded distributive lattices (informal)

Chapter id: `5_FiniteRepresentation-cat`. Informal proof sketches (prose); lemmas with `>` steps live in `SemiformalProof/5_FiniteRepresentation-cat.md`. Overview: `notes/design.md`. Policy: `notes/informal-proof-policy.md`. Role: `notes/agents/informalize.md`.

Sibling files (this track):

- Semiformal outline: `SemiformalProof/5_FiniteRepresentation-cat.md`
- Assistant semiformal: `SemiformalProof/5_FiniteRepresentation-cat-ai.md`
- Formal Lean: `FormalProofs/5_FiniteRepresentationCat.lean`

---

Let $DL$ be the category of bounded distributive lattices. Let $Pos$ be the category of finite posets.

Let $P:Pos\to DL$ be defined by $PX=Pos(X,2)$ on objects and by precomposition on arrows.

**Prop (P):** $P$ is a functor $Pos\to DL$, which, moreover, restricts to $Pos\to DL$.

Let $S:DL\to Pos$ be defined by $SX=DL(X,2)$ on objects and by precomposition on arrows.

**Prop (S):** $S$ is a functor $DL\to Pos$, which, moreover, restricts to $fDL\to fPos$.

Let $\alpha :A \to PSA$ be defined by $\alpha(a)=(x\mapsto x(a))$.

**Prop (counit-morphism):** $\alpha$ is a lattice morphism.
  
Let $\xi: X\to SPX$ be defined by $\xi(x)=(a\mapsto a(x))$.

**Prop (unit-morphism):** $\xi$ is a lattice morphism

**Prop (triangle identities):** The unit and counit satisfy

$$
id = PX\xrightarrow {\alpha SA} PSPX \xrightarrow{P\xi} PX 
$$

$$
id = SA \xrightarrow{\xi {SA}} SPSA \xrightarrow{S\alpha} SA
$$

*Proof:* We have to show that $P\xi\circ \alpha SA$ map $a\in PX$ to the function $x\mapsto a(x)$.
- $\alpha PX(a)=(s\mapsto s(a))$
- $P\xi(f)(x) = f(\xi(x))$
- $P\xi(\alpha PX(a))(x)=\alpha PX(a)(\xi(x)) = \xi(x)(a)=a(x)$

Similarly, with $x\in SA$
- $\xi SA(x)=(p\mapsto p(x))$
- $S\alpha(f)(a)=f(\alpha(a))$
- $S\alpha(\xi SA(x))(a)=\xi SA(x)(\alpha(a))=\alpha(a)(x)=x(a)$

**Corollary:** The functor $P:Pos\to DL^{op}$ is left-adjoint to $S : DL^{op}\to Pos$.

**Prop (counit-iso):** On finite $X$, the counit  $\alpha A :A \to PSA$ is iso.

*Proof:* To show that $\alpha A:A\to PSA$ is injective, let $a,a'\in A$, $a\not\le a'$. We have to show that there is $x\in SA$ such that $\alpha(a)(x)\not=\alpha(a')(x)$. Define $x={\downarrow}a'$. Then $x(a')=1$ and $x(a)=0$. 

To show that $\alpha A:A\to PSA$ is surjective, let $p\in PSA$, that is, $p:SA\to 2$. Let $a$ be the intersection of primefilters $\bigwedge\{x\mid px=1\}$. ... ok ... here we need some argument why this is a singleton ...

**Prop (unit-iso):** On finite $A$, the unit  $\xi :X \to SPX$ is iso.

... similar to the above ... 

**Theorem (representation theorem for finite bounded distributive lattices)**

The category of finite bounded distributive lattices is dually equivalent to the category of finite posets.

*Proof:* We already showed that the triangle identities hold. It remains to show that $\alpha$ and $\xi$ are isomorphisms. 

