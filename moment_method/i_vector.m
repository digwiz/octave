function [z_array, v_column, i_column] = i_vector(freq, J_nought, z_L, z_U, b_L, b_U, num_segments, ls_y, ls_z, func)

%the first column consists of y-values for segment endpoints along the
%scatterer, while the second one consists of the z-values
segment_array = zeros(num_segments+1, 2);
segment_y_length = (b_U - b_L)./num_segments;
segment_z_length = (z_U - z_L)./num_segments;

midpoint_array = zeros(num_segments, 2);

z_mn_matrix = zeros(num_segments, num_segments);
v_m_matrix = zeros(num_segments, 1);

for iteration=1:num_segments+1
    segment_array(iteration, 1) = b_L + (iteration-1).*segment_y_length;
    segment_array(iteration, 2) = z_L + (iteration-1).*segment_z_length;
end

for iteration=1:num_segments
    midpoint_array(iteration, 1) = segment_array(iteration, 1) + segment_y_length./2;
    midpoint_array(iteration, 2) = segment_array(iteration, 2) + segment_z_length./2;
end

for m=1:num_segments
    for n=1:num_segments
        if m == n
            midpoint1_y = midpoint_array(n, 1) - segment_y_length./4;
            midpoint2_y = midpoint_array(n, 1) + segment_y_length./4;
            midpoint1_z = midpoint_array(n, 2) - segment_z_length./4;
            midpoint2_z = midpoint_array(n, 2) + segment_z_length./4;
            
            zmn_half1 = z_mn(freq, midpoint1_y, midpoint1_z, segment_array(n, 1), midpoint_array(n,1), segment_array(n, 2), midpoint_array(n, 2), func);
            zmn_half2 = z_mn(freq, midpoint2_y, midpoint2_z, midpoint_array(n,1), segment_array(n+1, 1), midpoint_array(n, 2), segment_array(n+1, 2), func);
            
            z_mn_matrix(m,n) = zmn_half1 + zmn_half2;
            
            vm_half1 = v_m(freq, J_nought, midpoint1_y, midpoint1_z, ls_y, ls_z, func);
            vm_half2 = v_m(freq, J_nought, midpoint2_y, midpoint2_z, ls_y, ls_z, func);
            v_m_matrix(m,1) = vm_half1 + vm_half2;
            
        else    
            z_mn_matrix(m,n) = z_mn(freq, midpoint_array(m,1), midpoint_array(m,2), segment_array(n,1), segment_array(n+1,1), segment_array(n,2), segment_array(n+1,2), func);
            v_m_matrix(m,1) = v_m(freq, J_nought, midpoint_array(m,1), midpoint_array(m,2), ls_y, ls_z, func);
        end
    end
    
z_array = z_mn_matrix;
v_column = v_m_matrix;
i_column = z_array\v_column;
end
    
