function vm_mat = vm_matrix(total_segments, midpoint_array, freq, J_nought, ls_y, ls_z, func)

%this loop computes the whole column v_m (6.3-22) and returns it in the
%variable vm_mat

v_m_matrix = zeros(total_segments,1);

for m=1:total_segments
    v_m_matrix(m,1) = v_m(freq, J_nought, midpoint_array(m,1), midpoint_array(m,2), ls_y, ls_z, func);
end

vm_mat = v_m_matrix;

end