% fitRayleigh

clear,  clc, close all

load RayleighSeries
% load unknownSerues

% ------------------------------------------------------------

timeAxis = time_axis;       % timeAxis in s
P = PdBm;                   % P in dBm

figure,plot(timeAxis,P,'k')
title('Received power')
ylabel('Received power (dBm)')
xlabel('Elapsed time (s)')

p = 10.^(P/10);   % now p is in mW
p = p/1000;       % now p is in W

p_mean = mean(p);
10*log10(mean(p)*1e3)

p_norm = p/p_mean;     % normalize the power wrt its mean value

mean_p = mean(p_norm)

figure,plot(timeAxis,p,'k')
title('Received power')
ylabel('Received power (W)')
xlabel('Elapsed time (s)')

v = sqrt(2*50*p);

figure,plot(timeAxis,v,'k')
title('Received voltage')
ylabel('Received voltage (v)')
xlabel('Elapsed time (s)')

v_norm = sqrt(p_norm);  % normalized voltage --> variable to be analyzed

Mean = mean(v_norm)
MeanSquare = mean(v_norm.^2)  
rmsValue = sqrt(MeanSquare)

figure,plot(timeAxis,v_norm,'k')
title('Normalized received voltage')
ylabel('Normalized received voltage (v/vrms)')
xlabel('Elapsed time (s)')

[pdfX, pdfY, CDFx,CDFy, stepp] = ...
    fpdfCDFbins(v_norm, 100); % compute experimental pdf and CDF

rms = rmsValue;
CDFyTheoretical = 1 - exp(-CDFx.^2/rms^2);

figure, hold on
plot(CDFx,CDFyTheoretical,'k','LineWidth',1.0) 
plot(CDFx,CDFy,':k','LineWidth',1.5) 
% bar(CDFx,CDFy,1 ,'y')
title('Sample CDF')
ylabel('Probability the abscissa is not exceeded')
xlabel('Normalized received voltage (vnorm)')
legend('Theoretical','Sample')
ylim([0 1])

%% pdf ===============================================

[pdfX, pdfY, CDFx,CDFy, step] = ...
    fpdfCDFbins(v_norm, 20); % compute experimental pdf and CDF

pdfRayTheor = (2*pdfX/rms^2).*exp(-pdfX.^2/rms^2); 

pdfApprox = pdfRayTheor*step;

figure,hold on
plot(pdfX, pdfRayTheor, 'k', 'LineWidth',2)
bar(pdfX, pdfY, 1.0,'y')
plot(pdfX, pdfApprox, '--r', 'LineWidth',2)
title('Histogam of theoretical Rayleigh and of series')
legend('Theoretical','Histogram','Approx')
xlabel('Normalized voltage, linear')
ylabel('pdf')



