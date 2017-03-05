function [z_array, v_column, i_column] = moment_method_line(freq, J_nought, z_L, z_U, b_L, b_U, num_segments, ls_y, ls_z, func)

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
        z_mn_matrix(m,n) = z_mn(freq, midpoint_array(m,1), midpoint_array(m,2), segment_array(n,1), segment_array(n+1,1), segment_array(n,2), segment_array(n+1,2), func);
        v_m_matrix(m,1) = v_m(freq, J_nought, midpoint_array(m,1), midpoint_array(m,2), ls_y, ls_z, func);
    end
z_array = z_mn_matrix;
v_column = v_m_matrix;
i_column = 1;
%i_column = inv(z_array)*v_column;
end
    
