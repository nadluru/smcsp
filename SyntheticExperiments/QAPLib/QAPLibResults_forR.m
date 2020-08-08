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
load(sprintf('%s/smscpQAPResults_second_run.mat',results_root));
fid=fopen('SMCSPQAPResults.csv','w');
fprintf(fid,'AuthInitials,FileName,NumberOfParticles,MethodName,QAPObj');
for i=1:length(files)
    if(i==35||i==36||i==37||i==38||i==41||i==42||i==106||i==107)
        continue;
    end
    if(isempty(return_params{i}))
        continue;
    end
    if(strcmpi('chr',files(i).name(1:3))==1)
        continue;
    end
    [F,D]=readQAPLibDat(sprintf('%s/%s',data_root,files(i).name));
    [n,QAPObj,P]=readQAPLibSln(sprintf('%s/QAPSoln/%s.sln',qaplib_root,files(i).name(1:end-4)));
    fprintf('\n%d,%s, F[%d %d], D[%d %d], SMCSP: %f, QAPSln: %f',i,files(i).name,size(F,1),size(F,2),size(D,1),size(D,2),return_params{i}.QAPObj,QAPObj);    
    fprintf(fid,'\n%s,%s,%d,%s,%f',files(i).name(1:3),files(i).name(4:end-4),length(return_params{i}.particles),'SMCSP',return_params{i}.QAPObj);
    %fprintf(fid,'\n%s,%s,%d,%s,%f',files(i).name(1:3),files(i).name(4:end-4),length(return_params{i}.particles),'QAPSln',return_params{i}.QAPObj);
    fprintf(fid,'\n%s,%s,%d,%s,%f',files(i).name(1:3),files(i).name(4:end-4),length(return_params{i}.particles),'QAPSln',QAPObj);
end
fclose(fid);