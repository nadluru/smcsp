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
num_par=800;
%% test.
load(sprintf('%s/m_a_1EWK_vs_m_a_1U19_with_dummy_%d.mat',data_root,num_par));%test.
AM=return_params{1}.AffinityMatrix;
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

relationMatrix=zeros(N,N);
index = 1;
for ii = 1:N
    for jj = 1:N
        relationMatrix(ii,jj) = index;
        index = index + 1;
    end
end


%Generating random solutions (i.i.d. Radamacher variables) and plot the objective values of GDist and
%MWS.
for num_samples=[10 100 1000]% 10000]
    MWSs=zeros(num_samples,1);
    GDists=zeros(num_samples,1);
    for i=1:num_samples
        P=eye(N);
        rp=randperm(N);
        P=P(rp,:);
        tmpP=zeros(N,N);
        for idx1=1:N
            tmpP(idx1,rp(idx1))=1;
        end
        x=zeros(N*N,1);
        for idx1=1:N
            x(relationMatrix(idx1,rp(idx1)))=1;
        end
        MWSs(i)=x'*AM*x;
        GDists(i)=norm(A1-P*A2*P','fro')^2./denom_norm;
        %t=exp(-((A1-P*A2*P').^2)./denom_norm);
        %GDists(i)=sum(t(:));
    end
    
    figure(1);clf(1);
    set(gcf,'color','w');set(gca,'fontweight','b','fontsize',16);grid on;hold on;
    scatter(MWSs,GDists,100,'b','o','filled','MarkerEdgeColor','k');
    title(sprintf('n=%d random permutation matrices',length(MWSs)));
    xlabel('Weight of sub-graph of A [arb. unit]');%ylabel('exp(-GDist) [arb. unit]');
    ylabel('GDist between A_1 and A_2 [arb. unit]');
    savefig(sprintf('MWS_vs_GDist_3_%d.eps',num_samples),2);
end