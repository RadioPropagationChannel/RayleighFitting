function hry1t = RayleighHISTrms(hry2,rms)

% Computing the pdf from the CDF

step = hry2(2) - hry2(1);
end1 = hry2 - step/2;
end2 = hry2 + step/2;

hry1t = exp(-(end1.^2)./(rms^2))-exp(-(end2.^2)./(rms^2));

return
