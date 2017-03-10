function result = mrw_transform(lb, ub, func, xi)
len = ub-lb;
minus_xi = (1-xi);
b_xi = ub.*xi;
functerm = func(lb.*minus_xi + b_xi);
result = len.*functerm;
endfunction
