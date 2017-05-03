function result = lens_einc(freq, obs_phi, ls_1_rho, ls_1_phi, ls_2_rho, ls_2_phi)

wavelen = (3e+8)./(freq);
k_val = 2.*pi./wavelen;
mu_nought = pi.*4e-7;
ang_freq = 2.*pi.*freq;

b_1 = 1;
b_2 = -1i;

inc_const = -(1i).*ang_freq.*(mu_nought)./sqrt(8.*(1i).*pi.*k_val);
einc_1 = b_1.*exp(1i.*k_val.*ls_1_rho.*cos(obs_phi-ls_1_phi));
einc_2 = b_2.*exp(1i.*k_val.*ls_2_rho.*cos(obs_phi-ls_2_phi));
e_inc1 = inc_const.*einc_1;
e_inc2 = inc_const.*einc_2;

result = e_inc1+e_inc2;

end