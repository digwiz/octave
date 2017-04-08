function result = psi_max2(e_r,F,w)

n=sqrt(e_r);
root_term = sqrt(4.*F.*F.*n.*n - 8.*F.*F.*n + 4.*F.*F + n.*n.*w.*w - w.*w);
numer_term = (2.*F) - (2.*F.*(n));
denom_term = (n+1).*w;

result = 2.*atan((root_term+numer_term)./(denom_term));

end