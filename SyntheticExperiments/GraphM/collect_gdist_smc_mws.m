%.
%August 12, 2013.
%Nagesh Adluru.
%Collecting the GDists from SMC-MWS.

clear all;
close all;

data_root='/home/adluru/Writing/IJCV2012/RevisionMaterial/SyntheticExperiments';

%% Without dummy nodes.
for num_par=[200 400 600 800 1000];
    SMC_MWS_GD=zeros(18,1);
    load(sprintf('%s/m_a_1EWK_vs_m_a_1U19_without_dummy_%d.mat',data_root,num_par));%test.
    i=1;SMC_MWS_GD(i)=return_params{1}.Gdist;
    load(sprintf('%s/g_vs_h_without_dummy_%d.mat',data_root,num_par));%test_simple.
    i=2;SMC_MWS_GD(i)=return_params{1}.Gdist;
    load(sprintf('%s/test_qap_without_dummy_%d.mat',data_root,num_par));%test_qap.
    for g=1:length(return_params)
        i=i+1;SMC_MWS_GD(i)=return_params{g}.Gdist;
    end
    save(sprintf('SMC_MWS_GD_without_dummy_%d.mat',num_par),'SMC_MWS_GD');
end


%% With dummy nodes.
for num_par=[200 400 600 800];
    SMC_MWS_GD=zeros(18,1);
    load(sprintf('%s/m_a_1EWK_vs_m_a_1U19_with_dummy_%d.mat',data_root,num_par));%test.
    i=1;SMC_MWS_GD(i)=return_params{1}.Gdist;
    load(sprintf('%s/g_vs_h_with_dummy_%d.mat',data_root,num_par));%test_simple.
    i=2;SMC_MWS_GD(i)=return_params{1}.Gdist;
    load(sprintf('%s/test_qap_with_dummy_%d.mat',data_root,num_par));%test_qap.
    for g=1:length(return_params)
        i=i+1;SMC_MWS_GD(i)=return_params{g}.Gdist;
    end
    save(sprintf('SMC_MWS_GD_with_dummy_%d.mat',num_par),'SMC_MWS_GD');
end

%figure;
%plot(SMC_MWS_GD([1 2 8]),'k');hold on;
%plot(U_GD([1 2 8]),'ro');hold on;plot(RANK_GD([1 2 8]),'g*');plot(QCV_GD([1 2 8]),'b.');plot(PATH_GD([1 2 8]),'c');