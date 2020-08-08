% k = number of states per node
% exclusive = flag for using the exclusivity term
% randInit = flag for randomized initial BP
% April 10 

function [nodes] = initBPMessagesWConst(nodes, k, exclusive, randInit)

nNodes = length(nodes);
for n = 1:nNodes
    for w = 1:nodes{n}.nLinks
        if(randInit)
            farsTemp = rand(1, k);
            farsNextTemp = rand(1, k);
            nodes{n}.links{w}.farsMessageToMe       = farsTemp/(sum(farsTemp));% random k state initialization
            nodes{n}.links{w}.fars_NEXT_MessageToMe = farsNextTemp/(sum(farsNextTemp));% random k next state initialization
        else
            nodes{n}.links{w}.farsMessageToMe       = ones(1,k);
            nodes{n}.links{w}.fars_NEXT_MessageToMe = ones(1,k);
        end
    end    
    if(exclusive)
        nodes{n}.msgFactorToMe = ones(1, k);
        nodes{n}.msgToFactor = ones(1, k);
    end
    nodes{n}.marginal = ones(1, k)/k;
end
fprintf(1, '\n');
