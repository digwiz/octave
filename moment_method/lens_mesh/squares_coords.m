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

function [squares_column, centers_column,testmat] = squares_coords(width, F, e_r, num_width_splits)

psi_max_val = psi_max(e_r,F,width);
rho_max = lens_rho(psi_max_val,e_r,F);
[first_x, first_y] = lens_curve_xy(rho_max, psi_max_val);
thickness = rho_max.*cos(psi_max_val) - F;

edge_length = width./num_width_splits;
squares_thick = floor(thickness./edge_length);
testmatrix = [];
total_squares = 0;

for iter=1:num_width_splits
    total_squares = total_squares + 1;
end

for iter=1:(squares_thick-1)
    new_rho = sqrt(e_r).*(rho_max.*cos(psi_max_val) - iter.*edge_length) - (sqrt(e_r)-1).*F;
    new_first_x = rho_max.*cos(psi_max_val)-iter.*edge_length;
    %new_first_y = sqrt(new_rho.^2 - new_first_x.^2);
    %new_psi = atan(new_first_y./new_first_x);
    new_psi = acos(((sqrt(e_r)-1).*F+new_rho)./(new_rho.*e_r));
    %a = abs(F - thickness);
    %b = sqrt(width.*a./2);
    %new_first_y = (b./a).*sqrt(new_first_x.^2 - a.^2);
    new_first_y = new_rho.*sin(new_psi);
    %new_first_y = new_rho.*sin(current_psi(e_r,F,rho_max.*cos(psi_max_val),iter.*edge_length));
    new_total_width = new_first_y.*2;
    num_squares_to_add = floor(new_total_width./edge_length);
    total_squares = total_squares + num_squares_to_add;
end

%page, column, row, where each page represents a whole square,  
squares = zeros(total_squares, 2, 4);
squares_centers = zeros(total_squares, 1, 2);

squares_count = 0;

%fill out the first column of squares (the right-most column along the width 
%of the lens) in a column that contains the 2x4 matrices. Add to a counter 
%for each element populated, so that the next column of squares can be added to
%the overall column where the first column ends. Since the x-coordinate of
%each square's upper-right corner will be the same, we only have to
%decrement the y-coordinate by edge_length.*(iter-1) to get the upper-right
%coordinates of each consecutive square.
for iter=1:num_width_splits
    %squares(squares_count+1) = square_corners(first_x,first_y-edge_length.*(iter-1), edge_length);
    %upper-right coords
    squares(squares_count+1,1,1) = first_x;
    squares(squares_count+1,2,1) = first_y-edge_length.*(iter-1);

    %upper-left coords
    squares(squares_count+1,1,2) = first_x-edge_length;
    squares(squares_count+1,2,2) = first_y-edge_length.*(iter-1);

    %bottom-left coords
    squares(squares_count+1,1,3) = first_x-edge_length;
    squares(squares_count+1,2,3) = first_y-edge_length.*(iter-1)-edge_length;

    %bottom-right coords
    squares(squares_count+1,1,4) = first_x;
    squares(squares_count+1,2,4) = first_y-edge_length.*(iter-1)-edge_length;
    
    %squares_centers(squares_count+1) = square_centroid(first_x,first_y-edge_length.*(iter-1), edge_length);
    
    squares_centers(squares_count+1,1,1) = first_x+edge_length./2;
    squares_centers(squares_count+1,1,2) = first_y-edge_length.*(iter-1)-edge_length./2;
    
    squares_count = squares_count + 1;
end

%iterate through each remaining column of the lens, determining the new x-
%and y-coordinates for the upper-right corner of the first square in the new
%column. This will allow the column called "squares" to contain all of the 
%squares we are interested in. Multiply the new y-value by 2 to get the 
%total width of the column, and then divide that by edge_length to determine 
%how many squares to add to the column.
for iter=1:(squares_thick-1)
    new_rho = sqrt(e_r).*(rho_max.*cos(psi_max_val)-iter.*edge_length)-(sqrt(e_r)-1).*F;
    new_first_x = rho_max.*cos(psi_max_val)-iter.*edge_length;
    %new_first_y = sqrt(new_rho.^2 - new_first_x.^2);
    %new_psi = atan(new_first_y./new_first_x);
    new_psi = acos(((sqrt(e_r)-1).*F+new_rho)./(new_rho.*e_r));
    
    %a = abs(F - thickness);
    %b = sqrt(width.*a./2);
    %new_first_y = (b./a).*sqrt(new_first_x.^2 - a.^2);
    
    new_first_y = new_rho.*sin(new_psi);
    %new_first_y = new_rho.*sin(current_psi(e_r,F,rho_max.*cos(psi_max_val),iter.*edge_length));
    new_total_width = new_first_y.*2;
    num_squares_to_add = floor(new_total_width./edge_length);
    
    %For each other column of squares, add each square's coordinates to the
    %column, and increment squares_count.
    for it=1:num_squares_to_add
        %squares(squares_count+1) = square_corners(new_first_x,new_first_y-edge_length.*(iter-1),edge_length);
        
         %upper-right coords
        squares(squares_count+1,1,1) = new_first_x;
        squares(squares_count+1,2,1) = new_first_y-edge_length.*(it-1);

        %upper-left coords
        squares(squares_count+1,1,2) = new_first_x-edge_length;
        squares(squares_count+1,2,2) = new_first_y-edge_length.*(it-1);

        %bottom-left coords
        squares(squares_count+1,1,3) = new_first_x-edge_length;
        squares(squares_count+1,2,3) = new_first_y-edge_length.*(it-1)-edge_length;

        %bottom-right coords
        squares(squares_count+1,1,4) = new_first_x;
        squares(squares_count+1,2,4) = new_first_y-edge_length.*(it-1)-edge_length;
    
        squares_centers(squares_count+1,1,1) = new_first_x+edge_length./2;
        squares_centers(squares_count+1,1,2) = new_first_y-edge_length.*(it-1)-edge_length./2;
        
        %squares_centers(squares_count+1) = square_corners(new_first_x,new_first_y-edge_length.*(iter-1),edge_length);
        squares_count = squares_count + 1;
        
    end
end

squares_column = squares;
centers_column = squares_centers;
testmat=testmatrix;
end