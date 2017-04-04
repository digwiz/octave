function result = psi_given_x(e_r,F,max_x,number_thick)

n = sqrt(e_r);
numerator = number_thick - max_x;
denominator = n.*(number_thick - max_x) + F.*(n-1);

psi = -1.*acos(numerator./denominator);

result = psi;

end