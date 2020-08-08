%.
%August 19, 2013.
%Nagesh Adluru.

clear all;
close all;

num_par=800;
load('Other_Algo_GDists_2x4.mat');


%% Visualization (GDist).
load(sprintf('SMC_MWS_GD_with_dummy_2x4_%d.mat',num_par))
%Graph-1.
idx=[1 3 5 7];
figure(1);clf(1);
set(gcf,'color','w');set(gca,'fontweight','b','fontsize',16,'xtick',1:4,'xticklabel',{'0','0.25','0.5','0.75'});grid on;hold on;
plot(SMC_MWS_GD(idx),'r','linewidth',2);plot(U_GD(idx),'g','linewidth',2);plot(RANK_GD(idx),'b','linewidth',2);plot(PATH_GD(idx),'c','linewidth',2);
legend('SMC','Umeyama','RANK','PATH','location','southeast');
scatter(1:length(idx),SMC_MWS_GD(idx),100,'r','^','filled','MarkerEdgeColor','k');
scatter(1:length(idx),U_GD(idx),100,'g','s','filled','MarkerEdgeColor','k');
scatter(1:length(idx),RANK_GD(idx),100,'b','d','filled','MarkerEdgeColor','k');
scatter(1:length(idx),PATH_GD(idx),100,'c','o','filled','MarkerEdgeColor','k');
xlabel('\alpha [arb. unit]');ylabel('GDist [arb. unit]');title('Graph-1');
savefig('gdist_vs_alpha_test.eps',2);

%Graph-2.
idx=[2 4 6 8];
figure(2);clf(2);
set(gcf,'color','w');set(gca,'fontweight','b','fontsize',16,'xtick',1:4,'xticklabel',{'0','0.25','0.5','0.75'});grid on;hold on;
plot(SMC_MWS_GD(idx),'r','linewidth',2);plot(U_GD(idx),'g','linewidth',2);plot(RANK_GD(idx),'b','linewidth',2);plot(PATH_GD(idx),'c','linewidth',2);
legend('SMC','Umeyama','RANK','PATH','location','northeast');
scatter(1:length(idx),SMC_MWS_GD(idx),100,'r','^','filled','MarkerEdgeColor','k');
scatter(1:length(idx),U_GD(idx),100,'g','s','filled','MarkerEdgeColor','k');
scatter(1:length(idx),RANK_GD(idx),100,'b','d','filled','MarkerEdgeColor','k');
scatter(1:length(idx),PATH_GD(idx),100,'c','o','filled','MarkerEdgeColor','k');
xlabel('\alpha [arb. unit]');ylabel('GDist [arb. unit]');title('Graph-2');
savefig('gdist_vs_alpha_test_simple.eps',2);

%% Visualization (GDist Difference (SMC-X)).
%Graph-1.
idx=[1 3 5 7];
figure(3);clf(3);
set(gcf,'color','w');set(gca,'fontweight','b','fontsize',16,'xtick',1:4,'xticklabel',{'0','0.25','0.5','0.75'});grid on;hold on;
plot(SMC_MWS_GD(idx)-U_GD(idx),'g','linewidth',2);plot(SMC_MWS_GD(idx)-RANK_GD(idx),'b','linewidth',2);plot(SMC_MWS_GD(idx)-PATH_GD(idx),'c','linewidth',2);
legend('SMC-Umeyama','SMC-RANK','SMC-PATH','location','northeast');
scatter(1:length(idx),SMC_MWS_GD(idx)-U_GD(idx),100,'g','^','filled','MarkerEdgeColor','k');
scatter(1:length(idx),SMC_MWS_GD(idx)-RANK_GD(idx),100,'b','d','filled','MarkerEdgeColor','k');
scatter(1:length(idx),SMC_MWS_GD(idx)-PATH_GD(idx),100,'c','o','filled','MarkerEdgeColor','k');
xlabel('\alpha [arb. unit]');ylabel('GDist Difference [arb. unit]');title('Graph-1');
savefig('gdistdiff_vs_alpha_test.eps',2);

%Graph-2.
idx=[2 4 6 8];
figure(4);clf(4);
set(gcf,'color','w');set(gca,'fontweight','b','fontsize',16,'xtick',1:4,'xticklabel',{'0','0.25','0.5','0.75'});grid on;hold on;
plot(SMC_MWS_GD(idx)-U_GD(idx),'g','linewidth',2);plot(SMC_MWS_GD(idx)-RANK_GD(idx),'b','linewidth',2);plot(SMC_MWS_GD(idx)-PATH_GD(idx),'c','linewidth',2);
legend('SMC-Umeyama','SMC-RANK','SMC-PATH','location','northwest');
scatter(1:length(idx),SMC_MWS_GD(idx)-U_GD(idx),100,'g','^','filled','MarkerEdgeColor','k');
scatter(1:length(idx),SMC_MWS_GD(idx)-RANK_GD(idx),100,'b','d','filled','MarkerEdgeColor','k');
scatter(1:length(idx),SMC_MWS_GD(idx)-PATH_GD(idx),100,'c','o','filled','MarkerEdgeColor','k');
xlabel('\alpha [arb. unit]');ylabel('GDist Difference [arb. unit]');title('Graph-2');
savefig('gdistdiff_vs_alpha_test_simple.eps',2);