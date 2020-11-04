clear

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


% Have two variables y1, y2 that want to express in terms of x1, x2.
% Have two equations satisfying format.

options = optimset('Display', 'off');

syms x1 x2 y1 y2
syms x y

eqs = [x + 2*y - x1 * x - y1 * y, 2*x + y - x2 * x- y2 * y];
allcoeff = [x,y];

[xstar, symvars] = matchcoeffs_vectorequations(allcoeff, eqs)
