
%calculates the value of 8.3-19 (technically F-2 in the formulation). 
function result = v_m(freq, b_1, b_2, rho_x, rho_y, ls_x_1, ls_y_1, ls_x_2, ls_y_2)

wavelen = (3e+8)./(freq);
k_val = 2.*pi./wavelen;
mu_nought = pi.*4e-7;
ang_freq = 2.*pi.*freq;

dist1 = sqrt((rho_x - ls_x_1).^2 + (rho_y - ls_y_1).^2);
dist2 = sqrt((rho_x - ls_x_2).^2 + (rho_y - ls_y_2).^2);

hankel_term = b_1.*besselh(0,2,dist1) + b_2.*besselh(0,2,dist2);
v_m_val = -1.*(ang_freq.*mu_nought./4).*hankel_term;

result = v_m_val;

end