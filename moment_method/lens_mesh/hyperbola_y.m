function result = hyperbola_y(max_x, distance_deep)
a = max_x;
b = distance_deep;
y = sqrt(2.*a.*b - b.^2 -a.^2 + 1);

result = y;

end