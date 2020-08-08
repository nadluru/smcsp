function [NodeReconst,NodeIdx] = PF_Inference(OriAffMatrix, PosMatrix, Start, NumParticle, NumOfProposal,N_Nodes, M_Nodes,randomFlag)
% Input matrix:
% OriAffMatrix is the 3D affinity matrix, PatchSize * PatchSize *
% Possible relative position( order is left, right, top, bottom

% PosMatrix is the relative position of the Patches, NodeSize by 4 matrix.
% Each entry is the next position, without neighbor will be set to 0.

% Start is the start label assignment

%% Initialization for both particles and affinity matrix
AffMatrix = OriAffMatrix;
BoolPosMatrix = PosMatrix>0;

Particle = cell(1,NumParticle);
%% this is for multiple initialization
if randomFlag
    for i = 1:NumParticle
    t = randperm(size(AffMatrix,1));
    Particle{i}.TakenNode = t(1);
    t = randperm(size(AffMatrix,1));
    Particle{i}.TakenLabel = t(1);
    Particle{i}.weight = 1/NumParticle;
end
else
for i = 1:NumParticle
    
    Particle{i}.TakenNode = i*5;
    Particle{i}.TakenLabel = i*5;
    Particle{i}.weight = 1/NumParticle;
end
end

%% The Main Particle Filter steps
for iter = 1:ceil(size(OriAffMatrix,1))-1
    [Particle, Weight] = PF_Inference_Body(Particle,NumOfProposal,AffMatrix,PosMatrix);

    if length(Particle{1}.TakenNode)>=size(OriAffMatrix,1)
        break;
    end
    
end
%% select the best particle
TopK = 1;
M = size(AffMatrix,1);
NodeReconst = cell(1,TopK);
[Value, OrderIDX] = sort(Weight,'descend');
for SelectIdx = 1:TopK
    Labels = zeros(1,M);
    NodeIdx = Particle{OrderIDX(SelectIdx)}.TakenNode;
    WithoutLabel = setdiff(1:M,NodeIdx);
    IdxLabel = Particle{OrderIDX(SelectIdx)}.TakenLabel;
    Labels(NodeIdx) = IdxLabel;
    nodeReconst = reshape(Labels,N_Nodes, M_Nodes); nodeReconst = nodeReconst';
    NodeReconst{1} = nodeReconst;
end