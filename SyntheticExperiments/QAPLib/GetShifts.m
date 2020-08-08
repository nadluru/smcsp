%. Om Sai Ram.
%May 14, 2014. 5:22 p.m. Madison.
%Nagesh Adluru.
%.
%May 12, 2014. 5:01 p.m. Madison.
%.
%May 7, 2014. 10:52 a.m. Madison.
%Nagesh Adluru.
%Reading the QAPLib data.

clear all;
close all;

qaplib_root='/home/adluru/Writing/IJCV2012/RevisionMaterial/SyntheticExperiments/QAPLib';
addpath(qaplib_root);
data_root=sprintf('%s/QAPData',qaplib_root);
results_root=sprintf('%s/QAPResultsSMCSP',qaplib_root);
cd(results_root);
result_files=dir('*_smscpQAPResults.mat');
load(sprintf('%s/missing_sln_files.mat',qaplib_root));
chrArray=[];
escArray=[];
taiArray=[];
nugArray=[];
for i=1:length(result_files)
    progInstance=sprintf('%s.dat',result_files(i).name(1:end-20));
    missing=false;
    for j=1:length(missing_sln_files)
        if(strcmpi(progInstance,missing_sln_files{j})==1)
            missing=true;
            break;
        end
    end
    if(missing)
        continue;
    end
    load(result_files(i).name);
    if(isnan(return_params.QAPObj))
        continue;
    end
    fprintf('\n progInstance: %s',progInstance(1:3));
    if(~strcmpi('chr',progInstance(1:3))==1&&~strcmpi('esc',progInstance(1:3))==1&&~strcmpi('tai',progInstance(1:3))==1&&~strcmpi('nug',progInstance(1:3))==1)
        continue;
    end
    %fprintf('\nHere...');
    if(strcmpi('chr',progInstance(1:3))==1)
      chrArray=[chrArray;return_params.QAPObj];
    end
    if(strcmpi('esc',progInstance(1:3))==1)
        escArray=[escArray;return_params.QAPObj];
    end
    if(strcmpi('tai',progInstance(1:3))==1)
        taiArray=[taiArray;return_params.QAPObj];
    end
     if(strcmpi('nug',progInstance(1:3))==1)
        nugArray=[nugArray;return_params.QAPObj];
    end
    
    if(sum(return_params.P(:))~=size(return_params.P,1))
        fprintf('\nError......');
        break;
    end
end
chr_shift=mean(chrArray);
esc_shift=mean(escArray);
tai_shift=mean(taiArray);
nug_shift=median(nugArray);
save('shifts.mat','chr_shift','esc_shift','tai_shift','nug_shift');