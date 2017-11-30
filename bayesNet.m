N = 4; 
dag = zeros(N,N);

% number the nodes
C = 1; S = 2; R = 3; W = 4;

% create relationships, must be ordered from parent to child
dag(C,[R S]) = 1;
dag(R,W) = 1;
dag(S,W)=1;

% define the size of each node (ie. node 1 has 4  possibilities)
node_sizes = [4 2 3 5];

% make the BNET (assuming that all nodes are discrete)
bnet = mk_bnet(dag, node_sizes);

G = bnet.dag;
draw_graph(G);

CPT = reshape([1 0.1 0.1 0.01 0 0.9 0.9 0.99], [2 2 2]);

