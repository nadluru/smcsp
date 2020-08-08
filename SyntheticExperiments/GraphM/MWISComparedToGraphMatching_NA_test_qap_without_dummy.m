%.
%August 9, 2013.
%.
%August 1, 2013.
%Nagesh Adluru.
%Running Xingwei's code for IJCV.

%% use the default dataset with the graphm toolbox
%A1 = load('C:\yxw\JigsawFinal\graphm-0.52\test\m_a_1EWK');
%A2 = load('C:\yxw\JigsawFinal\graphm-0.52\test\m_a_1U19');

clear all;
close all;
code_root='/home/adluru/Writing/IJCV2012/RevisionMaterial/SyntheticExperiments';
addpath(code_root);
qap_root='/home/adluru/Writing/IJCV2012/RevisionMaterial/SyntheticExperiments/graphm-0.52/test_qap';
cd(qap_root);
graph_files=dir('*.dat_1');
matlabpool close force local;
matlabpool open;
num_graph_matchings=length(graph_files);
num_prop=10;
for num_par=[200 400 600 800 1000]
    return_params=cell(num_graph_matchings,1);
    graph_pairs=cell(num_graph_matchings,1);
    parfor g=1:num_graph_matchings
        graph1_name=graph_files(g).name;
        graph2_name=[graph_files(g).name(1:end-1) '2'];
        A1 = load(sprintf('%s',graph1_name));
        A2 = load(sprintf('%s',graph2_name));
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
        alpha_par=0;%C is empty anyways.
        return_params{g}=SMC_CMWS_Matching(A1,A2,C,alpha_par,num_par,num_prop);
        graph_pairs{g}.graph1=graph1_name;
        graph_pairs{g}.graph2=graph2_name;
    end
    save(sprintf('%s/test_qap_without_dummy_%d.mat',code_root,num_par),'return_params','graph_pairs');
end
matlabpool close;
cd(code_root);