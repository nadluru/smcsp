%.
%May 7, 2014. 10:51 a.m. Madison.
%Nagesh Adluru.
%Function to read a QAPLib data file.

function [F,D]=readQAPLibDat(FileName)
%% File Format
%n
%
%F
%
%D
%% Open the Text File for Reading
fid = fopen(FileName,'r');  % Open text file

%% Read n
InputText=textscan(fid,'%d\n',1);
n=InputText{1};
FormatString=repmat('%f',1,n);  
textscan(fid,'%s',1,'delimiter','\n');
InputText=textscan(fid,FormatString,n,'delimiter','\t');
F=cell2mat(InputText);
textscan(fid,'%s',1,'delimiter','\n');
InputText=textscan(fid,FormatString,n,'delimiter','\t');
D=cell2mat(InputText);
%% Close the Text File
fclose(fid);   
return