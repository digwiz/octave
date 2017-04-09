function zmn_mat = zmn_matrix(total_segments, segment_array, midpoint_array, freq, func)


%this file computes the whole matrix of the expression (6.3-24), as given 
%in the formulation and returns it in the variable zmn_mat
z_mn_matrix = zeros(total_segments,total_segments);

for m=1:total_segments
    for n=1:total_segments
        if m == n

            midpoint1_y = (segment_array(n,1) + midpoint_array(n,1))./2;
            midpoint1_z = (segment_array(n,3) + midpoint_array(n,2))./2;
            midpoint2_y = (segment_array(n,2) + midpoint_array(n,1))./2;
            midpoint2_z = (segment_array(n,4) + midpoint_array(n,2))./2;

            zmn_half1 = z_mn(freq, midpoint1_y, midpoint1_z, segment_array(n, 1), midpoint_array(n,1), segment_array(n, 3), midpoint_array(n, 2), func);
            zmn_half2 = z_mn(freq, midpoint2_y, midpoint2_z, midpoint_array(n,1), segment_array(n, 2), midpoint_array(n, 2), segment_array(n, 4), func);

            z_mn_matrix(m,n) = (zmn_half1 + zmn_half2);

        else
            z_mn_matrix(m,n) = z_mn(freq, midpoint_array(m,1), midpoint_array(m,2), segment_array(n,1), segment_array(n,2), segment_array(n,3), segment_array(n,4), func);
        end
    end
end

zmn_mat = z_mn_matrix;

end