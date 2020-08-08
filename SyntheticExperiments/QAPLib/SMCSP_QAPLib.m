%.
%May 7, 2014. 12:11 a.m. Madison.
%.
%May 7, 2014. 10:52 a.m. Madison.
%Nagesh Adluru.
%Reading the QAPLib data.

clear all;
close all;

qaplib_root='/home/adluru/Writing/IJCV2012/RevisionMaterial/SyntheticExperiments/QAPLib';
addpath(qaplib_root);
data_root=sprintf('%s/QAPData',qaplib_root);
smcsp_result_root=sprintf('%s/QAPResultsSMCSP',qaplib_root);
cd(data_root);
files=dir('*.dat');
numQAPLibInstances=length(files);
return_params=cell(numQAPLibInstances,1);
num_prop=10;
matlabpool close force local;
matlabpool open;
%for num_par=[200 400 600 800 1000]
for num_par=800
    parfor qap_idx=1:numQAPLibInstances
        if(qap_idx==35||qap_idx==36||qap_idx==37||qap_idx==38||qap_idx==41||qap_idx==42||qap_idx==106||qap_idx==107)%Missing .sln files.
            continue;
        end
        [A,B]=readQAPLibDat(files(qap_idx).name);
        return_params{qap_idx}=SMC_CMWS_QAP(A,B,num_par,num_prop,files(qap_idx).name);
        %save(sprintf('%s/smscpQAPResults.mat',smcsp_result_root),'return_params','files');
    end
    save(sprintf('%s/smscpQAPResults.mat',smcsp_result_root),'return_params','files');
end
matlabpool(close);