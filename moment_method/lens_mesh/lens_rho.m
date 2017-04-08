function result = lens_rho(psi, epsilon_r, focal_length)

numerator = (sqrt(epsilon_r)-1).*focal_length;
denominator = sqrt(epsilon_r).*cos(psi)-1;

result = numerator./denominator;

end