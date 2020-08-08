Num = 19;
start = 1;
load Jigsaw_MIT_Patch56_OneFix_extended.mat;

MIT_Pair = pairCorr;
MIT_Neigh = neighCorr;
MIT_Cluster = clusterCorr;

load Jigsaw_MIT_Patch56_OneFix_extended2.mat;

MIT_Pair = [MIT_Pair;pairCorr];
MIT_Neigh = [MIT_Neigh;neighCorr];
MIT_Cluster = [MIT_Cluster;clusterCorr];

[V_MIT,IDX_MIT] = sort(MIT_Pair,'ascend');
mean(V_MIT(start:Num+start,1))
mean(MIT_Neigh(IDX_MIT(start:Num+start,1),1))
mean(MIT_Cluster(IDX_MIT(start:Num+start,1),1))
%% Our results
load Jigsaw_Patch56_PF_OneFix_Extended.mat;

Our_Pair = pairCorr;
Our_Neigh = neighCorr;
Our_Cluster = clusterCorr;

load Jigsaw_Patch56_PF_OneFix_Extended2.mat;
pairCorr(2,:) = [];
neighCorr(2,:) = [];
clusterCorr(2,:) = [];

Our_Pair = [Our_Pair;pairCorr];
Our_Neigh = [Our_Neigh;neighCorr];
Our_Cluster = [Our_Cluster;clusterCorr];

mean(Our_Pair(IDX_MIT(start:Num+start,1),1))
mean(Our_Neigh(IDX_MIT(start:Num+start),1))
mean(Our_Cluster(IDX_MIT(start:Num+start),1))