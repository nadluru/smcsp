%.
%August 14, 2013.
%Nagesh Adluru.

function [mu,xmin,xmax]=savefig_wrapper_BA_varying_alphas(m1,m2,title_str,xlabel_str,ylabel_str,save_fig,filename)
if(~exist('save_fig','var'))
    save_fig=false;
end
figure(1);clf(1);
set(gcf,'color','w');set(gca,'fontweight','b','fontsize',16);grid on;hold on;
avg_m=(m1+m2)./2;
diff_m=(m1-m2);
xmin=min(avg_m);
xmax=max(avg_m);
mu=mean(diff_m);
sd=std(diff_m);
plot([xmin;xmax],[mu;mu],'k','linewidth',2);
plot([xmin;xmax],[mu+1.96*sd;mu+1.96*sd],'m','linewidth',2);
plot([xmin;xmax],[mu-1.96*sd;mu-1.96*sd],'m','linewidth',2);
legend({sprintf('\\mu=%.3f',mu);sprintf('\\mu\\pm1.96x\\sigma (=%.3f)',sd)},'location','northeast');
scatter(avg_m,diff_m,100,'b','^','filled','MarkerEdgeColor','k');%CB
title(title_str);xlabel(xlabel_str);ylabel(ylabel_str);


figure(1);clf(1);
bar([a1_diff a2_diff a3_diff;b_mean_within_std1 cb_mean_within_std2;ifo_mean_within_std1 ifo_mean_within_std2;unc_mean_within_std1 unc_mean_within_std2]);hold on;
set(gca,'fontweight','b','fontsize',16,'yaxislocation','left','yticklabel',{'0','0.001','0.002','0.003','0.004','0.005','0.006'},'xticklabel',{'CC','CB','IFO','UF'});hold on;
legend('NativeInNorm','Norm','location','northwest');
ylabel(ylabel_str);
delta=0.15;
% m=cc_mean_within_std1;s=cc_std_within_std1;h=errorbar(1-delta,m,s,s,'color','k','linewidth',2);errorbar_tick(h,50);m=cc_mean_within_std2;s=cc_std_within_std2;h=errorbar(1+delta,m,s,s,'color','k','linewidth',2);errorbar_tick(h,50);
% m=cb_mean_within_std1;s=cb_std_within_std1;h=errorbar(2-delta,m,s,s,'color','k','linewidth',2);errorbar_tick(h,50);m=cb_mean_within_std2;s=cb_std_within_std2;h=errorbar(2+delta,m,s,s,'color','k','linewidth',2);errorbar_tick(h,50);
% m=ifo_mean_within_std1;s=ifo_std_within_std1;h=errorbar(3-delta,m,s,s,'color','k','linewidth',2);errorbar_tick(h,50);m=ifo_mean_within_std2;s=ifo_std_within_std2;h=errorbar(3+delta,m,s,s,'color','k','linewidth',2);errorbar_tick(h,50);
% m=unc_mean_within_std1;s=unc_std_within_std1;h=errorbar(4-delta,m,s,s,'color','k','linewidth',2);errorbar_tick(h,50);m=unc_mean_within_std2;s=unc_std_within_std2;h=errorbar(4+delta,m,s,s,'color','k','linewidth',2);errorbar_tick(h,50);
colormap([0.9 0.9 0.9;0.7 0.7 0.7]);hold on;
[im_hatch,~] = applyhatch_pluscolor(gcf,'xx',1,[1 1],[],300,3,2);hold on;
imwrite(im_hatch,filename,'png');


%axis(axis_limits);
if(save_fig)
    savefig(filename,2);
end
return