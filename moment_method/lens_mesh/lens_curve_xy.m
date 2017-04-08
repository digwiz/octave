function [x,y] = lens_curve_xy(rho, phi)

x = rho.*cos(phi);
y = rho.*sin(phi);

end