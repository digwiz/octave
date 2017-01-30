function result = mrw_sum(lb, ub, func, N)

#determine the zero term
zero_term = -1.*lb./(ub-lb);

#determine the intervals for the integration
c = mrw_intervals(lb, ub, N);

#the variable to store the summation value in
integral_result = 0;

#iterate over the number of intervals, checking for the singularity. If the
#singularity is present in an interval, break it into two separate intervals
#with the singularity as an endpoint, and evaluate the new integrals
for i = 1:N
 if ((c{i,1} <= zero_term) & (zero_term < c{i,2}) && (zero_term != 0)) #should this be strictly less?
  #doextrasplit
  splitsum = 0;
  splitsum = splitsum + zero_term.*mrw_singleint(c{i,1}, zero_term, func);
  splitsum = splitsum + (1-zero_term).*mrw_singleint(zero_term, c{i,2}, func);
  integral_result = integral_result + splitsum;
 else
  integral_result = integral_result + mrw_singleint(c{i,1}, c{i,2}, func);
 endif
endfor
result = integral_result;

endfunction
