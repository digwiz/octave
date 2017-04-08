function result = current_psi(e_r,F,a,b)
n = sqrt(e_r);
numerator = (a.^2).*n-2.*a.*b.*n+a.*F.*sqrt(n-1)+(b.^2).*n-b.*F.*sqrt(n-1);
denominator = (a.^2).*(n.^2)-2.*a.*b.*(n.^2)+(b.^2).*(n.^2)+(F.^2).*(-1.*n)+(F.^2);

result = acos(numerator./denominator);

end