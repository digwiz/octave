function plot_square_mesh(multimat)

num_squares = length(multimat);
hold on
for iter=1:num_squares
    %top-right to top-left
    plot([multimat(iter,1,1),multimat(iter,1,2)], [multimat(iter,2,1),multimat(iter,2,2)], 'b-');
    %top-left to bottom-left
    plot([multimat(iter,1,2),multimat(iter,1,3)], [multimat(iter,2,2),multimat(iter,2,3)], 'b-');
    %bottom-left to bottom-right
    plot([multimat(iter,1,3),multimat(iter,1,4)], [multimat(iter,2,3),multimat(iter,2,4)], 'b-');
    %bottom-right to top-right
    plot([multimat(iter,1,4),multimat(iter,1,1)], [multimat(iter,2,4),multimat(iter,2,1)], 'b-');
    
end

hold off

end