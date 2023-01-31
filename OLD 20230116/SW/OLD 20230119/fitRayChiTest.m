%
% fitRayleigh

clear,  clc, close all

% load RayleighSeries
% load unknownSeries
load reminderSeries
% ------------------------------------------------------------

timeAxis = time_axis;       % timeAxis in s
P = PdBm;                   % P in dBm

ts = timeAxis(2) - timeAxis(1);

figure,plot(timeAxis,P,'k')
title('Received power')
ylabel('Received power (dBm)')
xlabel('Elapsed time (s)')

p = 10.^(P/10);   % now p is in mW
p = p/1000;       % now p is in W

p_mean = mean(p);
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

v_norm = sqrt(p_norm);    % normalize voltage wrt rms value

Mean = mean(v_norm)
MeanSquare = mean(v_norm.^2)  
rmsValue = sqrt(MeanSquare)

figure,plot(timeAxis,v_norm,'k')
title('Normalized received voltage')
ylabel('Normalized received voltage (v/vrms)')
xlabel('Elapsed time (s)')

[pdfX, pdfY, CDFx, CDFy, stepp] = ...
    fpdfCDFbins(v_norm, 100); % compute experimental pdf and CDF

rms = rmsValue;
CDFyTheoretical = 1 - exp(-CDFx.^2/rms^2);

figure, hold on
plot(CDFx,CDFyTheoretical,'k', 'LineWidth', 1.0) 
plot(CDFx,CDFy,'k:', 'LineWidth', 1.5) 
title('Sample CDF')
ylabel('Probability the abscissa is not exceeded')
xlabel('Normalized received voltage (v/vrms)')
legend('Theoretical','Sample')
ylim([0 1])

% Chi-Square test 1st try ===============================================

Nbins = 10;
[HvnormY, HvnormX] = hist(v_norm, Nbins);
step = HvnormX(2) - HvnormX(1);
end1 = HvnormX - step/2;
end2 = HvnormX + step/2;

HvnormYtheoretical = ...
    exp(-(end1.^2)./(rms^2))-exp(-(end2.^2)./(rms^2));

HvnormYtheoretical = ...
    HvnormYtheoretical*length(v_norm);  % convert to counts

figure,hold on
bar(HvnormX,HvnormYtheoretical,0.8,'y')
bar(HvnormX,HvnormY,0.2,'r')
% hold off
title('Histogam of theoretical Rayleigh and of series')
legend('Theoretical','Sample')
xlabel('Normalized signal level')
ylabel('Bin frecuencies')

% Chi-Square parameter ================================================

D2 = sum((HvnormYtheoretical - HvnormY).^2./HvnormYtheoretical)

df = (Nbins - 1) - 1; % reduce DOFs by 1 as we extracted rms value from data

alpha = 100*(1 - gammainc(0.5*D2,0.5*df)) % significance level %

%% check autocorrelation

autoCorr = xcov(v_norm, v_norm, 'coeff');
corrAxis = ((1:length(v_norm)*2-1) -length(v_norm))*ts;
figure, plot(corrAxis, autoCorr,'k', 'LineWidth', 1.5)
xlabel('Time lag, s')
ylabel('Autocorrelation function')
xlim([-10 10])

%% check autocorrelation

autoCorr = xcov(v_norm, v_norm, 'coeff');
corrAxis = ((1:length(v_norm)*2-1) -length(v_norm));
figure, plot(corrAxis, autoCorr,'k', 'LineWidth', 1.5)
xlabel('Time lag, Samples')
ylabel('Autocorrelation function')
xlim([-10 10])

%% Decimation
v_norm_dec = v_norm(1:5:length(v_norm));

mean(v_norm_dec.^2)

[~, ~, CDFx_dec,CDFy_dec, stepp] = ...
    fpdfCDFbins(v_norm_dec, 200); % compute experimental pdf and CDF
figure
AxesH = axes('NextPlot', 'add');  % Equivalent to: hold('on')
% figure
% AxesH = axes('add'); %('NextPlot', 'add');  % Equivalent to: hold('on')
% figure, hold on
% loglog(CDFx(2:end),CDFy(2:end),'k')
% loglog(CDFx_dec(3:end),CDFy_dec(3:end),'*k')
plot(CDFx(2:end),CDFy(2:end),'k', 'LineWidth',1.5)
plot(CDFx_dec(3:end),CDFy_dec(3:end),'--k', 'LineWidth',1.5)
set(AxesH, 'XScale', 'log', 'YScale', 'log')

legend('orignal series','decim series')
ylabel('Probability the abscissa is not exceeded')
xlabel('Normalized received voltage (v/vrms)')
% % ylim([0 1])

%% Chi-Square test 2nd try ===============================================

[HvnormY, HvnormX] = hist(v_norm_dec, Nbins);
step = HvnormX(2) - HvnormX(1);
end1 = HvnormX - step/2;
end2 = HvnormX + step/2;

HvnormYtheoretical = ...
    exp(-(end1.^2)./(rms^2))-exp(-(end2.^2)./(rms^2));

% mode = 1/sqrt(2);  % theoretical modal value of distribution

% HvnormYtheoretical = RayleighHIST(HvnormX, mode);
% HvnormYtheoretical = (2*HvnormX/rms^2).*exp(-HvnormX.^2/rms^2); 
HvnormYtheoretical = HvnormYtheoretical*length(v_norm_dec);
figure, hold on
bar(HvnormX,HvnormYtheoretical,0.8,'y')
bar(HvnormX,HvnormY,0.2,'r')
% hold off
title('Histogam of theoretical Rayleigh and of series')
legend('Theoretical','Sample')
xlabel('Normalized signal level')
ylabel('Bin frecuencies')

% Chi-Square parameter ================================================

D2 = sum((HvnormYtheoretical - HvnormY).^2./HvnormYtheoretical)

df = (Nbins - 1) - 1; % refuce DOFs by 1 because we extracted the rms value from the data

alpha = 100*(1 - gammainc(0.5*D2,0.5*df)) % significance level %
