# Sequential Monte Carlo with State Permutations
## Authors: Nagesh Adluru, Xingwei Yang, Longin Jan Latecki
## Email-ids: nagesh.adluru@gmail.com (Waisman Center), happyyxw@gmail.com (Amazon), latecki@temple.edu (Temple University)
### Basic overview

We consider a problem of finding maximum weight subgraphs (MWS) that satisfy hard constraints in a weighted graph. The constraints specify the graph nodes that must belong to the solution as well as mutual exclusions of graph nodes, i.e., pairs of nodes that cannot belong to the same solution. Our main contribution is a novel inference approach for solving this problem in a sequential monte carlo (SMC) sampling framework. Usually in an SMC framework there is a natural ordering of the states of the samples. The order typically depends on observations about the states or on the annealing setup used. In many applications (e.g., image jigsaw puzzle problems), all observations (e.g., puzzle pieces) are given at once and it is hard to define a natural ordering. Therefore, we relax the assumption of having ordered observations about states and propose a novel SMC algorithm for obtaining maximum a posteriori (MAP) estimate of a high-dimensional posterior distribution. This is achieved by exploring different orders of states and selecting the most informative permutations in each step of the sampling. Our experimental results demonstrate that the proposed inference framework significantly outperforms loopy belief propagation in solving the image jigsaw puzzle problem. In particular, our inference quadruples the accuracy of the puzzle assembly compared to that of loopy belief propagation.

### Sample results

### Full paper

### Acknowledgements
The authors would like to thank Taeg Sang Cho for providing the code for the method
in [14]. We would like to acknowledge the Waisman Core grant P30 HD003352-45, the NSF under grants IIS-1302164 and OIA-1027897.

[14] Cho, T.S., Avidan, S., Freeman, W.T.: A probabilistic image jigsaw puzzle solver. In: CVPR (2010).
