%.
%May 7, 2014. 10:52 a.m. Madison.
%Nagesh Adluru.
%Reading the QAPLib data.

clear all;
close all;

qaplib_root='/home/adluru/Writing/IJCV2012/RevisionMaterial/SyntheticExperiments/QAPLib';
addpath(qaplib_root);
data_root=sprintf('%s/QAPData',qaplib_root);
cd(data_root);
files=dir('*.dat');
for i=1:length(files)
    if(i==35||i==36||i==37||i==38||i==41||i==42||i==106||i==107)
        continue;
    end
    [F,D]=readQAPLibDat(files(i).name);
    if(size(D,1)~=size(D,2))
    fprintf('\n%s, F[%d %d], D[%d %d]',files(i).name,size(F,1),size(F,2),size(D,1),size(D,2));
    end
    [n,QAPObj,P]=readQAPLibSln(sprintf('%s/QAPSoln/%s.sln',qaplib_root,files(i).name(1:end-4)));
end