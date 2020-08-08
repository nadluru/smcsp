%.
%September 16, 2013.
%Nagesh Adluru.
%Visualizing the results for comparisons using the FGM package.

clear all;
close all;

addpath(genpath('/home/adluru/TMP_MATLAB_CODE'));
xticklabelarray={'GA';'PM';'SM';'SMAC';'IPFP-U';'IPFP-S';'RRWM';'FGM-U';'FGM-D';'SMCSP'};
delta=0.1;
run=1;
for num_particles=[800 500 200]
    load(sprintf('myrun_%d.mat',num_particles));
    obj=obj(:,2:end);
    objm=mean(obj,1);
    objs=std(obj,[],1);
    figure(1);clf(1);
    bar(objm,'r');hold on;
    set(gcf,'color','w');
    set(gca,'fontsize',16,'fontweight','b');
    errorbar(1:size(obj,2),objm,objs,'linewidth',2);
    %for i=1:size(obj,2)
        %h=errorbar(1-2.7*delta,objm(i),objs(i),objs(i),'color','k','linewidth',2);errorbar_tick(h,50);
        %errorbar(
    %end
%     colormap([1 0 0;0 0 1;0 1 0;0 1 1]);hold on;
%     [im_hatch,~] = applyhatch_pluscolor(gcf,'xxxx',1,[1 1 1 1],[],300,3,2);hold on;
%     imwrite(im_hatch,sprintf('%s_combined.png',prefix),'png');
    set(gca,'xtick',1:length(xticklabelarray),'xticklabel',xticklabelarray);
    ylabel('Objective [arb. units]');
    title(sprintf('RUN: %d',run));run=run+1;
    rotateticklabel(gca,45);
    savefig(sprintf('myrun_%d.eps',num_particles),2);
end
