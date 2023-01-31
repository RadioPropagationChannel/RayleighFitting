function [pdfy]=Rayleighpdf(sigma,axispdfx)

pdfy = (axispdfx./sigma.^2).*exp(-(axispdfx.^2)./(2*sigma.^2));

return
