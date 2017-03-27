function result = square_centroid(upper_right_x, upper_right_y, edge_length)

coords = zeros(1,2);

coords(1,1) = upper_right_x + edge_length./2;
coords(1,2) = upper_right_y - edge_length./2;

result = coords;

end