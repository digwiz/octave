function midpoints = midpoint_matrix(total_segments, segment_array)

for iteration=1:total_segments
    midpoint_array(iteration, 1) = (segment_array(iteration, 1) + segment_array(iteration,2))./2;
    midpoint_array(iteration, 2) = (segment_array(iteration, 3) + segment_array(iteration,4))./2;
end

midpoints = midpoint_array;

end