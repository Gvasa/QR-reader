function[cropedImg] = cropImg(centroidMatrix, img, boxSize)

% Pad the image
imgPadded = padarray(img, [floor(30*boxSize) floor(30*boxSize)], 1,'both'); 

% Add the padding to centroid points
centroidMatrix = centroidMatrix + 30*boxSize;

% Make a croped image
cropedImg = imgPadded(floor(centroidMatrix(1,2)-boxSize*10):floor(centroidMatrix(3,2)+boxSize*10),floor(centroidMatrix(1,1)-boxSize*10):floor(centroidMatrix(2,1)+boxSize*10));
