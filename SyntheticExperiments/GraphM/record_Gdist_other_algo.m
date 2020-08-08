%.
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
U_GD=zeros(18,1);
RANK_GD=zeros(18,1);
QCV_GD=zeros(18,1);
PATH_GD=zeros(18,1);
i=1;U_GD(i)=2.875058e+01;RANK_GD(i)=3.044857e+01;QCV_GD(i)=1.604798e+01;PATH_GD(i)=8.446076e+00;%test
i=2;U_GD(i)=3.400000e+01;RANK_GD(i)=3.800000e+01;QCV_GD(i)=1.400000e+01;PATH_GD(i)=6.000000e+00;%test_simple
i=3;U_GD(i)=3.794700e+05;RANK_GD(i)=3.781700e+05;QCV_GD(i)=3.624700e+05;PATH_GD(i)=3.203940e+05;
i=4;U_GD(i)=6.307300e+05;RANK_GD(i)=6.008820e+05;QCV_GD(i)=5.850540e+05;PATH_GD(i)=5.502340e+05;
i=5;U_GD(i)=5.939020e+05;RANK_GD(i)=6.234380e+05;QCV_GD(i)=5.848700e+05;PATH_GD(i)=5.493740e+05;
i=6;U_GD(i)=1.371380e+05;RANK_GD(i)=1.389740e+05;QCV_GD(i)=1.389740e+05;PATH_GD(i)=1.267020e+05;
i=7;U_GD(i)=4.207360e+05;RANK_GD(i)=4.241640e+05;QCV_GD(i)=4.227200e+05;PATH_GD(i)=4.040360e+05;
i=8;U_GD(i)=3.420000e+02;RANK_GD(i)=3.300000e+02;QCV_GD(i)=3.300000e+02;PATH_GD(i)=3.180000e+02;
i=9;U_GD(i)=2.432880e+05;RANK_GD(i)=1.748600e+05;QCV_GD(i)=1.043520e+05;PATH_GD(i)=8.717200e+04;
i=10;U_GD(i)=3.145460e+05;RANK_GD(i)=3.105060e+05;QCV_GD(i)=2.238460e+05;PATH_GD(i)=1.675420e+05;
i=11;U_GD(i)=5.921740e+05;RANK_GD(i)=5.370260e+05;QCV_GD(i)=3.871500e+05;PATH_GD(i)=2.893900e+05;
i=12;U_GD(i)=1.843980e+05;RANK_GD(i)=1.294420e+05;QCV_GD(i)=7.327800e+04;PATH_GD(i)=7.327800e+04;
i=13;U_GD(i)=3.990380e+05;RANK_GD(i)=3.114460e+05;QCV_GD(i)=2.873700e+05;PATH_GD(i)=1.419540e+05;
i=14;U_GD(i)=3.860920e+05;RANK_GD(i)=4.210840e+05;QCV_GD(i)=2.823760e+05;PATH_GD(i)=2.340000e+05;
i=15;U_GD(i)=6.521400e+05;RANK_GD(i)=4.928360e+05;QCV_GD(i)=4.546240e+05;PATH_GD(i)=3.014720e+05;
i=16;U_GD(i)=1.373988e+06;RANK_GD(i)=1.453948e+06;QCV_GD(i)=1.083528e+06;PATH_GD(i)=7.914920e+05;
i=17;U_GD(i)=1.999248e+06;RANK_GD(i)=1.928588e+06;QCV_GD(i)=1.642544e+06;PATH_GD(i)=1.132812e+06;
i=18;U_GD(i)=2.710548e+06;RANK_GD(i)=2.415644e+06;QCV_GD(i)=2.256852e+06;PATH_GD(i)=1.539196e+06;

save('Other_Algo_GDists_18.mat','U_GD','RANK_GD','QCV_GD','PATH_GD');
figure(1);clf(1);
plot(U_GD,'ro');hold on;plot(RANK_GD,'g*');plot(QCV_GD,'b.');plot(PATH_GD,'c');
set(gcf,'color','w');set(gca,'fontweight','b','fontsize',16);
xlabel('Graph-Matching-Pairs');ylabel('GDist');