%% Batch image processing APP

close all;clear all;clc
imageBatchProcessor

%% Create a folder for storing testing images

% mkdir('MRIdata');
% d = load('mri');
% image = squeeze(d.D);
% for ind = 1:size(image,3)
% fileName = sprintf('Slice%02d.jpg',ind);
% imwrite(image(:,:,ind),fullfile('MRIdata', fileName));
% end