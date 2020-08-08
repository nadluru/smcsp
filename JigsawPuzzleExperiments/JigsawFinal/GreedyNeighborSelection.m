function [Cluster] = GreedyNeighborSelection(W,Sg);

TmpW = zeros(size(W));

TmpW(Sg{1},:) = W(Sg{1},:);
TmpW(:,Sg{1}) = W(:,Sg{1});
% for k = 1:length(Sg{1})
%     TmpW(Sg{1}(k),Sg{1}(k)) = 0;
% end
[V1,NodeCandidate] = sort(sum(TmpW),'descend');
RemoveV = [];
for jj = 1:length(Sg{1})% remove the already selected nodes
    RemoveV = [RemoveV V1(NodeCandidate==Sg{1}(jj))];
    V1(NodeCandidate==Sg{1}(jj)) = [];
    NodeCandidate(NodeCandidate==Sg{1}(jj)) = [];
end
Cluster = [[Sg{1};NodeCandidate(1)] [RemoveV V1(1)]'];


