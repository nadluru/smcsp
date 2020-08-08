%.
%May 7, 2014. 11:59 a.m. Madison.
%Nagesh Adluru. Based on SMC_CMWS_Matching in the SytheticExperiments
%folder.
%.
%August 9, 2013.
%Nagesh Adluru.

function [return_params]=SMC_CMWS_QAP(A,B,num_particle,num_proposal,print_name)

%% affinity matrix and relation matrix
%% affinity matrix size is N*M by N*M, relation matrix size is N by M, 
%% where each entry stores the vertex index of (i,j) in affinity matrix

%N will be equal to M for all the QAPLib instances.
N = size(A,1);
M = size(B,1);

AffinityMatrix = zeros(N*M,N*M);
relationMatrix = zeros(N,M);

vertexPairs = cell(1,N*M);
index = 1;
for i = 1:N
    for j = 1:M
        vertexPairs{index} = [i j];
        relationMatrix(i,j) = index;
        index = index + 1;
    end
end

for i = 1:length(vertexPairs)
    for j = 1:length(vertexPairs)
        if i~= j
            vertex1 = vertexPairs{i};
            vertex2 = vertexPairs{j};
            %AffinityMatrix(i,j) = A1(vertex1(1),vertex2(1))*A2(vertex1(2),vertex2(2));
            %AffinityMatrix(i,j)=exp(-(1-alpha_par)*((A1(vertex1(1),vertex2(1))-A2(vertex1(2),vertex2(2)))^2/denom_norm));
            AffinityMatrix(i,j)=exp(-((B(vertex1(1),vertex2(1))+B(vertex1(2),vertex2(2)))^2));%August 15, 2013.
            %AffinityMatrix(i,j)=-(1-alpha_par)*((A1(vertex1(1),vertex2(1))-A2(vertex1(2),vertex2(2)))^2/denom_norm);
        else
            vertex1=vertexPairs{i};%or vertexPairs{j}:)
            %AffinityMatrix(i,j)=exp(alpha_par*(C(vertex1(1),vertex1(2))));
            AffinityMatrix(i,j)=exp(-(A(vertex1(1),vertex1(2))));%August 15, 2013.
            %AffinityMatrix(i,j)=alpha_par*(C(vertex1(1),vertex1(2)));
        end
    end
end
%% each vertext could only have one vertext also, we assume that it should have N correspondences (N < M)
%% Particle filter
if(~exist('num_particle','var'))
num_particle = 100;
end
if(~exist('num_proposal','var'))
num_proposal = 10;
end
particles = cell(1,num_particle);
num_iteration = N-1;
%% initialization
for k = 1:num_particle
    particles{k}.contents = [2];%[2]%  3.8029 ;[1]: 15.007%% same set of points index in affinity matrix
    %% remove the connection of taken nodes in the affinity matrix
    pairPoint = vertexPairs{particles{k}.contents};
    particles{k}.takenSource = pairPoint(1);
    particles{k}.takenTarget = pairPoint(2);
    %particles{k}.AffinityMatrix(takenAffinityVertex,:) = 0;
    %particles{k}.AffinityMatrix(:,takenAffinityVertex) = 0;
    particles{k}.weight = 1/num_particle;
end

for iter = 1: num_iteration
    proposedContents = cell(0,0);
    proposedWeights = [];
    proposedAffinityMatrix = cell(0,0);
    takenSourceVec = cell(0,0);
    takenTargetVec = cell(0,0);
    for k = 1:num_particle
        fprintf('\nWorking on particle %d iteration %d with %s',k,iter,print_name);
        curContents = particles{k}.contents;
        %% calculate the affinity matrix online
        curAffinityMatrix = AffinityMatrix;
        takenSource = particles{k}.takenSource;
        takenTarget = particles{k}.takenTarget;
        takenAffinityVertex = [];
        for i = 1:length(takenSource)
            for j = 1:length(takenTarget)
                takenAffinityVertex = [takenAffinityVertex unique([relationMatrix(takenSource(i),:) relationMatrix(:,takenTarget(j))'])];
            end
        end
        takenAffinityVertex = setdiff(takenAffinityVertex,curContents);% taken pairs should be kept
        % the other pairs of nodes relates to target and source node
        curAffinityMatrix(takenAffinityVertex,:) = 0;
        curAffinityMatrix(:,takenAffinityVertex) = 0;
        curAffinityMatrix(curContents,curContents) = 0;
        %%
        ProposalWeight = sum(curAffinityMatrix(curContents,:),1);
        [SelectIdx] = resample_PF(ProposalWeight,num_proposal);
        for j = 1:num_proposal
            proContents = [curContents SelectIdx(j)];
            pairPoint = vertexPairs{SelectIdx(j)};
            takenAffinityVertex = unique([relationMatrix(pairPoint(1),:) relationMatrix(:,pairPoint(2))']);
            takenAffinityVertex = setdiff(takenAffinityVertex,proContents);
            
            propAffinityMatrix = curAffinityMatrix;
            propAffinityMatrix(takenAffinityVertex,:) = 0;
            propAffinityMatrix(:,takenAffinityVertex) = 0;
            
            WeightCluster = propAffinityMatrix(proContents,proContents);
            proposedWeights(end+1) = sum(WeightCluster(:))*particles{k}.weight;
            proposedContents{end+1} = proContents;
            takenSourceVec{end+1} = [particles{k}.takenSource pairPoint(1)];
            takenTargetVec{end+1} = [particles{k}.takenTarget pairPoint(2)];
        end
    end
    [SelectIdx] = resample_PF(proposedWeights,length(particles));
    Weight = proposedWeights(SelectIdx)/sum(proposedWeights(SelectIdx));
    %Weight(1);
    tmpParticle = cell(1,length(particles));
    for Pf_Idx = 1:length(SelectIdx)
        tmpParticle{Pf_Idx}.contents = proposedContents{SelectIdx(Pf_Idx)};
        tmpParticle{Pf_Idx}.takenSource = takenSourceVec{SelectIdx(Pf_Idx)};
        tmpParticle{Pf_Idx}.takenTarget = takenTargetVec{SelectIdx(Pf_Idx)};
        tmpParticle{Pf_Idx}.weight = Weight(Pf_Idx);
    end
    particles = tmpParticle;
end
%% extract the results with best weight
best_weight = 0;
best_index = 0;
for k = 1:length(particles)
    if best_weight < particles{k}.weight
        best_weight = particles{k}.weight;
        best_index = k;
    end
end

if(best_index==0)
    best_index=1;
end

particles{best_index}.weight
particles{best_index}.takenSource
particles{best_index}.takenTarget

%% P matrix
P = zeros(N,M);
for i = 1:length(particles{best_index}.takenSource)
    P(particles{best_index}.takenSource(i),particles{best_index}.takenTarget(i)) = P(particles{best_index}.takenSource(i),particles{best_index}.takenTarget(i))+1;
end

x=zeros(size(AffinityMatrix,1),1);
x(particles{best_index}.contents)=1;
mws=x'*AffinityMatrix*x;

QAPObj=trace(A*(P*B*P'));

return_params.particles=particles;
return_params.P=P;
return_params.AffinityMatrix=AffinityMatrix;
return_params.vertexPairs=vertexPairs;
return_params.x=x;
return_params.mws=mws;
return_params.QAPObj=QAPObj;
return