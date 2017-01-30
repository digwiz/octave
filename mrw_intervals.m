function intervals = mrw_intervals(lb, ub, N)
c = cell (N, 2);
for i = 1:N
c{i, 1} = lb + (i-1).*(ub - lb)./N;
c{i, 2} = lb + i.*(ub - lb)./N;
endfor
intervals = c;
endfunction
