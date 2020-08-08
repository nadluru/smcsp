% initMRF.m
% modified from Egon's rmNodesFromCoeffs.m
% input:  the matrix showing which numbered image segments are
%         connected to which other nodes (neighborMat).
%         The likelihood for each segment for each disparity (lhoods).
% output: nodes structure, ready to send into propNodes
%
% Modified from Bill's initMRF.m to also allow multiple (K-states) states.
%
%  Oct 1 2007
% Now, able to initialize MRFs with a global constraint
%  Oct 23 2007
%
function [AffMatrix, PosMatrix, cDU, cLR, cUD, cRL] = DataPreparation(M_Nodes, N_Nodes, K_states, compDU, compLR, logComp, noPatches, sigFac, directed, kThresh, patchRemove, patchAdd)

AffMatrix = zeros(size(compLR,1),size(compLR,2),4);
PosMatrix = zeros(size(compLR,1),4);

fprintf(1, 'Entering initMRFPatchWConst \n'); tic;                    %%

nNodes = N_Nodes * M_Nodes;
warning off all;

%%
for k = 1:length(patchAdd)
    compLR(:, end+1) = compLR(:, patchAdd(k));
    compLR(end+1,:) = compLR(patchAdd(k), :);
    compDU(:, end+1) = compDU(:, patchAdd(k));
    compDU(end+1,:) = compDU(patchAdd(k), :);
end

% Removing the patches we wanted to get rid of
compDU(patchRemove, :) = [];
compDU(:, patchRemove) = [];
compLR(patchRemove, :) = [];
compLR(:, patchRemove) = [];

cDUTemp = compDU;
cUDTemp = compDU';
cLRTemp = compLR;
cRLTemp = compLR';

cLR = zeros(size(compLR));
cRL = zeros(size(compLR));
cDU = zeros(size(compDU));
cUD = zeros(size(compDU));

compThresh = 1;
% sigFac = 2;

if(logComp == 0)
    %normalizing Compatibility Matrices
    for i = 1:noPatches
        cLR(i, :) = (cLRTemp(i, :))/sum(cLRTemp(i, :));
        cRL(i, :) = (cRLTemp(i, :))/sum(cRLTemp(i, :));
        cDU(i, :) = (cDUTemp(i, :))/sum(cDUTemp(i, :));
        cUD(i, :) = (cUDTemp(i, :))/sum(cUDTemp(i, :));
    end
