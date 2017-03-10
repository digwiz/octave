function plotarray = te_modes(freq, J_nought, num_segments, num_steps, ls_y, ls_z, obs_y, obs_z, func, varargin)

plotarray = zeros(num_steps, 2);

num_shapes=length(varargin);

shape_array = zeros(num_shapes, 4);
for shape=1:num_shapes
    shape_array(shape,:) = varargin{shape};
end

for iter=1:num_steps
    plotarray(iter,1) = obs_z+0.05.*(iter-1);
    plotarray(iter,2) = momgen(freq,J_nought,num_segments,ls_y,ls_z,obs_y,obs_z+0.05.*(iter-1),func,varargin);
end

plot(plotarray(:,1), plotarray(:,2));