%frequency = input frequency in Hz
%J_nought = input current density
%num_segments = the number of segments to divide each input shape into
%ls_y, ls_z = line source location in the y-z plane
%obs_y, obs_z = observation point location in the y-z plane
%func = the input function - in this case besselh(0,2,x)
%varargin = variable-length input list containing the vectors that
%represent the scatterer shapes

function [e_total] = momgen_far(freq, J_nought, num_segments, ls_y, ls_z, obs_y, obs_z, func, varargin)

%num_segments is the number of segments to divide each part of the shape
%into, not the combined shape

%shape array holds 4-element vectors in each row that correspond to the
%beginning and end points of each part of the shape. For example, if the
%geometry to be integrated over consisted of two parallel plates, the first
%row might consist of [y1, y2, z1, z2] where y1 and y2 are the beginning
%and end y-values of the upper plate, while z1 and z2 are the beginning and
%end z-values of the upper plate. The second row would consist of the
%values for the lower plate. Each geometry is passed into the function as a
%4-dimensional vector [y1, y2, z1, z2] at the end of the argument list,
%which is how the varargin argument above factors in.

mu_nought = pi.*4e-7;
ang_freq = 2.*pi.*freq;
wavelen = (3e+8)./(freq);
k_val = 2.*pi./wavelen;

num_shapes=length(varargin);

total_segments = num_segments.*num_shapes;

%pass the varargin vector list to the function shape_matrix
shape_array = shape_matrix(varargin{:});


%Each row is the y-coords and z-coords of each segment's beginning and end
%. There are total_segments total segments in the array because 
%num_segments is taken to be how many segments each sub-geometry should be 
%split into.

segment_array = segment_matrix(num_shapes, num_segments, shape_array);

%midpoint_array is an Nx2 matrix where the first value in each row is the
%y-value of that segment's midpoint, and the second value is the z-value.
%These are calculated using the midpoint_matrix function
midpoint_array = midpoint_matrix(total_segments, segment_array);

%z_array holds the resultant Z-matrix for the moment method solution. It is
%created and returned by the zmn_matrix function
z_array = zmn_matrix(total_segments, segment_array, midpoint_array, freq, func);

%v_column holds the resultant V-vector for the moment method solution. 
%It is created and returned by the vm_matrix function
v_column = vm_matrix(total_segments, midpoint_array, freq, J_nought, ls_y, ls_z, func);

%use Matlab's built-in syntax for evaluating systems of equations. inv(A)*b
%seems to have the same effect in this case
i_column = z_array\v_column;

%create a variable to hold the e_scattered sum over the segments and their
%currents
e_scat = 0;

%calculate the distance between the observation point and the line source
obs_dist = sqrt(obs_y.^2 + obs_z.^2);
obs_phi = atan(obs_y./obs_z);

ls_dist = sqrt(ls_y.^2 + ls_z.^2);
ls_phi = atan(ls_y./ls_z);
%calculate the incident field of the line source
e_inc = -1i.*ang_freq.*mu_nought.*(1./sqrt(8.*1i.*pi.*k_val)).*J_nought.*exp(1i.*k_val.*ls_dist.*cos(obs_phi-ls_phi)).*exp(-1i.*k_val.*obs_dist)./sqrt(obs_dist);

%sum up the scattered field contributions of each segment
for iteration=1:total_segments
    segment_length = sqrt((segment_array(iteration,1) - segment_array(iteration,2)).^2 + (segment_array(iteration,3) - segment_array(iteration,4)).^2);
    exp_term1 = exp(1i.*k_val.*segment_array(iteration,3).*cos(obs_phi));
    exp_term2 = exp(1i.*k_val.*segment_array(iteration,1).*sin(obs_phi));
    
    potential_term = (1./sqrt(8.*1i.*pi.*k_val)).*(exp(-1i.*k_val.*obs_dist)./sqrt(obs_dist)).*segment_length.*exp_term1.*exp_term2;
    
    integral_func = @(x) exp(1i.*k_val.*(segment_array(iteration,4)-segment_array(iteration,2)).*x.*cos(obs_phi)+1i.*k_val.*(segment_array(iteration,3)-segment_array(iteration,1)).*x.*sin(obs_phi));
    e_scat = e_scat + i_column(iteration,1).*potential_term.*integral(integral_func,0,1)
end

%set the return value equal to the absolute value of e_scat + e_inc
e_total=abs(e_scat + e_inc)./421.4889;
end
