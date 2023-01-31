function [CDFy]=RayleighCDFrms(rms,axisCDFx)
CDFy=1-exp(-(axisCDFx.^2)./(rms.^2));
return
