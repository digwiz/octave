function [i_column] = momgen(freq, J_nought, num_segments, ls_y, ls_z, obs_y, obs_z, func, varargin)

%num_segments is the number of segments to divide each part of the shape
%into, not the whole shape perimeter

%shape array holds 4-element vectors in each row that correspond to the
%beginning and end points of each part of the shape. For example, if the
%geometry to be integrated over consisted of two parallel plates, the first
%row might consist of [y1, y2, z1, z2] where y1 and y2 are the beginning 
%and end y-values of the upper plate, while z1 and z2 are the beginning and
%end z-values of the upper plate. The second row would consist of the
%values for the lower plate.

num_shapes=length(varargin);
total_segments = num_segments.*num_shapes;

shape_array = zeros(num_shapes, 4);
for shape=1:num_shapes
    shape_array(shape,:) = varargin{shape};
end


%Each row is the y-coords and z-coords of each segment's beginning. There
%are total_segments total segments in the array because num_segments
%is taken to be how many segments each sub-geometry should be split into
segment_array=zeros(total_segments, 4);

%the first element in each row is the y-length of the shape segments. The 
%second element is the z-length

for iteration=1:num_shapes
    %create a temporary Nx2 matrix to store the linspace results, which are 
    %the endpoints of the y- and z-segments  
    linspacematrix = zeros(num_segments+1,2); 
    linspacematrix(:,1) = linspace(shape_array(iteration,1), shape_array(iteration,2), num_segments+1);
    linspacematrix(:,2) = linspace(shape_array(iteration,3), shape_array(iteration,4), num_segments+1);
    
    for count=1:num_segments
        
        segment_array(count+(iteration-1).*num_segments,1) = linspacematrix(count,1);
        segment_array(count+(iteration-1).*num_segments,2) = linspacematrix(count+1,1);
        segment_array(count+(iteration-1).*num_segments,3) = linspacematrix(count,2);
        segment_array(count+(iteration-1).*num_segments,4) = linspacematrix(count+1,2);
    end
end

midpoint_array = zeros(total_segments, 2);

z_mn_matrix = zeros(num_segments, num_segments);
v_m_matrix = zeros(num_segments, 1);

for iteration=1:total_segments
    midpoint_array(iteration, 1) = (segment_array(iteration, 1) + segment_array(iteration,2))./2;
    midpoint_array(iteration, 2) = (segment_array(iteration, 3) + segment_array(iteration,4))./2;
end

for m=1:total_segments
    for n=1:total_segments
        if m == n
            
            midpoint1_y = (segment_array(n,1) + midpoint_array(n,1))./2;
            midpoint1_z = (segment_array(n,3) + midpoint_array(n,2))./2;
            midpoint2_y = (segment_array(n,2) + midpoint_array(n,1))./2;
            midpoint2_z = (segment_array(n,4) + midpoint_array(n,2))./2;
            
            zmn_half1 = z_mn(freq, midpoint1_y, midpoint1_z, segment_array(n, 1), midpoint_array(n,1), segment_array(n, 3), midpoint_array(n, 2), func);
            zmn_half2 = z_mn(freq, midpoint2_y, midpoint2_z, midpoint_array(n,1), segment_array(n, 2), midpoint_array(n, 2), segment_array(n, 4), func);
            
            z_mn_matrix(m,n) = zmn_half1 + zmn_half2;
            
            vm_half1 = v_m(freq, J_nought, midpoint1_y, midpoint1_z, ls_y, ls_z, func);
            vm_half2 = v_m(freq, J_nought, midpoint2_y, midpoint2_z, ls_y, ls_z, func);
            v_m_matrix(m,1) = vm_half1 + vm_half2;
            
        else    
            z_mn_matrix(m,n) = z_mn(freq, midpoint_array(m,1), midpoint_array(m,2), segment_array(n,1), segment_array(n,2), segment_array(n,3), segment_array(n,4), func);
            v_m_matrix(m,1) = v_m(freq, J_nought, midpoint_array(m,1), midpoint_array(m,2), ls_y, ls_z, func);
        end
    end
    
z_array = z_mn_matrix;
v_column = v_m_matrix;
i_column = z_array\v_column;

e_scat = 0;

for iteration=1:total_segments
    e_scat = e_scat + i_column(iteration,1).*contour_integral_matlab(freq,y_obs,z_obs,segment_array(iteration,1),segment_array(iteration,2),segment_array(iteration,3),segment_array(iteration,4));
end

end
    
