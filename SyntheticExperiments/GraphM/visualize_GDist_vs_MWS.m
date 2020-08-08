%.
%August 14, 2013.
%Nagesh Adluru.
%Visualizing the Bland-Altman plots for GDist.
clear all;
close all;

num_par=800;
%Loading GDists.
load(sprintf('SMC_MWS_GD_with_dummy_%d.mat',num_par));
load('Other_Algo_GDists_18.mat');
%Loading MWSs.
load(sprintf('SMC_MWS_MWS_with_dummy_%d.mat',num_par));
load(sprintf('Other_Algo_MWSs_18.mat'));

MWSs=[SMC_MWS_MWS;U_MWS;RANK_MWS;QCV_MWS;PATH_MWS];
GDists=[SMC_MWS_GD;U_GD;RANK_GD;QCV_GD;PATH_GD];

figure(1);clf(1);
set(gcf,'color','w');set(gca,'fontweight','b','fontsize',16);grid on;hold on;
scatter(MWSs,GDists,100,'b','o','filled','MarkerEdgeColor','k');
title(sprintf('n=%d',length(MWSs)));
xlabel('MWS [arb. unit]');ylabel('GDist [arb. unit]');
savefig('MWS_vs_GDist_1.eps',2);