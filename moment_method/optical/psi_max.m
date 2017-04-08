function result = psi_max(e_r,F,w)

n=sqrt(e_r);
root_term = sqrt((n-1).*(4.*F.*F.*(n-1)+(n+1).*w.*w));
numer_term = -2.*F.*(n-1);
denom_term = (n+1).*w;

result = 2.*atan((root_term+numer_term)./(denom_term));