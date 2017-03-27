function result = square_corners(upper_right_x, upper_right_y, edge_length)

coords_matrix = zeros(2,4);

%upper-right coords
coords_matrix(1,1) = upper_right_x;
coords_matrix(2,1) = upper_right_y;

%upper-left coords
coords_matrix(1,2) = upper_right_x-edge_length;
coords_matrix(2,2) = upper_right_y;

%bottom-left coords
coords_matrix(1,3) = upper_right_x-edge_length;
coords_matrix(2,3) = upper_right_y-edge_length;

%bottom-right coords
coords_matrix(1,4) = upper_right_x;
coords_matrix(2,4) = upper_right_y-edge_length;

result = coords_matrix;

end