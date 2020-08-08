%.
%August 14, 2013.
%Nagesh Adluru.
%Visualizing the Bland-Altman plots for GDist.
clear all;
close all;

num_par=800;
load(sprintf('SMC_MWS_GD_without_dummy_%d.mat',num_par));
load('Other_Algo_GDists_18.mat');
save_flag=true;
idx=1:18;
%SMC vs Umeyama
savefig_wrapper_BA(SMC_MWS_GD,U_GD,sprintf('n=%d, # of particles=%d',length(idx),num_par),'GDist (Avg. (SMC,Umeyama)) [arb. unit]','GDist (SMC-Umeyama) [arb. unit]',save_flag,sprintf('SMC_%d_vs_Umeyama_GD_without_dummy.eps',num_par));
savefig_wrapper_BA(SMC_MWS_GD,RANK_GD,sprintf('n=%d, # of particles=%d',length(idx),num_par),'GDist (Avg. (SMC,RANK)) [arb. unit]','GDist (SMC-RANK) [arb. unit]',save_flag,sprintf('SMC_%d_vs_RANK_GD_without_dummy.eps',num_par));
savefig_wrapper_BA(SMC_MWS_GD,QCV_GD,sprintf('n=%d, # of particles=%d',length(idx),num_par),'GDist (Avg. (SMC,QCV)) [arb. unit]','GDist (SMC-QCV) [arb. unit]',save_flag,sprintf('SMC_%d_vs_QCV_GD_without_dummy.eps',num_par));
savefig_wrapper_BA(SMC_MWS_GD,PATH_GD,sprintf('n=%d, # of particles=%d',length(idx),num_par),'GDist (Avg. (SMC,PATH)) [arb. unit]','GDist (SMC-PATH) [arb. unit]',save_flag,sprintf('SMC_%d_vs_PATH_GD_without_dummy.eps',num_par));

load('Other_Algo_GDists_18.mat');
save_flag=false;
idx=1:18;
num_par=[200 400 600 800 1000];
mu=zeros(length(num_par),4);
xmin=zeros(length(num_par),4);
xmax=zeros(length(num_par),4);
for i=1:length(num_par)
    load(sprintf('SMC_MWS_GD_without_dummy_%d.mat',num_par(i)));
    %SMC vs Umeyama
    j=1;[mu(i,j),xmin(i,j),xmax(i,j)]=savefig_wrapper_BA(SMC_MWS_GD,U_GD,sprintf('n=%d, # of particles=%d',length(idx),num_par(i)),'GDist (Avg. (SMC,Umeyama)) [arb. unit]','GDist (SMC-Umeyama) [arb. unit]',save_flag,sprintf('SMC_%d_vs_Umeyama_GD.eps',num_par(i)));
    j=2;[mu(i,j),xmin(i,j),xmax(i,j)]=savefig_wrapper_BA(SMC_MWS_GD,RANK_GD,sprintf('n=%d, # of particles=%d',length(idx),num_par(i)),'GDist (Avg. (SMC,RANK)) [arb. unit]','GDist (SMC-RANK) [arb. unit]',save_flag,sprintf('SMC_%d_vs_RANK_GD.eps',num_par(i)));
    j=3;[mu(i,j),xmin(i,j),xmax(i,j)]=savefig_wrapper_BA(SMC_MWS_GD,QCV_GD,sprintf('n=%d, # of particles=%d',length(idx),num_par(i)),'GDist (Avg. (SMC,QCV)) [arb. unit]','GDist (SMC-QCV) [arb. unit]',save_flag,sprintf('SMC_%d_vs_QCV_GD.eps',num_par(i)));
    j=4;[mu(i,j),xmin(i,j),xmax(i,j)]=savefig_wrapper_BA(SMC_MWS_GD,PATH_GD,sprintf('n=%d, # of particles=%d',length(idx),num_par(i)),'GDist (Avg. (SMC,PATH)) [arb. unit]','GDist (SMC-PATH) [arb. unit]',save_flag,sprintf('SMC_%d_vs_PATH_GD.eps',num_par(i)));
end
colors=cell(length(num_par),1);
colors{1}='r';colors{2}='g';colors{3}='b';colors{4}='c';colors{5}='k';
legend_str=cell(length(num_par),1);
for i=1:length(num_par)
    legend_str{i}=num2str(num_par(i));
end
j=1;savefig_wrapper_BA_num_particles(mu(:,j),xmin(:,j),xmax(:,j),legend_str,colors,sprintf('n=%d (effect of # of particles)',length(idx)),'GDist (Avg. (SMC,Umeyama)) [arb. unit]','GDist (SMC-Umeyama) [arb. unit]',save_flag,sprintf('SMC_vs_Umeyama_GD_num_particles.eps'));
j=2;savefig_wrapper_BA_num_particles(mu(:,j),xmin(:,j),xmax(:,j),legend_str,colors,sprintf('n=%d (effect of # of particles)',length(idx)),'GDist (Avg. (SMC,RANK)) [arb. unit]','GDist (SMC-RANK) [arb. unit]',save_flag,sprintf('SMC_vs_RANK_GD_num_particles.eps'));
j=3;savefig_wrapper_BA_num_particles(mu(:,j),xmin(:,j),xmax(:,j),legend_str,colors,sprintf('n=%d (effect of # of particles)',length(idx)),'GDist (Avg. (SMC,QCV)) [arb. unit]','GDist (SMC-QCV) [arb. unit]',save_flag,sprintf('SMC_vs_QCV_GD_num_particles.eps'));
j=4;savefig_wrapper_BA_num_particles(mu(:,j),xmin(:,j),xmax(:,j),legend_str,colors,sprintf('n=%d (effect of # of particles)',length(idx)),'GDist (Avg. (SMC,PATH)) [arb. unit]','GDist (SMC-PATH) [arb. unit]',save_flag,sprintf('SMC_vs_PATH_GD_num_particles.eps'));