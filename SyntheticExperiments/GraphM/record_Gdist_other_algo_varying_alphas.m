%.
%August 15, 2013.
%August 12, 2013. 12:06 AM.
%Nagesh Adluru.
%Recording the Gdist from the other algorithms (Umeyama, QCV, RANK, PATH).
%Results are located in
%/home/adluru/Writing/IJCV2012/RevisionMaterial/SyntheticExperiments/graphm-0.52/test
%/home/adluru/Writing/IJCV2012/RevisionMaterial/SyntheticExperiments/graphm-0.52/test_simple
%/home/adluru/Writing/IJCV2012/RevisionMaterial/SyntheticExperiments/graphm-0.52/test_qap

clear all;
close all;

%Alpha=0
U_GD=zeros(6,1);
RANK_GD=zeros(6,1);
QCV_GD=zeros(6,1);
PATH_GD=zeros(6,1);
i=1;U_GD(i)=2.875058e+01;RANK_GD(i)=3.044857e+01;QCV_GD(i)=1.604798e+01;PATH_GD(i)=8.446076e+00;%test,alpha=0
i=2;U_GD(i)=3.400000e+01;RANK_GD(i)=3.800000e+01;QCV_GD(i)=1.400000e+01;PATH_GD(i)=6.000000e+00;%test_simple,alpha=0
i=3;U_GD(i)=2.869986e+01;RANK_GD(i)=3.097155e+01;QCV_GD(i)=3.097155e+01;PATH_GD(i)=3.097155e+01;%test,alpha=0.5
i=4;U_GD(i)=3.400000e+01;RANK_GD(i)=3.800000e+01;QCV_GD(i)=1.400000e+01;PATH_GD(i)=6.000000e+00;%test_simple,alpha=0.5
i=5;U_GD(i)=2.920463e+01;RANK_GD(i)=3.097155e+01;QCV_GD(i)=3.097155e+01;PATH_GD(i)=3.097155e+01;%test,alpha=1.0
i=6;U_GD(i)=3.400000e+01;RANK_GD(i)=3.800000e+01;QCV_GD(i)=1.400000e+01;PATH_GD(i)=6.000000e+00;%test_simple,alpha=1.0

save('Other_Algo_GDists_2x3.mat','U_GD','RANK_GD','QCV_GD','PATH_GD');
figure(1);clf(1);
plot(U_GD,'ro');hold on;plot(RANK_GD,'g*');plot(QCV_GD,'b.');plot(PATH_GD,'c');
set(gcf,'color','w');set(gca,'fontweight','b','fontsize',16);
xlabel('Graph-Matching-Pairs');ylabel('GDist');