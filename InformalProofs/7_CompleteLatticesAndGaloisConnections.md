# Complete Lattices and Galois Connections

## proposition_7_2_i

Let $c$ be a closure operator on an ordered set $P$. \
$P_C = \{c(x)|x \in P\}$ and $P_c$ contains the top element of $P$ when it exists. 

## proposition_7_2_ii
Let $c$ be a closure operator on an ordered set $P$. 

Assume P is a complete lattice. 
* For any $x \in P$, $$c(x) = \bigwedge\nolimits_P \{y \in P_c | x \leq y\}$$
* $P_c$ is a complete lattice, under the order inherited from P, such that, for every subset $S$ of $P_c$, $$\bigwedge\nolimits_{P_c} S = \bigwedge\nolimits_P S \ \text{ and } \ \bigvee\nolimits_{P_c} S = c (\bigvee\nolimits_P S).$$

 
## theorem_7_3_a

Let $C$ be a closure operator on a set $X$. Then the family $$\mathcal{L}_C := \{A \subseteq X \ | \ C(A) = A\}$$ of closed subsets of $X$ is a topped $\bigcap$-structure and so forms a complete lattice, when ordered by inclusion, in which $$\bigwedge_{i\in I} A_i = \bigcap_{i \in I} \ A_i,$$ $$\bigvee_{i\in I} A_i = C\ (\ \bigcup_{i\in I} A_i).$$

## theorem_7_3_b

Given a topped $\bigcap$-structure $\mathcal{L}$ on $X$, the formula $$C_\mathcal{L} (A) := \bigcap \{B \in \mathcal{L} | A \subseteq B\}$$ defines a closure operator on $C_\mathcal{L}$ on $X$.

