%computes the magnetic vector potential as given in 8.3-24. Note that the
%Hankel function is hard-coded into this script, rather than being accepted
%as a possible input function

function result = mag_pot(freq, cent_x, cent_y, rho_x, rho_y, edge_length)

wavelen = (3e+8)./(freq);
k_val = 2.*pi./wavelen;
mu_nought = pi.*4e-7;

b_x = cent_x + edge_length./2;
b_y = cent_y + edge_length./2;
a_x = cent_x - edge_length./2;
a_y = cent_y - edge_length./2;

weights = [0.210469457918546e-1, 0.130705540744447e+0, 0.289702301671314e+0, 0.350220370120399e+0, 0.208324841671986e+0];
nodes = [0.565222820508010e-2, 0.734303717426523e-1, 0.284957404462558e+0, 0.619482264084778e+0, 0.915758083004698e+0];

sum = 0;

for iter1=1:5
 for iter2=1:5
     const_term = ((b_x - a_x)./2).*((b_y - a_y)./2); 
     root_term = sqrt((cent_x - rho_x - (edge_length./2).*nodes(iter2)).^2 + (cent_y - rho_y - (edge_length./2).*nodes(iter1)).^2);
     hankelterm = k_val.*root_term;
     sum = sum + weights(iter2).*weights(iter1).*const_term.*besselh(0,2,hankelterm);
 end
end

result = mu_nought.*sum./(4.*1i);
end