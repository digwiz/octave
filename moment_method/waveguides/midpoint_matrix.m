function midpoints = midpoint_matrix(total_segments, segment_array)

%compute the midpoints for each segment
midpoint_array = zeros(total_segments,2);
for iteration=1:total_segments
    midpoint_array(iteration, 1) = (segment_array(iteration, 1) + segment_array(iteration,2))./2;
    midpoint_array(iteration, 2) = (segment_array(iteration, 3) + segment_array(iteration,4))./2;
end

midpoints = midpoint_array;

end