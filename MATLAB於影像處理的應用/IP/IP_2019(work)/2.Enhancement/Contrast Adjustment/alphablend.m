% AlphaBlend影像增強演法，由Resnet之父發明
% 好用

img=imread('lanyu.jpg');
[Blend]=imlocalbrighten(img,'AlphaBlend',true);
figure,imshowpair(img,Blend,'montage')