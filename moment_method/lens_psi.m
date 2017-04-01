function result = lens_psi(rho, epsilon_r, focal_length)

numerator = (sqrt(epsilon_r)-1).*focal_length + rho;
denominator = sqrt(epsilon_r).*rho;

result = acos(numerator./denominator);

end