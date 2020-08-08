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
fid=fopen(sprintf('%s/SMCSPQAPResultsFromCondor.csv',qaplib_root),'w');
fprintf(fid,'AuthInitials,Size,NumberOfParticles,MethodName,QAPObj');
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
%     if(strcmpi('chr',progInstance(1:3))==1)
%         continue;
%     end
    load(result_files(i).name);
    if(isnan(return_params.QAPObj))
        continue;
    end
    [F,D]=readQAPLibDat(sprintf('%s/%s',data_root,progInstance));
    [n,QAPObj,P]=readQAPLibSln(sprintf('%s/QAPSoln/%s.sln',qaplib_root,progInstance(1:end-4)));
    fprintf('\n%d,%s, F[%d %d], D[%d %d], SMCSP: %f, QAPSln: %f, Percentage: %f',i,progInstance,size(F,1),size(F,2),size(D,1),size(D,2),return_params.QAPObj,QAPObj,(return_params.QAPObj-QAPObj)/QAPObj*100);
    progSize=progInstance(4:end-4);
    if(progSize(end)=='a')
        progSize(end)=[];
    end
    if(sum(return_params.P(:))~=size(return_params.P,1))
        fprintf('\nError......');
        break;
    end
    fprintf(fid,'\n%s,%s,%d,%s,%f',progInstance(1:3),progSize,length(return_params.particles),'SMCSP',return_params.QAPObj);
    fprintf(fid,'\n%s,%s,%d,%s,%f',progInstance(1:3),progSize,length(return_params.particles),'QAPSln',QAPObj);
end
fclose(fid);