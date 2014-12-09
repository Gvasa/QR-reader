function [newImg,pointNW] = transformPicture(centroidMatrix, img)

% Our reference points
pointNW = [centroidMatrix(1,1) centroidMatrix(1,2)];
pointNE = [centroidMatrix(2,1) centroidMatrix(2,2)];
pointSW = [centroidMatrix(3,1) centroidMatrix(3,2)];
pointSE = [centroidMatrix(4,1) centroidMatrix(4,2)];

% Check distance between points
NWtoNE = (norm(pointNW - pointNE));
NWtoSW = (norm(pointNW - pointSW));

% Calculate boxSize
pixelSize = min([NWtoNE NWtoSW]) / 34;

% Define out new points
wantedPointNW = pointNW;
wantedPointNE = [(pixelSize*34 + pointNW(1)), pointNW(2)];
wantedPointSW = [pointNW(1), (pixelSize*34 + pointNW(2))];
wantedPointSE = [wantedPointNE(1)-3*pixelSize, wantedPointSW(2)-3*pixelSize];

% Create matrix with homogeneous coordinates
centroidMatrixTemp = [centroidMatrix ones(4,1)];
transformMatrix = [wantedPointNW 1; wantedPointNE 1; wantedPointSW 1; wantedPointSE 1];
transformMatrix = [wantedPointNW; wantedPointNE; wantedPointSW; wantedPointSE];

% Calculate transform matrix
tM = fitgeotrans(centroidMatrix,transformMatrix, 'projective');

% Transform the image
newImg = imwarp(img, tM);
