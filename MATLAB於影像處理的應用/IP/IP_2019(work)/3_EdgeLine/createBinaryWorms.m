function wormsBinary = createBinaryWorms(worms)
% Segment worms in grayscale image

% Complement the images such that the worms are bright objects over the
% background
Ic = imcomplement(worms);
Ic = imadjust(Ic);

% Create morphological structuring element of a radius 9 neighboring
% elements. The structuring element must be large enough so that all worms
% are removed from image by erosion.
se = strel('disk',9);

% Top-hat filtering is used to correct the effect of inhomogenous
% illumination. It consists of the following steps:
% 1. Remove objects (in this example the worms) from image by morphological 
%    opening (erosion followed by dilation). 
%    The result is an estimation of the background.
%    Iopen = imopen(Ic,se);
% 2. Subtract the estimated background from the original image
%    Ifiltered = Ic-Iopen;

Ifiltered = imtophat(Ic,se);

% Convert the image to a binary image using a global image threshold
BW = imbinarize(Ifiltered,graythresh(Ifiltered));

% Morphologically remove any objects consisting of fewer than 10 elements
% to remove the background noise from the image
wormsBinary = bwareaopen(BW,10);

% Due to the weak and blury worms edges the segmented worms are slightly
% smaller than the worms in the original image and their outline is not
% smooth. The result can be improved by dilation with a small structuring
% element.
se = strel('disk',1);
wormsBinary = imdilate(wormsBinary,se);





