% in this version, the initialization labels could be increased.

clear;
close all;
%% load image
noBPIter = 3;           % This number specifies, at the currently fixed patch configuration, how many times we want to run BP to reconstruct an image.
noFixStep = [1 :3];   % This number specifies how many patches to fix to correct locations when we reconstruct the image
nIter = 100;            % The number of BP iterations
randInit = 1;           % Random BP message initialization

totalPair = cell(0,0);
totalCluster = cell(0,0);
totalNeighbor = cell(0,0);

for NumParticle = 200:1000;

    NumParticle
pairCorr = zeros(20,length(noFixStep));   % For measuring the correct image reconstruction rate according to pair-wise correct measure
clusterCorr = zeros(20,length(noFixStep));% For measuring the correct image reconstruction rate according to cluster-wise correct measure
neighCorr = zeros(20,length(noFixStep));  % For measuring the correct image reconstruction rate according to neighbor-wise correct measure
ReConstructImage = cell(20,length(noFixStep));%For storing the reconstructed image



NumOfProposal =3;
Ifsure = 1;
for noFixInd = 1:length(noFixStep)
   
    for imNo = 1:20
        %% change the directory accordingly
        imName =['C:\yxw\JigsawFinal\imData\', num2str(imNo), '.png'];
        imSize =round(1.35*[375, 500]);
        inputImT = im2double(imread(imName));
        
        % Image resizing
        inputIm = imresize(inputImT(:, :, 1), imSize, 'bicubic');
        inputIm(:, :, 2) = imresize(inputImT(:, :, 2), imSize, 'bicubic');
        inputIm(:, :, 3) = imresize(inputImT(:, :, 3), imSize, 'bicubic');
        
        %% Image cutting, evidence and compatibility computation
        
        patchSize = 56;% This parameter cannot be changed at the version with Evidence. The reason is the step of reconstruction needs the size fixed
        %patchSize = 48;
        sz = size(inputIm);
        M_patches = floor(sz(1)/patchSize);
        N_patches = floor(sz(2)/patchSize);
        noPatches =  M_patches*N_patches;
        inputIm = inputIm(1:M_patches*patchSize, 1:N_patches*patchSize, :);
        
        % Cutting the image into patches
        inputImGray = rgb2gray(inputIm);
        inputImNTSCT = rgb2ntsc(inputIm);
        
        % normalizing the NTSC channels to equalize the variance
        inputImNTSC = inputImNTSCT(:, :, 1);
        inputImNTSC(:, :, 2) = 7*inputImNTSCT(:, :, 2);
        inputImNTSC(:, :, 3) = 7*inputImNTSCT(:, :, 3);
        
        % Gridding into patches
        patchGray = cutImintoPatch(patchSize, patchSize, N_patches, M_patches, inputImGray);
        patchNTSC = cutImintoPatchRGB(patchSize, patchSize, N_patches, M_patches, inputImNTSC);
        patch = cutImintoPatchRGB(patchSize, patchSize, N_patches, M_patches, inputIm);
        
        % image resizing for evidence/cluster estimation
        inputImS = imresize(inputIm, 7/28);
        patchDown = cutImintoPatchRGBOverlap(7, N_patches, M_patches, 0, inputImS);
        
        % computing the naive energy for the compatibility
        tic;
        [x,y, DUClrDist, LRClrDist] = compCompatibilityColor(patchNTSC, patchSize, noPatches);
        toc;
        
        compDU = DUClrDist;
        compLR = LRClrDist;
        
        % no evidence for these experiments
        evidence = [];
        probMap = [];
        
        %% Finding patch label
        
        % Loading the global clusters
        clusterFileName = sprintf('%s%s%s%s%s', './data/globalClusterColorFastSub_200.mat');
        load(clusterFileName);
        
        % Loading the PCA components
        eigenCompFileName = sprintf('%s%s%s%s%s', './data/PCA_ColorFast.mat');
        load(eigenCompFileName);
        
        noImagesClusterName = sprintf('%s%s%s%s%s', './data/noImages.mat');
        load(noImagesClusterName);
        
        % Specifying the number of clusters
        noCluster =200;
        
        % Projecting all patches onto the PCA basis
        imDatasetTest = patchRas(patchDown);
        imDatasetTestPCA = EigenComp'*(imDatasetTest - repmat(meanVec, 1, size(imDatasetTest, 2)));
        
        % taking the top 22 coefficients (98% variance)
        imDatasetTestPCAT = imDatasetTestPCA(1:22, :);
        
        % Computing the distance between the patch representation to the
        % cluster centers
        distanceVec = zeros(noPatches, noCluster);
        for i = 1:noCluster
            distanceVec(:, i) = calcdist(imDatasetTestPCAT',centers(i, :));
        end
        
        % assign each patch to one of the 200 clusters
        [minDistanceTest, minDistInd]= min(distanceVec, [], 2);
        patchLabel = reshape(minDistInd, [N_patches, M_patches])';
        
        clusterLabelOrig = minDistInd;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% running BP to reconstruct the image
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        M_Nodes = M_patches; % the number of vertical nodes
        N_Nodes = N_patches; % the number of horizontal nodes
        kStates = noPatches;
        exclusive = 1;
        sigEvid = 0.4;       % the sigma value for local evidence
        maxProductFlag =0;
        
        withEvidence = 0;    % without local evidence
        likeClr = [];
        sigClr = 1;
        likeClrOn = 0;
        blend = 1;
        alpha = 0.5;
        sigExcl = 1;
        overlap = 0;
        
        patchDet = [];
        patchAdd =[];
        patchRemove = [];
        patchMoveTo = [];
        patchMoveFrom = [];
        directed = 1;
        kThresh = noPatches;
        sigColor = 0.25;
        logComp = 1;
        
        
        corrPatchTemp = reshape([1:noPatches], [N_patches, M_patches])';
        
        
        K_states = noPatches;
        [AffMatrix, PosMatrix] = DataPreparation(M_Nodes, N_Nodes, K_states, compDU, compLR, 1, noPatches, 1, 1, noPatches, [], []);
        
        patchFixOrig = 1;% not useful for multiple initialization
        % Particle Filter
        random_flag = 1;
        [NodeReconst,NodeIdx] = PF_Inference(AffMatrix, PosMatrix, patchFixOrig, NumParticle, NumOfProposal,N_Nodes, M_Nodes,random_flag);
        
        RIdx = 1;
        nodeReconst = NodeReconst{RIdx};
        patchFix = NodeIdx(1);
        
        % For coloring the anchor patches
        patchSig = patch;
        sigP = zeros(patchSize, patchSize, 3);
        sigP(:, :, 1) = ones(patchSize);
        
        for sigL = 1:length(patchFix)
            patchSig(:, :, :, patchFix(sigL)) = 0.5*patch(:, :, :, patchFix(sigL)) + 0.5*sigP;
        end
        
        
        
        imOutTemp = blendPatch2Im(patchSize, patchSize, M_Nodes, N_Nodes, patchSig, nodeReconst);
        %figure, imshow(imOutTemp)
        %   end
        
        %% Compute scores
        [pairCorrOut, clusterCorrOut, neighCorrOut] = scoreCompute(nodeReconst, noPatches, M_patches, N_patches, patchLabel, corrPatchTemp, clusterLabelOrig);
        pairCorr(imNo,noFixInd) = pairCorrOut;
        clusterCorr(imNo,noFixInd) = clusterCorrOut;
        neighCorr(imNo,noFixInd) = neighCorrOut;
        ReConstructImage{imNo,noFixInd} = imOutTemp;
        
        close all
    end
end

totalPair{end+1} = pairCorr;
totalCluster{end+1} = clusterCorr;
totalNeighbor{end+1} = neighCorr;
end

NumTry = length(totalPair);
mean_N_performance_pair = zeros(1,NumTry);
best_N_performance_pair = zeros(1,NumTry);
mean_N_performance_cluster = zeros(1,NumTry);
best_N_performance_cluster = zeros(1,NumTry);
mean_N_performance_neighbor = zeros(1,NumTry);
best_N_performance_neighbor = zeros(1,NumTry);

for i = 1:length(totalPair)
    mean_pair = mean(totalPair{i},2);
    mean_cluster = mean(totalCluster{i},2);
    mean_neighbor = mean(totalNeighbor{i},2);
    
    mean_N_performance_pair(i) = mean(mean_pair);
    mean_N_performance_cluster(i) = mean(mean_cluster);
    mean_N_performance_neighbor(i) = mean(mean_neighbor);
    
    best_N_performance_pair(i) = max(mean_pair);
    best_N_performance_cluster(i) = max(mean_cluster);
    best_N_performance_neighbor(i) = max(mean_neighbor);
end

display('mean performance from N = 200 to N = 1000 with 200 interval');
N = 200;
for i = 1:NumTry
    display(strcat('Mean: N = ', num2str(N) , '; pair score = ',num2str(mean_N_performance_pair(i)),'; cluster score = ', ...
        num2str(mean_N_performance_cluster(i)),'; neighbor score = ', num2str(mean_N_performance_neighbor(i))));
    
    display(strcat('Best: N = ', num2str(N) , '; pair score = ',num2str(best_N_performance_pair(i)),'; cluster score = ', ...
        num2str(best_N_performance_cluster(i)),'; neighbor score = ', num2str(best_N_performance_neighbor(i))));
end