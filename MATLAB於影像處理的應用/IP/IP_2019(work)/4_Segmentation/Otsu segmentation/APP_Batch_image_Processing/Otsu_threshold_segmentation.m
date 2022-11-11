function im_processed = Otsu_threshold_segmentation(im)

level = graythresh(im);
im_processed = im2bw(im,level);

end

