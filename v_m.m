function v_m = v_m(freq, J_nought, tau_m_y, tau_m_z, tau_ls_y, tau_ls_z, func)

wavelen = (3e+8)./(freq);
ang_freq = 2.*pi.*freq;
k_val = 2.*pi./wavelen;
mu_nought = pi.*4e-7;

const_term = -1.*ang_freq.*mu_nought.*J_nought./4;

v_m = const_term.*func(k_val.*sqrt((tau_m_y - tau_ls_y).^2 + (tau_m_z - tau_ls_z).^2));

end