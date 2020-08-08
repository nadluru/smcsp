function [OldV,NewV,flag] = TargetValueEval(Cluster,OldW, NewW,Affinity)
% Evaluate the change of affinity matrix, will not change the results of
% target function

x = zeros(length(OldW),1);
for k = 1:size(Cluster,1)
    x(Cluster(k,1)) = Cluster(k,2);
end

OldV = x'*OldW*x;
NewV = x'*NewW*x;

if OldV == NewV
    flag = 1;
else
    flag = 0;
end