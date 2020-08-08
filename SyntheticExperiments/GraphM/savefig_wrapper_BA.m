%.
%August 14, 2013.
%Nagesh Adluru.

function [mu,xmin,xmax]=savefig_wrapper_BA(m1,m2,title_str,xlabel_str,ylabel_str,save_fig,filename)
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
%axis(axis_limits);
if(save_fig)
    savefig(filename,2);
end
return