%.
%August 12, 2013.
%Nagesh Adluru.
%Collecting the GDists from SMC-MWS.

clear all;
%close all;

addpath('/home/adluru/TMP_MATLAB_CODE');
data_root='/home/adluru/Writing/IJCV2012/RevisionMaterial/SyntheticExperiments';
%% With dummy nodes.
num_par=800;
SMC_MWS_MWS=zeros(6,1);
U_MWS=zeros(6,1);
RANK_MWS=zeros(6,1);
QCV_MWS=zeros(6,1);
PATH_MWS=zeros(6,1);
U_id=2;RANK_id=3;QCV_id=4;PATH_id=6;

i=0;
for a=1:3
    %% test.
    load(sprintf('%s/m_a_1EWK_vs_m_a_1U19_with_dummy_%d.mat',data_root,num_par));%test.
    i=i+1;SMC_MWS_MWS(i)=return_params{a}.mws;%Huh Had 1 instead of a!!! This actually prompted to think more about the exp. vs. linear etc. though!!!
    switch a
        case 1
            load('test_P.mat');
        case 2
            load('test_P_0.5.mat');
        case 3
            load('test_P_1.0.mat');
    end
    N=size(P,1);
    U_x=zeros(N*N,1);RANK_x=zeros(N*N,1);QCV_x=zeros(N*N,1);PATH_x=zeros(N*N,1);
    relationMatrix=zeros(N,N);
    index = 1;
    for ii = 1:N
        for jj = 1:N
            relationMatrix(ii,jj) = index;
            index = index + 1;
        end
    end
    for idx1=1:N
        U_x(relationMatrix(idx1,P(idx1,U_id)))=1;
        RANK_x(relationMatrix(idx1,P(idx1,RANK_id)))=1;
        QCV_x(relationMatrix(idx1,P(idx1,QCV_id)))=1;
        PATH_x(relationMatrix(idx1,P(idx1,PATH_id)))=1;
    end
    U_MWS(i)=U_x'*return_params{a}.AffinityMatrix*U_x;
    RANK_MWS(i)=RANK_x'*return_params{a}.AffinityMatrix*RANK_x;
    QCV_MWS(i)=QCV_x'*return_params{a}.AffinityMatrix*QCV_x;
    PATH_MWS(i)=PATH_x'*return_params{a}.AffinityMatrix*PATH_x;
    
    %% test_simple.
    %load(sprintf('%s/g_vs_h_with_dummy_%d.mat',data_root,num_par));%test_simple.
    load(sprintf('%s/g_vs_h_with_dummy_corrected_%d.mat',data_root,num_par));%test_simple.
    %load(sprintf('%s/g_vs_h_with_dummy_linear_%d.mat',data_root,num_par));%test_simple.
    i=i+1;SMC_MWS_MWS(i)=return_params{a}.mws;
    switch a
        case 1
            load('test_simple_P.mat');
        case 2
            load('test_simple_P_0.5.mat');
        case 3
            load('test_simple_P_1.0.mat');
    end
    N=size(P,1);
    U_x=zeros(N*N,1);RANK_x=zeros(N*N,1);QCV_x=zeros(N*N,1);PATH_x=zeros(N*N,1);
    relationMatrix=zeros(N,N);
    index = 1;
    for ii = 1:N
        for jj = 1:N
            relationMatrix(ii,jj) = index;
            index = index + 1;
        end
    end
    for idx1=1:N
        U_x(relationMatrix(idx1,P(idx1,U_id)))=1;
        RANK_x(relationMatrix(idx1,P(idx1,RANK_id)))=1;
        QCV_x(relationMatrix(idx1,P(idx1,QCV_id)))=1;
        PATH_x(relationMatrix(idx1,P(idx1,PATH_id)))=1;
    end
    U_MWS(i)=U_x'*return_params{a}.AffinityMatrix*U_x;
    RANK_MWS(i)=RANK_x'*return_params{a}.AffinityMatrix*RANK_x;
    QCV_MWS(i)=QCV_x'*return_params{a}.AffinityMatrix*QCV_x;
    PATH_MWS(i)=PATH_x'*return_params{a}.AffinityMatrix*PATH_x;
