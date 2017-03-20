function result = guide_wl(freq,b,n)

wavelen = (3e+8)./(freq);
k_val = 2.*pi./wavelen;
kc = n.*pi./b;
beta = sqrt(k_val.^2 - (kc).^2);

result = 2.*pi./beta;

end