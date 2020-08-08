function Show_PF_Image_Best(Particle, nodes,patchSize,patchSig,N_Nodes, M_Nodes,iter,imNode,noFixInd)
% show the reconstructed image by different steps of Particel Filter


OutPathIm = ['C:\yxw\CVPR 2011\jigsawCode\jigsawCode\Results\ParticleIteration\ImNo_',num2str(imNode),'_PatchSize_',num2str(patchSize)];
mkdir(OutPathIm);
OutPath = [OutPathIm,'\noFixInd_',num2str(noFixInd)];
mkdir(OutPath);


M = length(nodes);
Weights = zeros(1,length(Particle));
for SelectIdx = 1:length(Particle)
    Weights(SelectIdx) = Particle{SelectIdx}.weight;
end

[P, bestIdx] = max(Weights);

Labels = zeros(1,M);
IDX = Particle{bestIdx}.Node;
NodeIdx = ceil(IDX/M);
IdxLabel = IDX-M*(NodeIdx-1);
%[IdenticalNode, SelectedLabel] = BestLabelRKNN(NodeIdx,IdxLabel,SCORE);%
Labels(NodeIdx) = IdxLabel;
nodeReconst = reshape(Labels,N_Nodes, M_Nodes); nodeReconst = nodeReconst';

imOutTemp = blendPatch2Im(patchSize, patchSize, M_Nodes, N_Nodes, patchSig, nodeReconst);
%figure; imshow(imOutTemp);
imwrite(imOutTemp,[OutPath '\Iter_' num2str(iter),'.bmp']);