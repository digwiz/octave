function [e_total] = momgen(freq, J_nought, num_segments, ls_y, ls_z, obs_y, obs_z, func, varargin)

%num_segments is the number of segments to divide each part of the shape
%into, not the whole shape perimeter

%shape array holds 4-element vectors in each row that correspond to the
%beginning and end points of each part of the shape. For example, if the
%geometry to be integrated over consisted of two parallel plates, the first
%row might consist of [y1, y2, z1, z2] where y1 and y2 are the beginning
%and end y-values of the upper plate, while z1 and z2 are the beginning and
%end z-values of the upper plate. The second row would consist of the
%values for the lower plate.

mu_nought = pi.*4e-7;
ang_freq = 2.*pi.*freq;
wavelen = (3e+8)./(freq);
k_val = 2.*pi./wavelen;

num_shapes=length(varargin);

total_segments = num_segments.*num_shapes;

shape_array = shape_matrix(varargin{:});
%shape_array = zeros(num_shapes, 4);
%for shape=1:num_shapes
%    shape_array(shape,:) = varargin{shape};
%end


%Each row is the y-coords and z-coords of each segment's beginning and end
%. There are total_segments total segments in the array because 
%num_segments is taken to be how many segments each sub-geometry should be 
%split into.

segment_array = segment_matrix(num_shapes, num_segments, shape_array);

midpoint_array = midpoint_matrix(total_segments, segment_array);

z_array = zmn_matrix(total_segments, segment_array, midpoint_array, freq, func);

v_column = vm_matrix(total_segments, midpoint_array, freq, J_nought, ls_y, ls_z, func);

i_column = z_array\v_column;

e_scat = 0;
obs_dist = sqrt((obs_y-ls_y).^2+(obs_z-ls_z).^2);
e_inc = -1.*ang_freq.*mu_nought.*J_nought.*func(k_val.*obs_dist)./4;
for iteration=1:total_segments
    e_scat = e_scat + i_column(iteration,1).*contour_integral_matlab(freq,obs_y,obs_z,segment_array(iteration,1),segment_array(iteration,2),segment_array(iteration,3),segment_array(iteration,4),func);
end

e_total=abs(e_scat + e_inc);
end
