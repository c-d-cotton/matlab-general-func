function mat = assignmatrixfromsol(prefix, results, names)
% MATLAB_PREAMBLE_SIMPLE.{{{
% Christopher Cotton (c)
% www.cdcotton.com
% MATLAB_PREAMBLE_SIMPLE.}}}


% The results are the coefficients which are ordered by names. This code takes elements with names starting with the prefix and puts their elements into a matrix.

% names are in alphabetical order
% Therefore, read in order 1_1, 1_2, 1_3
j = 1;
for i = 1:length(results)
    toks = regexp(char(names(i)), strcat(prefix, '([0-9])*_([0-9])*'), 'tokens');

    if length(toks) > 0
        output(j) = results(i);

        j = j + 1;

        toks2 = toks;

    end
end

dimensions = toks2{1};
dimensions = cell2mat(dimensions);

% reshape naturally fills by column so need to transpose and give col as row dimension etc..
mat = transpose(reshape(output, [str2num(dimensions(2)), str2num(dimensions(1))]));
