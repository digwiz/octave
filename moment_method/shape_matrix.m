function shapes = shape_matrix(varargin)

num_shapes = length(varargin);
shape_mat = zeros(num_shapes,4);

for shape=1:num_shapes
    shape_mat(shape,:) = varargin{shape};
end

shapes = shape_mat;

end