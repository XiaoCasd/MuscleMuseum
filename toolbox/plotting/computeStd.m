function [xUni,yAve,yError] = computeStd(x,y)
%computeSde Summary of this function goes here
%   computeSde has inputs [x] and [y] as plotting data. x and y must have
%   the same dimension. It returns the independent variable list [xUni]
%   without duplications. [yAve] is the dependent variable list that has
%   been averaged accordingly. [yError] is the corresponding standard
%   deviation.
arguments
x double {mustBeVector} 
y double {mustBeVector}
end

% Validate array sizes
if ~all(size(x) == size(y))
    error("sizes of x and y do not match.")
end

% Find unique x array
[xUni,~,ic] = unique(x);

% Initialize yError and yAve
yError = zeros(size(xUni));
yAve = zeros(size(xUni));

% Find out how to select y data to do average
[icSorted,icSortIdx] = sort(ic);
icSortedDiff = find(diff(icSorted));
selectIdx = [[1;(icSortedDiff+1)],[icSortedDiff;numel(ic)]];

% Calculate std and mean
for ii = 1:size(selectIdx,1)
    ySelected = y(icSortIdx(selectIdx(ii,1):selectIdx(ii,2)));
    [yError(ii),yAve(ii)] = std(ySelected); % standard deviation and mean
end
end

