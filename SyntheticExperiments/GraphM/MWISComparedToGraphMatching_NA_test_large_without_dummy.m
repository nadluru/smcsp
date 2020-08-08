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

A1 = load(sprintf('%s/test_large/%s',root,graph1_name));
A2 = load(sprintf('%s/test_large/%s',root,graph2_name));
N=size(A1,1);
M=size(A2,1);
if(N>M)%Swap A1 and A2.
    tmp=A1;
    A1=A2;
    A2=tmp;
    N=size(A1,1);
    M=size(A2,1);
end
C=zeros(N,M);
alpha_par=0;
return_params{1}=SMC_CMWS_Matching(A1,A2,C,alpha_par);
save(sprintf('large_%s_vs_%s_without_dummy.mat',graph1_name,graph2_name),'return_params','A1','A2','C','alpha_par');