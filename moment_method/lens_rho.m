function result = lens_rho(phi, epsilon_r, focal_length)

numerator = (sqrt(epsilon_r)-1).*focal_length;
denominator = sqrt(epsilon_r).*cos(phi)-1;

result = numerator./denominator;

end