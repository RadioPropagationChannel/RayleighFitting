function [xpdf, ypdf, xCDF, yCDF]=fCDFbins2(z, nBins)

[a,b]=hist(z,nBins-2);
a=a/length(z);
a=[0 a 0];
step=b(2)-b(1);

xpdf = [b(1)-step/2 b b(length(b))+step/2];
xCDF = xpdf;

ypdf = a;
yCDF= cumsum(a);

return
