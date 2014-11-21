function[newPic] = preThresholding(img)
close all;
% imshow(img)
% img = im2double(img);
% fun = @(x) max(x(:));
% B = nlfilter(img,[20 20],fun);
% newPic = img./B;

maxPic = max(img(:));
minPic = min(img(:));

newPic = img > (maxPic+minPic)/2;

figure;
imshow(newPic)
