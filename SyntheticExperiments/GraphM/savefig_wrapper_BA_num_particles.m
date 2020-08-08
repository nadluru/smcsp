%.
%August 15, 2013.
%August 14, 2013.
%Nagesh Adluru.

function [mu,xmin,xmax]=savefig_wrapper_BA_num_particles(mu,xmin,xmax,legend_str,colors,title_str,xlabel_str,ylabel_str,save_fig,filename)
if(~exist('save_fig','var'))
    save_fig=false;
end
figure(1);clf(1);
set(gcf,'color','w');set(gca,'fontweight','b','fontsize',16);grid on;hold on;
for i=1:size(mu,1)
    plot([xmin(i);xmax(i)],[mu(i);mu(i)],colors{i},'linewidth',2);
end
legend(legend_str,'location','northeast');
title(title_str);xlabel(xlabel_str);ylabel(ylabel_str);
%axis(axis_limits);
if(save_fig)
    savefig(filename,2);
end
return