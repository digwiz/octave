function result = psi_given_x2(e_r,F,max_x,number_thick)

n = sqrt(e_r);
numerator = max_x - number_thick;
denominator = max_x.*n - number_thick.*n - F.*n + F;

psi = acos(numerator./denominator);

result = psi;

end