%% Read in image
close all;clear all;clc

I = imread('mms.jpg');
figure,
imshow(I);

%%  Convert to grayscale image

Igray = rgb2gray(I);
figure,
imshow(Igray);

%% Problem: illumination doesn't allow for easy segmentation

Ithresh = im2bw(Igray,graythresh(I));
figure,
imshow(Ithresh);

%% Create Mask by filteriing image with morphological operators

se = strel('disk', 60);
Iclosed = imclose(I, se);
figure,
imshow(Iclosed);

%% Subtract the mask from the original image

Icorrect = imsubtract(Iclosed, I);
figure,
imshow(Icorrect);

%%  Revisit Thresholding Problem

Ithresh = im2bw(Icorrect, graythresh(Icorrect));
figure,
imshow(Ithresh);

%% Fill the holes to see the result

Ifill = imfill(Ithresh, 'holes');
figure,
imshow(Ifill);

%% 
% --------------------------------------------------------
% So it is the wrong way to do such segmentation, 
% try another approach.
% --------------------------------------------------------

%% Solution:  Thresholding the image on each color pane

Im=I;

rmat=Im(:,:,1);
gmat=Im(:,:,2);
bmat=Im(:,:,3);

figure,
subplot(2,2,1), imshow(rmat);
title('Red Plane');
subplot(2,2,2), imshow(gmat);
title('Green Plane');
subplot(2,2,3), imshow(bmat);
title('Blue Plane');
subplot(2,2,4), imshow(I);
title('Original Image');

%% Set the threshold by experiments

levelr = 0.43;
levelg = 0.32;
levelb = 0.18;
i1=im2bw(rmat,levelr);
i2=im2bw(gmat,levelg);
i3=im2bw(bmat,levelb);
Isum = imcomplement(i1&i2&i3);

figure,
% Plot the data
subplot(2,2,1), imshow(i1);
title('Red Plane');
subplot(2,2,2), imshow(i2);
title('Green Plane');
subplot(2,2,3), imshow(i3);
title('Blue Plane');
subplot(2,2,4), imshow(Isum);
title('Sum of all the planes');

%% Or get the treshold by color thresholder APP

colorThresholder(I)

%% Fill in holes

figure,
Ifilled = imfill(Isum,'holes');
figure, imshow(Ifilled);

%% Remove the noise

se = strel('disk', 15);
Iopen2 = imopen(Ifilled,se);
figure,
imshowpair(Iopen2, I);


%% Extract features

stats = regionprops(Iopen2,'Area','BoundingBox');
areas = [stats.Area];
idxOfCandies = size(areas,2);

%% Use feature analysis to count skittles objects

figure, imshow(I);
hold on;
for idx = 1 : idxOfCandies
        h = rectangle('Position',stats(idx).BoundingBox,'LineWidth',2);
        set(h,'EdgeColor',[.75 0 0]);
        hold on;
end

title(['There are ', num2str(idxOfCandies) ' candy pieces on your desk!']);

hold off;


