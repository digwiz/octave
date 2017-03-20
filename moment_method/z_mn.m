function z_mn = z_mn(freq, tau_m_y, tau_m_z, tau_n1_y, tau_n2_y, tau_n1_z, tau_n2_z, func)

%this file computes a single cell of the matrix in the expression (6.3-24), 
%as given in the formulation
z_mn = contour_integral_matlab(freq, tau_m_y, tau_m_z, tau_n1_y, tau_n2_y, tau_n1_z, tau_n2_z, func);

end