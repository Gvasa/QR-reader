function [pixelSize, fid1, fid2, fid3] = detectFiducial(img);


for( i = 1 : size(img(1))
    currentRow = img(1,:);
