function [CDFy] = RayleighCDFrms_1(axisCDFx)

CDFy = 1 - exp(-axisCDFx.^2);

return
