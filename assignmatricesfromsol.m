function matrices = assignmatrixfromsol(results, names)
% MATLAB_PREAMBLE_SIMPLE.{{{
% Christopher Cotton (c)
% www.cdcotton.com
% MATLAB_PREAMBLE_SIMPLE.}}}

% The results are the coefficients which are ordered by names. This code takes elements by prefix and puts their elements into a matrix by prefix.

% names are in alphabetical order
% Therefore, read in order 1_1, 1_2, 1_3
elementnum = 1;
matrixnum = 1;
start = 1;
for i = 1:length(results)
    toks = regexp(char(names(i)), '([a-zA-Z]*)([0-9]*)_([0-9]*)', 'tokens');
    
    prefix = toks{1}{1};

    if start == 0 && (1 - strcmp(prefix, oldprefix))

        nrow = oldtoks{1}{2};
        ncol = oldtoks{1}{3};

        % reshape naturally fills by column so need to transpose and give col as row dimension etc..
        mat = transpose(reshape(output, [str2num(ncol), str2num(nrow)]));
        matrices{matrixnum} = mat;

        output = zeros(0);
        matrixnum = matrixnum + 1;
        elementnum = 1;

    end

    output(elementnum) = results(i);
    elementnum = elementnum + 1;
    oldprefix = prefix;
    oldtoks = toks;
    start = 0;

end

% completing final matrix

nrow = oldtoks{1}{2};
ncol = oldtoks{1}{3};

% reshape naturally fills by column so need to transpose and give col as row dimension etc..
mat = transpose(reshape(output, [str2num(ncol), str2num(nrow)]));
matrices{matrixnum} = mat;
