% plotChiPDFs

x = (0:0.1:10);
figure, hold on
for df = 1:10
    NUM = x.^((df-2)/2).*exp(-x/2);
    DEN = 2^(df/2)*gamma(df/2);
    pdf = NUM./DEN;
    plot(x, pdf, 'k')
end 
xlabel('\chi^2')
ylabel('pdf')
title('Chi-squared PDFs from 1 to 10 DOF')
