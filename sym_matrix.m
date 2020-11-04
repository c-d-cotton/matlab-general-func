function mat = sym_matrix(name, dims)
% MATLAB_PREAMBLE_SIMPLE.{{{
% Christopher Cotton (c)
% www.cdcotton.com
% MATLAB_PREAMBLE_SIMPLE.}}}



% I can do something similar to this by running:
% Axx = sym('Axx', [nx, ny])

% The problem is that it creates elements that are Axx1 rather than Axx1_1 when it is a vector. I don't want this.

% Solution based upon answer on here: http://www.mathworks.com/matlabcentral/newsreader/view_thread/264941

nx = dims(1);
ny = dims(2);

mat = sym(zeros(nx, ny));
for rows = 1:nx
    for cols = 1:ny
        mat(rows, cols) = sym(strcat(name, sprintf('%d_%d', rows, cols)));
    end
end
