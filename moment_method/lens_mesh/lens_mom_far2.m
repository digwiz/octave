
%calculates the moment method result for the lens, given line source
%locations, a frequency, and a matrix of centroids. Note that the
%amplitudes of the line sources are hard-coded into this function, rather
%than being variable inputs
function [inc, scat] = lens_mom_far2(freq, cent_matrix, obs_rho, obs_phi, ls_x_1, ls_y_1, ls_x_2, ls_y_2, edge_length, epsilon_d)

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

%calculate the terms of the z_mn matrix
delta_term = (1)./(1i.*ang_freq.*(epsilon_d.*epsilon_nought - epsilon_nought));
sqrt_term = sqrt((edge_length.^2)./pi);
hankelinsert = k_val.*sqrt_term;

z_mn_matrix(logical(eye(size(z_mn_matrix)))) = delta_term + (1i).*ang_freq.*(2./(k_val.^2)).*((pi.*k_val.*sqrt_term.*besselh(1,2,hankelinsert) - 2i));
sqrt_dist_mat = zeros(num_squares,num_squares);
for iter1 = 1:num_squares
    for iter2 = 1:num_squares
        sqrt_dist_mat(iter1,iter2) = sqrt((centroids(iter1,1,1) - centroids(iter2,1,1)).^2 + (centroids(iter1,1,2) - centroids(iter2,1,2)).^2);
    end
end
besselmat = (1i).*ang_freq.*(2.*pi./k_val).*sqrt_term.*besselj(1,hankelinsert).*besselh(0,2,k_val.*sqrt_dist_mat);
besselmat(logical(eye(size(besselmat)))) = 0;
z_mn_matrix = z_mn_matrix + besselmat;


%calculate the terms of the v_m column
v_m_matrix(:,1) = v_m(freq, b_1, b_2, centroids(:,1,1), centroids(:,1,2), ls_x_1, ls_y_1, ls_x_2, ls_y_2);

i_column = z_mn_matrix\v_m_matrix;

e_scat = 0;

ls_1_rho = sqrt(ls_x_1.^2 + ls_y_1.^2);
ls_2_rho = sqrt(ls_x_2.^2 + ls_y_2.^2);
%ls_1_phi = atan(ls_y_1./ls_x_1);
%ls_2_phi = atan(ls_y_2./ls_x_2);
e_inc = lens_einc(freq, obs_phi, ls_1_rho, pi, ls_2_rho, 0);

const_term = ((edge_length.^2)./4).*mu_nought./sqrt(8.*(1i).*pi.*k_val);
sinc1 = sin((k_val.*edge_length./2).*cos(obs_phi))./((k_val.*edge_length./2)*cos(obs_phi));
sinc2 = sin((k_val.*edge_length./2).*sin(obs_phi))./((k_val.*edge_length./2)*sin(obs_phi));
   
sincmult=sinc1.*sinc2;

exp_term = exp((1i).*k_val.*centroids(:,1,1)).*exp((1i).*k_val.*centroids(:,1,2));
e_scat = i_column(:,1).*exp_term;
e_scat = e_scat.*const_term.*(-1i).*ang_freq;

inc = e_inc;

scat = sincmult.*sum(e_scat);
end