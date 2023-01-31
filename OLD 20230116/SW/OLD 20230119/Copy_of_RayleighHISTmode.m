function hry1t = RayleighHISTmode(hry2,sigma)

step = hry2(2) - hry2(1);
end1 = hry2 - step/2;
end2 = hry2 + step/2;

hry1t = exp(-(end1.^2)./(2*sigma^2))-exp(-(end2.^2)./(2*sigma^2));

return
