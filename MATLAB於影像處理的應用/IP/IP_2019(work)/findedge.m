img=imread('Input2.JPG');
img=rgb2gray(img);
bw=edge(img);
figure;imshow(bw) % 再搭配Apps中的Image segmentor來找出車牌號碼
%處理大尺度影像(如tif檔)要使用
%bim=bigimage('filename.tif')
%bigimageshow(bim)