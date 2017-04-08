function result = psi_given_x(e_r,F,max_x,number_thick, edge_length)

n = sqrt(e_r);
numerator = number_thick.*edge_length - max_x;
denominator = n.*(number_thick.*edge_length - max_x) + F.*(n-1);
%numerator = max_x - number_thick;
%denominator = n.*(max_x - number_thick) + F.*(n-1);
psi = -1.*acos(numerator./denominator);

result = psi;

end