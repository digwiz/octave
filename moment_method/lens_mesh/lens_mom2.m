
%calculates the moment method result for the lens, given line source
%locations, a frequency, and a matrix of centroids. Note that the
%amplitudes of the line sources are hard-coded into this function, rather
%than being variable inputs
function [inc,scat] = lens_mom2(freq, cent_matrix, obs_x, obs_y, ls_x_1, ls_y_1, ls_x_2, ls_y_2, edge_length, epsilon_d)

wavelen = (3e+8)./(freq);
k_val = 2.*pi./wavelen;
mu_nought = pi.*4e-7;
ang_freq = 2.*pi.*freq;
epsilon_nought = 8.854187817e-12;

centroids = cent_matrix;
num_squares = length(cent_matrix);
z_mn_matrix = zeros(num_squares, num_squares);
v_m_matrix = zeros(num_squares, 1);

b_1 = 1;
b_2 = -1i;

delta_term = (1)./(1i.*ang_freq.*(epsilon_d.*epsilon_nought - epsilon_nought));


%calculate the terms of the z_mn matrix
z_mn_mat = zeros(num_squares,num_squares);
for iter2 = 1:num_squares
    z_mn_mat(:,iter2) = z_mn(freq, centroids(iter2,1,1), centroids(iter2,1,2), centroids(:,1,1), centroids(:,1,2), edge_length, epsilon_d);
end
addmat = zeros(num_squares,num_squares);
addmat(logical(eye(size(addmat)))) = delta_term;

z_mn_matrix = z_mn_mat + addmat;

%calculate the terms of the v_m column
v_m_matrix(:,1) = v_m(freq, b_1, b_2, centroids(:,1,1), centroids(:,1,2), ls_x_1, ls_y_1, ls_x_2, ls_y_2);

i_column = z_mn_matrix\v_m_matrix;

e_scat = 0;

ls_1_dist = sqrt((obs_x - ls_x_1).^2 + (obs_y - ls_y_1).^2);
ls_2_dist = sqrt((obs_x - ls_x_2).^2 + (obs_y - ls_y_2).^2);
hankel1 = besselh(0,2,k_val.*ls_1_dist);
hankel2 = besselh(0,2,k_val.*ls_2_dist);
inc_const = ang_freq.*mu_nought./4;

e_inc = -1.*inc_const.*(b_1.*hankel1 + b_2.*hankel2);

e_scat = (-1i).*ang_freq.*i_column(:,1).*mag_pot(freq, centroids(:,1,1), centroids(:,1,2), obs_x, obs_y, edge_length);

inc = e_inc;
scat = sum(e_scat);

end