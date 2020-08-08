%. %Om Sai Ram.
%May 12, 2014. 4:14 p.m. Madison.
%.
%May 7, 2014. 12:11 a.m. Madison.
%.
%May 7, 2014. 10:52 a.m. Madison.
%Nagesh Adluru.
%Reading the QAPLib data.

function SMCSP_QAPLib_condor(filename,outname)

qaplib_root='/home/adluru/Writing/IJCV2012/RevisionMaterial/SyntheticExperiments/QAPLib';
addpath(qaplib_root);
smcsp_result_root=sprintf('%s/QAPResultsSMCSP',qaplib_root);
num_prop=10;

%for num_par=[200 400 600 800 1000]
fid=fopen(sprintf('/scratch/Nagesh/Tmp/%s.log',outname),'w');
for num_par=800
    [A,B]=readQAPLibDat(filename);
    fprintf(fid,'\nStarted SMCSP for %s',filename);
    return_params=SMC_CMWS_QAP(A,B,num_par,num_prop,filename);
    save(sprintf('%s/%s_smscpQAPResults.mat',smcsp_result_root,outname(1:end-4)),'return_params');
    fprintf(fid,'\nCompleted SMCSP for %s',filename);
end
fclose(fid);
return