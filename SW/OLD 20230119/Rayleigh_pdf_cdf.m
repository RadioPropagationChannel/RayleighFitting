
clear, clc, close all

%=======================================================================
xaxis= 0:0.1:4;
sigma=1;
%=======================================================================
pdf=Rayleighpdf(sigma,xaxis);
CDF=RayleighCDF(sigma,xaxis);
CDFx = CDF;

modalvalue = 1
standarddeviation = modalvalue*sqrt(2-pi/2)
meanvalue = modalvalue*sqrt(pi/2)
RMSvalue = modalvalue*sqrt(2)
medianvalue = modalvalue*sqrt(2*log(2))

figure,hold on
plot(xaxis,pdf,'k',xaxis,CDF,'k','LineWidth',2)
plot([modalvalue modalvalue],[0 1],'k:')
plot([standarddeviation standarddeviation],[0 1],'k:')
plot([RMSvalue RMSvalue],[0 1],'k:')
plot([medianvalue medianvalue],[0 1],'k:')
plot([meanvalue meanvalue],[0 1],'k:')

xlabel('Random variable, r')
ylabel('pdf and CDF')
title('Rayleigh distribution, mode = 1')

%=======================================================================
rms = 1;
%=======================================================================
pdf=Rayleighpdfrms(rms,xaxis);
CDF=RayleighCDFrms(rms,xaxis);


RMSvalue = 1.0

modalvalue = RMSvalue/sqrt(2);
medianvalue = RMSvalue*sqrt(log(2));
meanvalue = RMSvalue*sqrt(pi)/2;
standarddeviation = RMSvalue*sqrt(1-pi/4);

figure,hold on
plot(xaxis,pdf,'k',xaxis,CDF,'k','LineWidth',2)
plot([modalvalue modalvalue],[0 1],'k:')
plot([standarddeviation standarddeviation],[0 1],'k:')
plot([RMSvalue RMSvalue],[0 1],'k:')
plot([medianvalue medianvalue],[0 1],'k:')
plot([meanvalue meanvalue],[0 1],'k:')

xlabel('Random variable, r')
ylabel('pdf and CDF')
title('Rayleigh distribution, rms = 1')