else
    if(directed)
        %% Directed graph
        if(compThresh)
            
            for i = 1:noPatches
                i
                
                if(mod(i, N_Nodes) == 1)
                    [cLRTempSort, cLRSortInd] = sort(cLRTemp(i, :), 'ascend');
                    cLRSortInd(1:kThresh) = [];
                    minCLRTemp = cLRTempSort(1);
                    indMin = find(cLRTempSort == minCLRTemp);
                    cLRTempSort(indMin) = [];
                    sigComp = sigFac*sqrt(cLRTempSort(1) - minCLRTemp);
                    cLRTemp(i, :) = exp(-1*(cLRTemp(i, :) - repmat(min(cLRTemp(i, :)), size(cLRTemp(i, :))))/sigComp^2);
                    cLRTemp(i, cLRSortInd) = 0;%0.001*min(cLRTemp(i, :));
                else
                    [cLRTempSort, cLRSortInd] = sort(cLRTemp(i, :), 'ascend');
                    cLRSortInd(1:kThresh) = [];
                    minCLRTemp = cLRTempSort(1);
                    indMin = find(cLRTempSort == minCLRTemp);
                    cLRTempSort(indMin) = [];
                    sigComp = sqrt(cLRTempSort(1) - minCLRTemp);
                    cLRTemp(i, :) = exp(-1*(cLRTemp(i, :) - repmat(min(cLRTemp(i, :)), size(cLRTemp(i, :))))/sigComp^2);
                    cLRTemp(i, cLRSortInd) =0; %0.001*min(cLRTemp(i, :));
                end
                
                if(mod(i, N_Nodes) == 0)
                    [cRLTempSort, cRLSortInd] = sort(cRLTemp(i, :), 'ascend');
                    cRLSortInd(1:kThresh) = [];
                    minCRLTemp = cRLTempSort(1);
                    indMin = find(cRLTempSort == minCRLTemp);
                    cRLTempSort(indMin) = [];
                    sigComp = sigFac*sqrt(cRLTempSort(1) - minCRLTemp);
                    cRLTemp(i, :) = exp(-1*(cRLTemp(i, :) - repmat(min(cRLTemp(i, :)), size(cRLTemp(i, :))))/sigComp^2);
                    cRLTemp(i, cRLSortInd) = 0; %0.001*min(cRLTemp(i, :));
                else
                    [cRLTempSort, cRLSortInd] = sort(cRLTemp(i, :), 'ascend');
                    cRLSortInd(1:kThresh) = [];
                    minCRLTemp = cRLTempSort(1);
                    indMin = find(cRLTempSort == minCRLTemp);
                    cRLTempSort(indMin) = [];
                    sigComp = sqrt(cRLTempSort(1) - minCRLTemp);
                    cRLTemp(i, :) = exp(-1*(cRLTemp(i, :) - repmat(min(cRLTemp(i, :)), size(cRLTemp(i, :))))/sigComp^2);
                    cRLTemp(i, cRLSortInd) =0; %0.001*min(cRLTemp(i, :));
                end
                
                if(ceil(i/N_Nodes) == M_Nodes)
                    [cDUTempSort, cDUSortInd] = sort(cDUTemp(i, :), 'ascend');
                    cDUSortInd(1:kThresh) = [];
                    minCDUTemp = cDUTempSort(1);
                    indMin = find(cDUTempSort == minCDUTemp);
                    cDUTempSort(indMin) = [];
                    sigComp = sigFac*sqrt(cDUTempSort(1) - minCDUTemp);
                    cDUTemp(i, :) = exp(-1*(cDUTemp(i, :) - repmat(min(cDUTemp(i, :)), size(cDUTemp(i, :))))/sigComp^2);
                    cDUTemp(i, cDUSortInd) = 0; %0.001*min(cDUTemp(i, :));
                else
                    [cDUTempSort, cDUSortInd] = sort(cDUTemp(i, :), 'ascend');
                    cDUSortInd(1:kThresh) = [];
                    minCDUTemp = cDUTempSort(1);
                    indMin = find(cDUTempSort == minCDUTemp);
                    cDUTempSort(indMin) = [];
                    sigComp = sqrt(cDUTempSort(1) - minCDUTemp);
                    cDUTemp(i, :) = exp(-1*(cDUTemp(i, :) - repmat(min(cDUTemp(i, :)), size(cDUTemp(i, :))))/sigComp^2);
                    cDUTemp(i, cDUSortInd) =0; % 0.001*min(cDUTemp(i, :));
                end
                
                if(ceil(i/N_Nodes) == 1)
                    [cUDTempSort, cUDSortInd] = sort(cUDTemp(i, :), 'ascend');
                    cUDSortInd(1:kThresh) = [];
                    minCUDTemp = cUDTempSort(1);
                    indMin = find(cUDTempSort == minCUDTemp);
                    cUDTempSort(indMin) = [];
                    sigComp = sigFac*sqrt(cUDTempSort(1) - minCUDTemp);
                    cUDTemp(i, :) = exp(-1*(cUDTemp(i, :) - repmat(min(cUDTemp(i, :)), size(cUDTemp(i, :))))/sigComp^2);
                    cUDTemp(i, cUDSortInd) =  0; %0.001*min(cUDTemp(i, :));
                else
                    [cUDTempSort, cUDSortInd] = sort(cUDTemp(i, :), 'ascend');
                    cUDSortInd(1:kThresh) = [];
                    minCUDTemp = cUDTempSort(1);
                    indMin = find(cUDTempSort == minCUDTemp);
                    cUDTempSort(indMin) = [];
                    sigComp = sqrt(cUDTempSort(1) - minCUDTemp);
                    cUDTemp(i, :) = exp(-1*(cUDTemp(i, :) - repmat(min(cUDTemp(i, :)), size(cUDTemp(i, :))))/sigComp^2);
                    cUDTemp(i, cUDSortInd) = 0; % 0.001*min(cUDTemp(i, :));
                    
                end
            end
            
            cDU = cDUTemp.*(ones(noPatches) - eye(noPatches));
            cLR = cLRTemp.*(ones(noPatches) - eye(noPatches));
            cUD = cUDTemp.*(ones(noPatches) - eye(noPatches));
            cRL = cRLTemp.*(ones(noPatches) - eye(noPatches));
            
            for i = 1:noPatches
                cDU(i, :) = cDU(i, :)/ sum(cDU(i, :));
                cUD(i, :) = cUD(i, :)/ sum(cUD(i, :));
                cLR(i, :) = cLR(i, :)/ sum(cLR(i, :));
                cRL(i, :) = cRL(i, :)/ sum(cRL(i, :));
            end
        else
            
            for i = 1:noPatches
                cLRTemp(i, :) = exp(-1*(cLRTemp(i, :) - repmat(min(cLRTemp(i, :)), size(cLRTemp(i, :))))/sigComp^2);
                
                cRLTemp(i, :) = exp(-1*(cRLTemp(i, :) - repmat(min(cRLTemp(i, :)), size(cRLTemp(i, :))))/sigComp^2);
                
                cDUTemp(i, :) = exp(-1*(cDUTemp(i, :) - repmat(min(cDUTemp(i, :)), size(cDUTemp(i, :))))/sigComp^2);
                
                cUDTemp(i, :) = exp(-1*(cUDTemp(i, :) - repmat(min(cUDTemp(i, :)), size(cUDTemp(i, :))))/sigComp^2);
                
            end
            
            cDU = cDUTemp.*(ones(noPatches) - eye(noPatches));
            cLR = cLRTemp.*(ones(noPatches) - eye(noPatches));
            cUD = cUDTemp.*(ones(noPatches) - eye(noPatches));
            cRL = cRLTemp.*(ones(noPatches) - eye(noPatches));
            
            for i = 1:noPatches
                cDU(i, :) = cDU(i, :)/ sum(cDU(i, :));
                cUD(i, :) = cUD(i, :)/ sum(cUD(i, :));
                cLR(i, :) = cLR(i, :)/ sum(cLR(i, :));
                cRL(i, :) = cRL(i, :)/ sum(cRL(i, :));
            end
        end
    else
        
        
        %% Undirected graph
        %
        cLRTemp = cLRTemp - repmat(min(cLRTemp(:)), size(cLRTemp));
        cRLTemp = cRLTemp - repmat(min(cRLTemp(:)), size(cRLTemp));
        cDUTemp = cDUTemp - repmat(min(cDUTemp(:)), size(cDUTemp));
        cUDTemp = cUDTemp - repmat(min(cUDTemp(:)), size(cUDTemp));
        
        
        cDU = exp(-1*(cDUTemp.*(ones(noPatches)))/sigComp^2);
        cLR = exp(-1*(cLRTemp.*(ones(noPatches)))/sigComp^2);
        cUD = exp(-1*(cUDTemp.*(ones(noPatches)))/sigComp^2);
        cRL = exp(-1*(cRLTemp.*(ones(noPatches)))/sigComp^2);
        
        
        cDU = cDU.*(ones(noPatches) - eye(noPatches));
        cLR = cLR.*(ones(noPatches) - eye(noPatches));
        cUD = cUD.*(ones(noPatches) - eye(noPatches));
        cRL = cRL.*(ones(noPatches) - eye(noPatches));
    end
end


%% - Now init the nodes and the bVectors:
%% -----------------------------------------------

% nNodes +
reverse_loc = [2 1 4 3];
for n = 1:nNodes % construct the position matrix
    links = getRasterNeighbors(n, N_Nodes, M_Nodes);% its a vector to show which links to it at which direction
    for w = 1:4
        PosMatrix(n,w) = links(w);
        if links(w)~= 0 
        PosMatrix(links(w),reverse_loc(w)) = n;
        end
    end
end
% for generality, specify a propMat for each link and direction
% when w = 1, then the node we are attaching is the left node.
% When w = 2, then the node we are attaching is the right node.
% When w = 3, then the node we are attaching is the top node.
% When w = 4, then the node we are attaching is the bottom node.
AffMatrix(:,:,1) = cRL;
AffMatrix(:,:,2) = cLR;
AffMatrix(:,:,3) = cDU;
AffMatrix(:,:,4) = cUD;


