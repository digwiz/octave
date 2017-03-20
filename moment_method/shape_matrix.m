function shapes = shape_matrix(varargin)

%this function creates the matrix consisting of the PEC segments that will
%be further split and integrated over in other functions
num_shapes = length(varargin);
shape_mat = zeros(num_shapes,4);

for shape=1:num_shapes
    shape_mat(shape,:) = varargin{shape};
end

shapes = shape_mat;

end