%.
%September 20, 2013.
%Nagesh Adluru.
%.
%September 16, 2013.
%Nagesh Adluru.
%Visualizing the results for comparisons using the FGM package.

clear all;
%close all;

addpath(genpath('/home/adluru/TMP_MATLAB_CODE'));
xticklabelarray={'GA';'PM';'SM';'SMAC';'IPFP-U';'IPFP-S';'RRWM';'FGM-U';'FGM-D';'SMCSP-200';'SMCSP-500';'SMCSP-800';'SMCSP-1100'};
load(sprintf('myrun_14.mat'));
run2=load('myrun_14_2.mat');
obj=[obj(:,2:end);run2.obj(:,2:end)];
objm=mean(obj,1);
objs=std(obj,[],1);
figure(1);clf(1);
bar(objm,'r');hold on;
set(gcf,'color','w');
set(gca,'fontsize',16,'fontweight','b');
errorbar(1:size(obj,2),objm,objs,'linewidth',2);
set(gca,'xtick',1:length(xticklabelarray),'xticklabel',xticklabelarray);
ylabel('Objective [arb. units]');
rotateticklabel(gca,45);
savefig(sprintf('myrun_14_2.eps'),2);