end
%% Visualization (MWS).
%Graph-1.
idx=[1 3 5];
figid=5;
figure(figid);clf(figid);
set(gcf,'color','w');set(gca,'fontweight','b','fontsize',16,'xtick',1:3,'xticklabel',{'0','0.5','1.0'});grid on;hold on;
plot(SMC_MWS_MWS(idx),'r','linewidth',2);plot(U_MWS(idx),'g','linewidth',2);plot(RANK_MWS(idx),'b','linewidth',2);plot(PATH_MWS(idx),'c','linewidth',2);
legend('SMC','Umeyama','RANK','PATH','location','northwest');
scatter(1:length(idx),SMC_MWS_MWS(idx),100,'r','^','filled','MarkerEdgeColor','k');
scatter(1:length(idx),U_MWS(idx),100,'g','s','filled','MarkerEdgeColor','k');
scatter(1:length(idx),RANK_MWS(idx),100,'b','d','filled','MarkerEdgeColor','k');
scatter(1:length(idx),PATH_MWS(idx),100,'c','o','filled','MarkerEdgeColor','k');
xlabel('\alpha [arb. unit]');ylabel('MWS [arb. unit]');title('Graph-1');

%Graph-2.
idx=[2 4 6];
figid=figid+1;
figure(figid);clf(figid);
set(gcf,'color','w');set(gca,'fontweight','b','fontsize',16,'xtick',1:3,'xticklabel',{'0','0.5','1.0'});grid on;hold on;
plot(SMC_MWS_MWS(idx),'r','linewidth',2);plot(U_MWS(idx),'g','linewidth',2);plot(RANK_MWS(idx),'b','linewidth',2);plot(PATH_MWS(idx),'c','linewidth',2);
legend('SMC','Umeyama','RANK','PATH','location','northeast');
scatter(1:length(idx),SMC_MWS_MWS(idx),100,'r','^','filled','MarkerEdgeColor','k');
scatter(1:length(idx),U_MWS(idx),100,'g','s','filled','MarkerEdgeColor','k');
scatter(1:length(idx),RANK_MWS(idx),100,'b','d','filled','MarkerEdgeColor','k');
scatter(1:length(idx),PATH_MWS(idx),100,'c','o','filled','MarkerEdgeColor','k');
xlabel('\alpha [arb. unit]');ylabel('MWS [arb. unit]');title('Graph-2');

%% Visualization (MWS Difference (SMC-X)).
%Graph-1.
idx=[1 3 5];
figid=figid+1;
figure(figid);clf(figid);
set(gcf,'color','w');set(gca,'fontweight','b','fontsize',16,'xtick',1:3,'xticklabel',{'0','0.5','1.0'});grid on;hold on;
plot(SMC_MWS_MWS(idx)-U_MWS(idx),'r','linewidth',2);plot(SMC_MWS_MWS(idx)-RANK_MWS(idx),'g','linewidth',2);plot(SMC_MWS_MWS(idx)-PATH_MWS(idx),'b','linewidth',2);
legend('SMC-Umeyama','SMC-RANK','SMC-PATH','location','northwest');
scatter(1:length(idx),SMC_MWS_MWS(idx)-U_MWS(idx),100,'r','^','filled','MarkerEdgeColor','k');
scatter(1:length(idx),SMC_MWS_MWS(idx)-RANK_MWS(idx),100,'g','d','filled','MarkerEdgeColor','k');
scatter(1:length(idx),SMC_MWS_MWS(idx)-PATH_MWS(idx),100,'b','o','filled','MarkerEdgeColor','k');
xlabel('\alpha [arb. unit]');ylabel('MWS Difference [arb. unit]');title('Graph-1');

%Graph-2.
idx=[2 4 6];
figid=figid+1;
figure(figid);clf(figid);
set(gcf,'color','w');set(gca,'fontweight','b','fontsize',16,'xtick',1:3,'xticklabel',{'0','0.5','1.0'});grid on;hold on;
plot(SMC_MWS_MWS(idx)-U_MWS(idx),'r','linewidth',2);plot(SMC_MWS_MWS(idx)-RANK_MWS(idx),'g','linewidth',2);plot(SMC_MWS_MWS(idx)-PATH_MWS(idx),'b','linewidth',2);
legend('SMC-Umeyama','SMC-RANK','SMC-PATH','location','northwest');
scatter(1:length(idx),SMC_MWS_MWS(idx)-U_MWS(idx),100,'r','^','filled','MarkerEdgeColor','k');
scatter(1:length(idx),SMC_MWS_MWS(idx)-RANK_MWS(idx),100,'g','d','filled','MarkerEdgeColor','k');
scatter(1:length(idx),SMC_MWS_MWS(idx)-PATH_MWS(idx),100,'b','o','filled','MarkerEdgeColor','k');
xlabel('\alpha [arb. unit]');ylabel('MWS Difference [arb. unit]');title('Graph-2');