function [x,y]=fCDFbins(z, nBins)

[a,b]=hist(z,nBins);
a=a/length(z);
a=[0 a 0];
step=b(2)-b(1);
x=[b(1)-step/2 b b(length(b))+step/2];
y= cumsum(a);

return
