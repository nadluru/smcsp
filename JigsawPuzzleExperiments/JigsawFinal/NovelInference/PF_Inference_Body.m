function [tmpParticle,Weight] = PF_Inference_Body(Particle,OriNumOfProposal,OriAffMatrix,OriPosMatrix);
% Input: 
% Particle: the current particles
% OriNumOfProposal: Number of proposal for each particle
% OriAffMatrix: Affinity matrix for all the data
% OriPosMatrix: Position matrix for all the data

% Output:
% tmpParticle: The particles after resampling
% Weight: the weight for each particle

NewParticle = cell(0,0);
Weight = [];
for PF_Idx = 1:length(Particle)
    TakenNode = Particle{PF_Idx}.TakenNode;
    TakenLabel = Particle{PF_Idx}.TakenLabel;
    weight = Particle{PF_Idx}.weight;
    RemainLabel = setdiff(1:size(OriAffMatrix,1),TakenLabel);
    RemainNode = setdiff(1:size(OriAffMatrix,1),TakenNode);
    
    %% update the matrix from its original each time
    AffMatrix = OriAffMatrix;
    PosMatrix = OriPosMatrix;
  
    for tmp_node = TakenNode
        [IdxLoc,IdxNei] = find(PosMatrix == tmp_node);
        for idx_rmv = 1:length(IdxLoc)
            PosMatrix(IdxLoc(idx_rmv),IdxNei(idx_rmv)) = 0;% the taken node should not be considered any more
        end
    end
    
    BoolPosMatrix = PosMatrix>0;
    
    %% Proposal and Evaluation step
    CandidateNode = [];
    PossibleProb = [];
    reverseLoc = [2 1 4 3];
    for idx_node = 1:length(TakenNode) % each particle generate all the possible followers and then select the proposals from them
        cur_node = TakenNode(idx_node);
        cur_label = TakenLabel(idx_node);
        
        LabelSize = length(RemainLabel);
        PossibleLoc = find(BoolPosMatrix(cur_node,:)>0);% the neighor which can be considered
        LocIdx = PosMatrix(cur_node,PossibleLoc);% the exact location
        for idx_pos_loc = 1:length(LocIdx)
            TmpProbVec = [];
            ExactLoc = LocIdx(idx_pos_loc);
            if sum(CandidateNode == ExactLoc)
                %% the location is adjacent to two and more taken positions
                same_idx = find(CandidateNode == ExactLoc);
                for idx_label = 1:length(RemainLabel)
                  
                   % PossibleProb(same_idx,idx_label) = PossibleProb(same_idx,idx_label) + AffMatrix(RemainLabel(idx_label),cur_label,PossibleLoc(idx_pos_loc));
                   PossibleProb(same_idx,idx_label) = PossibleProb(same_idx,idx_label) + (AffMatrix(RemainLabel(idx_label),cur_label,PossibleLoc(idx_pos_loc))+AffMatrix(cur_label,RemainLabel(idx_label),reverseLoc(PossibleLoc(idx_pos_loc))))/2; %#ok<AGROW>
                 
                end
            else
                for idx_label = 1:length(RemainLabel)
                  
                   % TmpProbVec(end+1) = eps+AffMatrix(RemainLabel(idx_label),cur_label,PossibleLoc(idx_pos_loc));
                   TmpProbVec(end+1) = eps+(AffMatrix(RemainLabel(idx_label),cur_label,PossibleLoc(idx_pos_loc))+AffMatrix(cur_label,RemainLabel(idx_label),reverseLoc(PossibleLoc(idx_pos_loc))))/2;
                  
                end
                PossibleProb = [PossibleProb;TmpProbVec(:)'];
                CandidateNode = [CandidateNode;ExactLoc];
            end
        end
    end
    
 
    TotalProb = PossibleProb';
    TotalProb = TotalProb(:);
    NumOfProposal = min(OriNumOfProposal,length(TotalProb));% Number of Proposal should not be larger than remaining choices
    [V1,NodeCandidate] = sort(TotalProb,'descend');
    
    V1 = V1(1:NumOfProposal);
    NodeCandidate = NodeCandidate(1:NumOfProposal);
    
    [SelectIdx] = resample_PF(V1,NumOfProposal);
    for NewIdx = 1:NumOfProposal
        inter_idx = ceil(NodeCandidate(SelectIdx(NewIdx))/LabelSize);
        select_node = CandidateNode(inter_idx);
        NewTakenNode = [TakenNode select_node];
        inter_label = NodeCandidate(SelectIdx(NewIdx)) - (inter_idx-1)*LabelSize;
        select_label = RemainLabel(inter_label);
        NewTakenLabel = [TakenLabel select_label];
        
        NewParticle{end+1}.TakenNode = NewTakenNode;
        NewParticle{end}.TakenLabel = NewTakenLabel;
        
        Weight(end+1) = weight*V1(SelectIdx(NewIdx));
        
    end
    
end

Weight = Weight/sum(Weight);

[SelectIdx] = resample_PF(Weight,length(Particle));
Weight = Weight(SelectIdx)/sum(Weight(SelectIdx));
tmpParticle = cell(1,length(Particle));
for Pf_Idx = 1:length(SelectIdx)
    
    tmpParticle{Pf_Idx}.TakenNode = NewParticle{SelectIdx(Pf_Idx)}.TakenNode;
    tmpParticle{Pf_Idx}.TakenLabel =NewParticle{SelectIdx(Pf_Idx)}.TakenLabel;
    tmpParticle{Pf_Idx}.weight = Weight(Pf_Idx);
end
