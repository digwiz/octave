%The function squares_coords creates a column vector that contains 2x4 
%matrices that represent the x- and y-coordinates of each square,
%effectively making squares_coords an 3-dimensional matrix where the third
%dimension depends on the width of the lens and how many squares the user
%desires the width to correspond to. 

%Note that the floor() function is used to make the number of squares for 
%each row into a whole number; it is intended to rely on a relatively high 
%number for num_width_splits in order to compensate for this rounding. At 
%lower values, it is possible that the approximate lens created by this 
%function would look somewhat lopsided.

%This function is best used when called by another function that defines
%the x- and y-coordinates of the first square from a polar-coordinate
%representation of the hyperbola or other curves for the lens, since the
%thickness is dependent upon the equation for the hyperbola as well as the
%focal length of the lens, which is not part of this function

function [squares_column, centers_column] = squares_coords_psi_fixed(width, F, e_r, num_width_splits)

psi_max_val = psi_max(e_r,F,width);
rho_max = lens_rho(psi_max_val,e_r,F);

psi_vals = linspace(psi_max_val,0,num_width_splits);

[first_x, first_y] = lens_curve_xy(rho_max, psi_max_val);
thickness = rho_max.*cos(psi_max_val) - F;

edge_length = width./num_width_splits;
squares_thick = floor(thickness./edge_length);
%total_squares = 0;
squares_count = 0;

for iter=1:(num_width_splits)
    current_topright_psi = psi_vals(iter);
    current_topright_rho = lens_rho(current_topright_psi,e_r,F);
    current_topright_x = current_topright_rho.*cos(current_topright_psi);
    current_topright_y = current_topright_rho.*sin(current_topright_psi);
    
    total_width = current_topright_y.*2;
        num_squares_to_add = floor(total_width./edge_length);
        for it=num_squares_to_add:-1:1
            prev_psi = 0;
            prev_rho = 0;
            prev_x = 0;
            if iter > 1
                prev_psi = psi_vals(iter-1);
                prev_rho = lens_rho(prev_psi,e_r,F);
                prev_x = prev_rho.*cos(prev_psi);
            end
            if abs(current_topright_x - prev_x) >= edge_length
                %upper-right coords of the square
                squares(squares_count+1,1,1) = current_topright_x;
                squares(squares_count+1,2,1) = current_topright_y-edge_length.*(it-1);
    
                %upper-left coords of the square
                squares(squares_count+1,1,2) = current_topright_x-edge_length;
                squares(squares_count+1,2,2) = current_topright_y-edge_length.*(it-1);

                %bottom-left coords of the square
                squares(squares_count+1,1,3) = current_topright_x-edge_length;
                squares(squares_count+1,2,3) = current_topright_y-edge_length.*(it-1)-edge_length;
    
                %bottom-right coords of the square
                squares(squares_count+1,1,4) = current_topright_x;
                squares(squares_count+1,2,4) = current_topright_y-edge_length.*(it-1)-edge_length;
        
                squares_centers(squares_count+1,1,1) = current_topright_x+edge_length./2;
                squares_centers(squares_count+1,1,2) = current_topright_y-edge_length.*(it-1)-edge_length./2;
    
                squares_count = squares_count+1;
            end
        end
end

squares_column = squares;
centers_column = squares_centers;
    
end