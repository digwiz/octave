%this function calculates the value of equation 8.3-23
function [mag] = z_mn(freq, cent_x, cent_y, rho_x, rho_y, edge_length, epsilon_d)

mag_val = mag_pot(freq, cent_x, cent_y, rho_x, rho_y, edge_length);

mag = mag_val;

end