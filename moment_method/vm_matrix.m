function vm_mat = vm_matrix(total_segments, midpoint_array, freq, J_nought, ls_y, ls_z, func)

for m=1:total_segments
    v_m_matrix(m,1) = v_m(freq, J_nought, midpoint_array(m,1), midpoint_array(m,2), ls_y, ls_z, func);
end

vm_mat = v_m_matrix;

end