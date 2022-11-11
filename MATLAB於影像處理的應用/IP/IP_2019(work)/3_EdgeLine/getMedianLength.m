function [medLength,wormLength] = getMedianLength(worms)
% Calculate the median length of the lines (worms)
% Also return the number of lines (worms) if requested

% Convert the image to binary if needed
if ~islogical(worms)
    worms = im2bw(worms);
end

% Skeletonize the worms such that the dead worms become lines
wormSkel = bwmorph(worms,'skel',Inf);

% Fit lines to the worms to extact their length using hough Transform
% Get the Hough Transform Matrix for the skeletonized worms
[H, T, R] = hough(wormSkel);

% Locate peaks in the Hough transform matrix. Select a greater nHoodSize
% value to avois detecting lines that are very close by (similar rho and
% theta)
peaks = houghpeaks(H, 30,'NHoodSize',[55 11],'Threshold',0.4*max(H(:)));

% Extract lines location corresponding to the peaks in Hough Transform matrix
lines = houghlines(wormSkel, T, R, peaks);

% Compute line lengths
numWorms = length(lines);
wormLength = zeros(1,numWorms);

for k = 1:numWorms
   xy = [lines(k).point1; lines(k).point2];
   % Calculate the length of each worm
   wormLength(k) = sqrt(sum(diff(xy).^2)); % Euclidean distance
end

% Compute median length of worms
medLength = median(wormLength);







