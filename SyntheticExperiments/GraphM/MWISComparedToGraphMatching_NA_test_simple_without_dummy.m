%.
%August 1, 2013.
%Nagesh Adluru.
%Running Xingwei's code for IJCV.

%% use the default dataset with the graphm toolbox
%A1 = load('C:\yxw\JigsawFinal\graphm-0.52\test\m_a_1EWK');
%A2 = load('C:\yxw\JigsawFinal\graphm-0.52\test\m_a_1U19');

clear all;
close all;
root='/home/adluru/Writing/IJCV2012/RevisionMaterial/SyntheticExperiments/graphm-0.52';
graph1_name='g';
graph2_name='h';

A1 = load(sprintf('%s/test_simple/%s',root,graph1_name));
A2 = load(sprintf('%s/test_simple/%s',root,graph2_name));
C=load(sprintf('%s/test_simple/c_gh',root));
%alpha_par=[0 0.5 1.0];
alpha_par=[0.25 0.5 0.75];
matlabpool close force local;
matlabpool open;
num_prop=10;
%for num_par=[200 400 600 800 1000]
for num_par=800
    return_params=cell(length(alpha_par),1);
    parfor i=1:length(alpha_par)
        return_params{i}=SMC_CMWS_Matching(A1,A2,C,alpha_par(i),num_par,num_prop);
    end
    %save(sprintf('%s_vs_%s_without_dummy_%d.mat',graph1_name,graph2_name,num_par),'return_params','A1','A2','C','alpha_par');
    save(sprintf('%s_vs_%s_without_dummy_corrected_%d.mat',graph1_name,graph2_name,num_par),'return_params','A1','A2','C','alpha_par');
end
matlabpool close;