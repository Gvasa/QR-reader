function[newImg] = rotatePicture(centroidMatrix, img)

% Get our fiducial points
pointNW = [centroidMatrix(1,1) centroidMatrix(1,2)];
pointNE = [centroidMatrix(2,1) centroidMatrix(2,2)];
pointXX = [centroidMatrix(2,1) centroidMatrix(1,2)];

% Caculate distances
hyp = norm(pointNW-pointNE);
mot = norm(pointXX-pointNE);
near = norm(pointNW-pointXX);

% Rotate the image
if(centroidMatrix(2,2) > centroidMatrix(1,2))
    newImg = imrotate(img,radtodeg(asin(mot/hyp)),'bicubic');
else
    newImg = imrotate(img,-radtodeg(asin(mot/hyp)),'bicubic');
end


