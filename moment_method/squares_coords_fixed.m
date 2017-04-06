%The function squares_coords creates a column vector that contains 2x4 
%matrices that represent the x- and y-coordinates of each square,
%effectively making squares_coords an 3-dimensional array where the first
%dimension depends on the width of the lens, and how many squares the user
%desires the width to correspond to. 

%Note that the floor() function is used to make the number of squares for 
%each row into a whole number; it is intended to rely on a relatively high 
%number for num_width_splits in order to compensate for this rounding. At 
%lower values, it is possible that the approximate lens created by this 
%function would look somewhat lopsided. Additionally, the floor function
%means that the code cannot currently handle fractional inputs; however,
%given the nature of the expressions used, this should not matter, as the
%width and F (and thus all derived quantities) can be specified in m, cm,
%mm, etc. without issue.

function [squares_column, centers_column] = squares_coords_fixed(width, F, e_r, num_width_splits)

%calculate maximum psi value
psi_max_val = psi_max2(e_r,F,width);

%get maximum rho from maximum psi
rho_max = lens_rho(psi_max_val,e_r,F);

%calculate first x and y from max rho and max psi
[first_x, first_y] = lens_curve_xy(rho_max, psi_max_val);

%max_x is used to calculate relevant x values later
max_x = first_x;

%lens_rho(0,e_r,F) is just the value F, and thickness should be max_x - F
thickness = max_x - lens_rho(0,e_r,F);

%the edge length of a square should equal the width of the lens divided by
%the number of squares to split the width into
edge_length = width./num_width_splits;

%squares_thick is the number of columns of squares to use to approximate
%the lens
squares_thick = floor(thickness./edge_length);
total_squares = 0;

for iter=1:num_width_splits
    total_squares = total_squares + 1;
end

%note that all of the values in the following for loop are calculated
%twice - once solely to determine the total number of squares to use to
%approximate the lens, and again to actually fill the lens array. This is
%done to avoid exponential run time increases that would occur if the array
%was resized repeatedly - as it would be if the calculations were only done
%once
for iter=1:(squares_thick-1)
    %the top-right x-coordinate for the first square in the new column is
    %equal to the maximum x value minus the number of columns already added
    new_first_x = max_x-iter.*edge_length;
    
    %calculate the y-value for the new first square's top-right corner
    new_first_y = abs(hyperbola_y(max_x, iter.*edge_length));
    
    %get the height of the new column of squares
    new_total_width = new_first_y.*2;
    
    num_squares_to_add = floor(new_total_width./edge_length);
    total_squares = total_squares + num_squares_to_add;
end

%page, column, row, where each page represents a whole square
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
    new_first_x = max_x-iter.*edge_length;    

    new_first_y = abs(hyperbola_y(max_x, iter.*edge_length));
    new_total_width = new_first_y.*2;
    num_squares_to_add = floor(new_total_width./edge_length);

    %For each other column of squares, add each square's coordinates to the
    %column, and increment squares_count.
    for it=1:num_squares_to_add
        
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
        
        squares_count = squares_count + 1;
        
    end
end

%return the calculated squares coordinates
squares_column = squares;
centers_column = squares_centers;
end