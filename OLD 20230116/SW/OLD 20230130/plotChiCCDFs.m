% plotChiCCDFs

chi2 = (0:0.1:25);
figure, hold on
for df = 1:10
    alpha= 1 - gammainc(0.5*chi2,0.5*df);
    plot(chi2, alpha, 'k')
end 
xlabel('\chi^2')
ylabel('Probability the ordinate is exceeded')
title('Chi-squared CCDFs from 1 to 10 DOF')
