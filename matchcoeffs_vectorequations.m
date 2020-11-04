function [xstar, symvars] = matchcoeffs_vectorequations(variables, eqs, display)
% eqs are a set of n linear equations 
% have m variables in each equation. listed in vector variables.
% each variable must EXPLICITLY appear in each equation otherwise not work properly.

% match coefficients for m variables to get solution.
% should have n*m (symbolic variable) coefficients to match
% return solution and names of variables.

% see matchcoeffs_vectorequations_example.m for example

% prints fsol

% MATLAB_PREAMBLE_STANDARD.{{{
% Christopher Cotton (c)
% www.cdcotton.com

% Get project directory for this file so I can call script relative to project path, not this script.
% Useful if move script within project.

% First set up project directory dictionary if not exist.
if exist('projectdirdict') == 0
    projectdirdict = containers.Map;
end

if isKey(projectdirdict, mfilename('fullpath')) == 0
    % get projectdir
    curfilesplit = strsplit(mfilename('fullpath'), '/');

    while true
        if length(curfilesplit) > 1
            curfilesplit = curfilesplit(1: (length(curfilesplit) - 1));
        else
            projectdir = 0;
            break
        end

        projectdir = strcat(strjoin(curfilesplit(1:length(curfilesplit)), '/'), '/');
        gitdir = strcat(projectdir, '.git/');
        if exist(gitdir, 'file') == 7
            break
        end
            

    end

    % Add projectdir to dictionary of projectdirs by file
    projectdirdict(mfilename('fullpath')) = projectdir;

    % projectdirdict(mfilename('fullpath')) gives the name of the project directory associated with a file
end

% function to add script's directory to path by giving full filename
if exist('addpath_fullpath') == 0
    addpath_fullpath=@(fullpath) addpath(fileparts(fullpath));
end

% SORT OUT PROJECTDIR
% Perhaps separate call for main and call scripts since want to clear main script.
% MATLAB_PREAMBLE_STANDARD.}}}

if exist('display', 'var') == 0
    display = 'final';
end
options = optimset('Display', display);

for i = 1:length(eqs)
    for j = 1:length(variables)
        
        vec = coeffs(eqs(i), variables(j));
        
        % Last element of vec is the coefficient for the variable (first coefficient is coefficient for constant).
        tosolve((i-1) * length(variables) + j) = vec(length(vec));

    end
end

symvars = symvar(tosolve);

myfun = matlabFunction(tosolve);

addpath_fullpath(strcat(projectdirdict(mfilename('fullpath')), 'call_on.m'));

x0 = zeros([1, length(eqs) * length(variables)]);
% need to offer possibility to change x0
% x0 = ones([1, length(eqs) * length(variables)]) * 0.01;

[xstar, fval] = fsolve(@(x) call_on(myfun, x), x0, options);
