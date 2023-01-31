function [pdfy] = Rayleighpdfrms(rms,axispdfx)

pdfy = (2*axispdfx./rms.^2).*exp(-(axispdfx.^2)./(rms.^2));

return
