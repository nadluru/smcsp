function Show_PF_Image(Particle, nodes,patchSize,patchSig,N_Nodes, M_Nodes,iter,imNode,noFixInd)
% show the reconstructed image by different steps of Particel Filter

M = length(nodes);
OutPathIm = ['C:\yxw\CVPR 2011\jigsawCode\jigsawCode\Results\ProposalResult\ImNo_',num2str(imNode),'_PatchSize_',num2str(patchSize)];
mkdir(OutPathIm);
OutPath = [OutPathIm,'\noFixInd_',num2str(noFixInd)];
mkdir(OutPath);
OutPathIDX = [OutPath,'\Iter_',num2str(iter)];
mkdir(OutPathIDX);
for SelectIdx = 1:length(Particle)
    Labels = zeros(1,M);
    IDX = Particle{SelectIdx}.Node;
    NodeIdx = ceil(IDX/M);
    IdxLabel = IDX-M*(NodeIdx-1);
    %[IdenticalNode, SelectedLabel] = BestLabelRKNN(NodeIdx,IdxLabel,SCORE);%
    Labels(NodeIdx) = IdxLabel;
    nodeReconst = reshape(Labels,N_Nodes, M_Nodes); nodeReconst = nodeReconst';
    
    imOutTemp = blendPatch2Im(patchSize, patchSize, M_Nodes, N_Nodes, patchSig, nodeReconst);
    imwrite(imOutTemp,[OutPathIDX '\Proposal_' num2str(SelectIdx),'.bmp']);
    %figure; imshow(imOutTemp);
end