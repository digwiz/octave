function segs = segment_matrix(num_shapes,num_segments,shape_array)

for iteration=1:num_shapes
    %create a temporary Nx2 matrix to store the linspace results, which are
    %the endpoints of the y- and z-segments
    linspacematrix = zeros(num_segments+1,2);
    linspacematrix(:,1) = linspace(shape_array(iteration,1), shape_array(iteration,2), num_segments+1);
    linspacematrix(:,2) = linspace(shape_array(iteration,3), shape_array(iteration,4), num_segments+1);

    for count=1:num_segments

        segment_array(count+(iteration-1).*num_segments,1) = linspacematrix(count,1);
        segment_array(count+(iteration-1).*num_segments,2) = linspacematrix(count+1,1);
        segment_array(count+(iteration-1).*num_segments,3) = linspacematrix(count,2);
        segment_array(count+(iteration-1).*num_segments,4) = linspacematrix(count+1,2);
    end
end

segs = segment_array;

end