% fitExponential

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

mean_p_norm = mean(p_norm)

figure,plot(timeAxis,p,'k')
title('Received power')
ylabel('Received power (W)')
xlabel('Elapsed time (s)')

figure,plot(timeAxis,p_norm,'k')
title('Received power')
ylabel('Normalized received power (linear) Rel to mean power')
xlabel('Elapsed time (s)')

[pdfX, pdfY, CDFx,CDFy, stepp] = ...
    fpdfCDFbins(p_norm, 100); % compute experimental pdf and CDF

CDFyTheoretical = 1 - exp(-CDFx/mean_p_norm);

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
    fpdfCDFbins(p_norm, 20); % compute experimental pdf and CDF

pdfRayTheor = (1/mean_p_norm).*exp(-pdfX/mean_p_norm); 

pdfApprox = pdfRayTheor*step;

figure,hold on
plot(pdfX, pdfRayTheor, 'k', 'LineWidth',2)
bar(pdfX, pdfY, 1.0,'y')
plot(pdfX, pdfApprox, '--r', 'LineWidth',2)
title('Histogam of theoretical Rayleigh and of series')
legend('Theoretical','Histogram','Approx')
xlabel('Normalized voltage, linear')
ylabel('pdf')
