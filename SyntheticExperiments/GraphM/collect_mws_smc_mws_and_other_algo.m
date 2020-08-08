%.
%August 12, 2013.
%Nagesh Adluru.
%Collecting the GDists from SMC-MWS.

clear all;
close all;

addpath('/home/adluru/TMP_MATLAB_CODE');
data_root='/home/adluru/Writing/IJCV2012/RevisionMaterial/SyntheticExperiments';

%% With dummy nodes.
num_par=800;
SMC_MWS_MWS=zeros(18,1);
U_MWS=zeros(18,1);
RANK_MWS=zeros(18,1);
QCV_MWS=zeros(18,1);
PATH_MWS=zeros(18,1);
U_id=2;RANK_id=3;QCV_id=4;PATH_id=6;
%% test.
load(sprintf('%s/m_a_1EWK_vs_m_a_1U19_with_dummy_%d.mat',data_root,num_par));%test.
i=1;SMC_MWS_MWS(i)=return_params{1}.mws;
load('test_P.mat');
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
U_MWS(i)=U_x'*return_params{1}.AffinityMatrix*U_x;
RANK_MWS(i)=RANK_x'*return_params{1}.AffinityMatrix*RANK_x;
QCV_MWS(i)=QCV_x'*return_params{1}.AffinityMatrix*QCV_x;
PATH_MWS(i)=PATH_x'*return_params{1}.AffinityMatrix*PATH_x;

%% test_simple.
load(sprintf('%s/g_vs_h_with_dummy_%d.mat',data_root,num_par));%test_simple.
i=i+1;SMC_MWS_MWS(i)=return_params{1}.mws;
load('test_simple_P.mat');
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
U_MWS(i)=U_x'*return_params{1}.AffinityMatrix*U_x;
RANK_MWS(i)=RANK_x'*return_params{1}.AffinityMatrix*RANK_x;
QCV_MWS(i)=QCV_x'*return_params{1}.AffinityMatrix*QCV_x;
PATH_MWS(i)=PATH_x'*return_params{1}.AffinityMatrix*PATH_x;

%% test_qap.
load(sprintf('%s/test_qap_with_dummy_%d.mat',data_root,num_par));
load('test_qap_Ps.mat');
for g=1:length(return_params)
    i=i+1;SMC_MWS_MWS(i)=return_params{g}.mws;
    
    N=size(P{g},1);
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
        U_x(relationMatrix(idx1,P{g}(idx1,U_id)))=1;
        RANK_x(relationMatrix(idx1,P{g}(idx1,RANK_id)))=1;
        QCV_x(relationMatrix(idx1,P{g}(idx1,QCV_id)))=1;
        PATH_x(relationMatrix(idx1,P{g}(idx1,PATH_id)))=1;
    end
    U_MWS(i)=U_x'*return_params{g}.AffinityMatrix*U_x;
    RANK_MWS(i)=RANK_x'*return_params{g}.AffinityMatrix*RANK_x;
    QCV_MWS(i)=QCV_x'*return_params{g}.AffinityMatrix*QCV_x;
    PATH_MWS(i)=PATH_x'*return_params{g}.AffinityMatrix*PATH_x;
end

%% Visualization.
%Preliminary.
%figure;
%idx=1:18;%[1 2 8];
%plot(SMC_MWS_MWS(idx),'k');hold on;
%plot(U_MWS(idx),'ro');hold on;plot(RANK_MWS(idx),'g*');plot(QCV_MWS(idx),'b.');plot(PATH_MWS(idx),'c');

save(sprintf('SMC_MWS_MWS_with_dummy_%d.mat',num_par),'SMC_MWS_MWS');
save(sprintf('Other_Algo_MWSs_18.mat'),'U_MWS','RANK_MWS','QCV_MWS','PATH_MWS');
save_flag=true;
idx=1:18;
%SMC vs Umeyama
savefig_wrapper_BA(SMC_MWS_MWS,U_MWS,sprintf('n=%d, # of particles=%d',length(idx),num_par),'MWS (Avg. (SMC,Umeyama)) [arb. unit]','MWS (SMC-Umeyama) [arb. unit]',save_flag,sprintf('SMC_%d_vs_Umeyama_MWS.eps',num_par));
savefig_wrapper_BA(SMC_MWS_MWS,RANK_MWS,sprintf('n=%d, # of particles=%d',length(idx),num_par),'MWS (Avg. (SMC,RANK)) [arb. unit]','MWS (SMC-RANK) [arb. unit]',save_flag,sprintf('SMC_%d_vs_RANK_MWS.eps',num_par));
savefig_wrapper_BA(SMC_MWS_MWS,QCV_MWS,sprintf('n=%d, # of particles=%d',length(idx),num_par),'MWS (Avg. (SMC,QCV)) [arb. unit]','MWS (SMC-QCV) [arb. unit]',save_flag,sprintf('SMC_%d_vs_QCV_MWS.eps',num_par));
savefig_wrapper_BA(SMC_MWS_MWS,PATH_MWS,sprintf('n=%d, # of particles=%d',length(idx),num_par),'MWS (Avg. (SMC,PATH)) [arb. unit]','MWS (SMC-PATH) [arb. unit]',save_flag,sprintf('SMC_%d_vs_PATH_MWS.eps',num_par));