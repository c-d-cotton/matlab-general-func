function r = call_on(func, array)
% MATLAB_PREAMBLE_SIMPLE.{{{
% Christopher Cotton (c)
% www.cdcotton.com
% MATLAB_PREAMBLE_SIMPLE.}}}


% based on https://www.mathworks.com/matlabcentral/answers/48928-converting-a-vector-to-multiple-variables-required-as-input-for-matlabfunction


  t = num2cell(array);
  r = func(t{:});
end
