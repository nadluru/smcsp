%.
%August 18, 2013.
%August 14, 2013.
%Nagesh Adluru.
%Visualizing the plots for relation between MWS and GDist objectives.
clear all;
close all;

addpath('/home/adluru/TMP_MATLAB_CODE');
addpath('/home/adluru/MVROI');
data_root='/home/adluru/Writing/IJCV2012/RevisionMaterial/SyntheticExperiments';

%% test.
A1=[1 2;2 1];
A2=[1 4;4 1];
denom_norm=norm(A1,'fro')^2+norm(A2,'fro')^2;
if(denom_norm==0)
    denom_norm=1;
end
N=size(A1,1);
vertexPairs = cell(1,N*N);
index = 1;
for i = 1:N
    for j = 1:N
        vertexPairs{index} = [i j];
        index = index + 1;
    end
end
alpha_par=0;
N = size(A1,1);
M = size(A2,1);
AffinityMatrix = zeros(N*M,N*M);
for i = 1:length(vertexPairs)
    for j = 1:length(vertexPairs)
        if i~= j
            vertex1 = vertexPairs{i};
            vertex2 = vertexPairs{j};
            %AffinityMatrix(i,j) = A1(vertex1(1),vertex2(1))*A2(vertex1(2),vertex2(2));
            %AffinityMatrix(i,j)=exp(-(1-alpha_par)*((A1(vertex1(1),vertex2(1))-A2(vertex1(2),vertex2(2)))^2/denom_norm));
            AffinityMatrix(i,j)=(1-alpha_par)*exp(-((A1(vertex1(1),vertex2(1))-A2(vertex1(2),vertex2(2)))^2/denom_norm));%August 15, 2013.
            %AffinityMatrix(i,j)=-(1-alpha_par)*((A1(vertex1(1),vertex2(1))-A2(vertex1(2),vertex2(2)))^2/denom_norm);
        else
            vertex1=vertexPairs{i};%or vertexPairs{j}:)
            %AffinityMatrix(i,j)=exp(alpha_par*(C(vertex1(1),vertex1(2))));
            AffinityMatrix(i,j)=alpha_par*exp((C(vertex1(1),vertex1(2))));%August 15, 2013.
            %AffinityMatrix(i,j)=alpha_par*(C(vertex1(1),vertex1(2)));
        end
    end
end

%Generating random solutions (i.i.d. Radamacher variables) and plot the objective values of GDist and
%MWS.
for num_samples=[10 100 1000 10000]
    MWSs=zeros(num_samples,1);
    GDists=zeros(num_samples,1);
    for i=1:num_samples
        P=zeros(N,N);
        x=iid_Radamacher(N*N);
        x(x<0)=0;
        for ix=1:length(x)
            if(x(ix)==1)
                P(vertexPairs{ix}(1),vertexPairs{ix}(2))=1;
            end
        end
        MWSs(i)=x'*AM*x;
        %GDists(i)=norm(A1-P*A2*P','fro')^2./denom_norm;
        t=exp(-((A1-P*A2*P').^2)./denom_norm);
        GDists(i)=sum(t(:));
    end
    
    figure(1);clf(1);
    set(gcf,'color','w');set(gca,'fontweight','b','fontsize',16);grid on;hold on;
    scatter(MWSs,GDists,100,'b','o','filled','MarkerEdgeColor','k');
    title(sprintf('n=%d',length(MWSs)));
    xlabel('MWS [arb. unit]');ylabel('exp(-GDist) [arb. unit]');
    savefig(sprintf('MWS_vs_GDist_2_%d.eps',num_samples),2);
end