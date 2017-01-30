function result = mrw_singleint(intl, inth, func)
sum = 0;
intdiff = inth-intl;

weights = [0.210469457918546e-1, 0.130705540744447e+0, 0.289702301671314e+0, 0.350220370120399e+0, 0.208324841671986e+0];
nodes = [0.565222820508010e-2, 0.734303717426523e-1, 0.284957404462558e+0, 0.619482264084778e+0, 0.915758083004698e+0];

for i = 1:5
 sum = sum + intdiff.*(func(intl+intdiff.*nodes(i)).*weights(i));
endfor
result = sum;
endfunction
