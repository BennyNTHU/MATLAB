function classifyWorms(fileName)
% Classify worms image as 'dead' or 'alive'

wormsImage = imread(fileName);

%% Extract line segments using Hough and calculate worm length 
[medLength,wormLength] = getMedianLength(wormsImage);

%% Plot the worms lengths as a stem plot
figure, stem(wormLength);
hold on
% highlight the median length
plot(medLength*ones(size(wormLength)), 'r-')
axis tight
text(2,5,['Median length = ',num2str(medLength)]);
legend('worm lengths', 'median length')
title('Lengths of Located Worms')
disp(['The median length of worms is ',num2str(medLength)])

%% Classify worms image based on the median length and display the image
figure, imshow(wormsImage);

if medLength > 58
    title('\bfThese worms are DEAD');
    disp('These worms are DEAD');
else
    title('\bfThese worms are ALIVE');
    disp('These worms are ALIVE');
end


