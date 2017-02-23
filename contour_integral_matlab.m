function result = contour_integral_meters(freq, x_in, y_in, x1, x2, y1, y2, func)

line_length = sqrt((x2 - x1).^2 + (y2 - y1).^2);
wavelen = (3e+8)./(freq);
ang_freq = 2.*pi.*freq;
k_val = 2.*pi./wavelen;
mu_nought = pi.*4e-7;
slope = (y2 - y1)./(x2 - x1);
int_func = func;

weights = [0.210469457918546e-1, 0.130705540744447e+0, 0.289702301671314e+0, 0.350220370120399e+0, 0.208324841671986e+0];
nodes = [0.565222820508010e-2, 0.734303717426523e-1, 0.284957404462558e+0, 0.619482264084778e+0, 0.915758083004698e+0];

const_term = -1.*ang_freq.*mu_nought.*line_length./4;

sum = 0;
x_term = x2 - x1;
y_term = y2 - y1;

for i=1:5
 sum = sum + weights(i).*func(k_val.*sqrt((x_in - 0.1 - x_term.*nodes(i)).^2 + (y_in - 0.1 - y_term.*nodes(i)).^2));
end

result = const_term.*sum;
end