function result = psi_to_x(psi, epsilon_r, focal_length)

rho = lens_rho(psi, epsilon_r, focal_length);

result = rho.*cos(psi);