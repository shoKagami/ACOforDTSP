function PlotHistogram(StaBestSol,DynBestSol,HPTour,model,aL)
it=10000;
N=model.n;
for i=1:it
RealTour.Sta = SkipTour(StaBestSol,HPTour.Sta);
Cost.Sta = TourLength(RealTour.Sta,model);
RealTour.Dyn = SkipTour(DynBestSol,HPTour.Dyn);
Cost.Dyn = TourLength(RealTour.Dyn,model);
h1(1,i)=Cost.Sta;
h2(1,i)=Cost.Dyn;
n1(1,i)=numel(RealTour.Sta);
n2(1,i)=numel(RealTour.Dyn);
c1(1,i)=StaBestSol.Lcost+(N-n1(1,i))*aL;
c2(1,i)=h2(1,i)+(N-n2(1,i))*aL;
end
figure('Position',[180 0 1200 960])
% f1=subplot(2,3,1);
% hist1=histogram(h1);
% title('Static Length Histogram')
% xlabel(f1,'Length')
% ylabel(f1,'freauency')
% 
% f2=subplot(2,3,2);
% hist2=histogram(h2);
% title('Dynamic Length Histogram')
% xlabel(f2,'Length')
% ylabel(f2,'freauency')

% FontSize
F=20;
f3=subplot(1,3,1);
% hist1=histogram(h1);
bar(StaBestSol.Lcost,800,400);
hold on
hist2=histogram(h2);
title('���s����','FontSize',F)
xlabel(f3,'���s����','FontSize',F)
ylabel(f3,'�p�x�i��j','FontSize',F)
legend({['�]����@�F���� ',num2str(round(StaBestSol.Lcost))],['��Ď�@�F���� ',num2str(round(mean(h2)))]},'FontSize',F)

f6=subplot(1,3,2);
hist3=histogram(n1);
hold on
hist4=histogram(n2);
title('�z�B������','FontSize',F)
xlabel(f6,'�z�B������','FontSize',F)
ylabel(f6,'�p�x�i�j','FontSize',F)
legend({['�]����@�F���� ',num2str(round(mean(n1)))],['��Ď�@�F���� ',num2str(round(mean(n2)))]},'FontSize',F)

f4=subplot(1,3,3);
hist5=histogram(c1);
hold on
hist6=histogram(c2);
title('�]���l��r','FontSize',F)
xlabel(f4,'�]���l[m]','FontSize',F)
ylabel(f4,'�p�x(��)','FontSize',F)
legend({['�]����@�F���� ',num2str(round(mean(c1)))],['��Ď�@�F���� ',num2str(round(mean(c2)))]},'FontSize',F)


saveas(gcf,[pwd '/output/CompareHistogram.png'])

% %% 
% for i=1:2000
% RealTour.Sta = SkipTour(StaBestSol,HPTour.Sta);
% Cost.Sta = RealCostFunction(RealTour.Sta,model,aL);
% RealTour.Dyn = SkipTour(DynBestSol,HPTour.Sta);
% Cost.Dyn = RealCostFunction(RealTour.Dyn,model,aL);
% h(1,i)=Cost.Dyn/Cost.Sta;
% end
% M=mean(h);
% V=var(h);
% S=skewness(h);
% figure
% hist = histogram(h);
% title({'Ratio  Dynamic/Static Cost ';strcat('Mean: ',num2str(M),' Variance: ',num2str(V),' Skewness: ',num2str(S))})
% hist.Normalization = 'probability';
% 

end