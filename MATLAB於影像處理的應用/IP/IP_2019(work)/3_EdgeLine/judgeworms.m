%% Determine the worms are dead or alive.
% Compare the median length(58) of lines detected in alive and dead worms¡¦
% images.
clc;close all;clear;imtool close all;

worms1 = imread('wormsBW1.png');

% Based on the median length of death and alive worms, you can select
% a threshold for classification.
classifyWorms('wormsBW1.png');

%%
worms2 = imread('wormsBW2.png');
classifyWorms('wormsBW2.png');