function p = microstrip_pfunc(k_0, w_eff, l_eff)
a1_term = (-0.16605./10).*((k_0.*w_eff).^2)
a1a2_term = (3./560).*((-0.16605.^2)+2.*0.00761).*((k_0.*w_eff).^4)
a3_term = 0.2.*(-0.0914153).*((k_0.*l_eff).^2)
a1a3_term = (1./70).*(-0.16605).*(-0.0914153).*((k_0.*w_eff).^2).*((k_0.*l_eff).^2)
p = 1 + a1_term + a1a2_term + a3_term + a1a3_term
endfunction
