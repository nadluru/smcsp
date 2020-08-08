%.
%May 7, 2014. 1:24 p.m. Madison.
%.
%May 7, 2014. 10:51 a.m. Madison.
%Nagesh Adluru.
%Function to read a QAPLib data file.

function [n,QAPObj,P]=readQAPLibSln(FileName)
%% File Format
%n QAPObj
%
%P

fid = fopen(FileName,'r');  % Open text file
InputText=textscan(fid,'%f\t%f\n',1);
T=cell2mat(InputText);
n=T(1);QAPObj=T(2);

%textscan(fid,'%s',1,'delimiter','\n');

%FormatString=repmat('%f',1,n);  
%InputText=textscan(fid,FormatString,1,'delimiter','\t');
%P=cell2mat(InputText);
P=[];
fclose(fid);   
return