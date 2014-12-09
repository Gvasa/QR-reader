function[thePoint] = findAlignP(centroidMatrix, img)

%disp('Find Aligntment Pattern');

padVolume = 500;

% Our points
pointNW = [centroidMatrix(1,1)+padVolume centroidMatrix(1,2)+padVolume];
pointNE = [centroidMatrix(2,1)+padVolume centroidMatrix(2,2)+padVolume];
pointSW = [centroidMatrix(3,1)+padVolume centroidMatrix(3,2)+padVolume];

%Find Length between the points
distance_NW_NE = norm(pointNW-pointNE);
distance_NW_SW = norm(pointNW-pointSW);

img = padarray(img, [padVolume padVolume], 1,'both');

% Find points for crop the picture and crop
from_X = (pointNE(1)-distance_NW_NE*0.25);
to_X = pointNE(1)+distance_NW_NE*0.2;
from_Y = (pointSW(2)-distance_NW_SW*0.25);
to_Y = pointSW(2)+distance_NW_SW*0.2;
cropedImg = img(floor(from_Y):floor(to_Y), floor(from_X):floor(to_X));

%                                           %
%                                           %    
% It's time fo find the alignment pattern   %
%                                           %
%       
%
startPos = 0;
ratio = 0;
state = 0;
whiteCounter = 0;
blackCounter = 0;

% Con. interval
upperRate = 1.6;
lowerRate = 0.4;

coordsX = zeros(100000,4);
coordsY = zeros(100000,4);

counterCoordsX = 1;
counterCoordsY = 1;

nextPixel = 0;

[rowSize, colSize] = size(cropedImg);
cropedImg = padarray(cropedImg, [1 1], 1,'both');
colSize = colSize + 1;
rowSize = rowSize + 1;

% Row by row- Serach for White-Black-White-Black-White
hold on;
j=1;
for i = 1 : rowSize
    while(j<=colSize)

        switch state
            case 0 % White
                if(cropedImg(i,j) == 1)
                    startPos = j;
                    state = 1;
                    ratio = 1;
                    whiteCounter = 0;
                    blackCounter = 0;
                end
            case 1 % White
                if(cropedImg(i,j) == 1)
                    ratio = ratio +1;
                else
                    state = 2;
                    blackCounter = blackCounter +1;
                end
            case 2 % Black
                nextPixel = cropedImg(i,j+1);
                if(cropedImg(i,j) == 0)
                    blackCounter = blackCounter +1;
                    if(blackCounter >= lowerRate*ratio && blackCounter <= upperRate*ratio && nextPixel == 1)
                    state = 3;
                    blackCounter = 0;
                    end
                else
                    state = 0;
                    j = startPos;
                end
            case 3 % White - middle
                nextPixel = cropedImg(i,j+1);
                if(cropedImg(i,j) == 1)
                    whiteCounter = whiteCounter +1;
                    if(whiteCounter >= lowerRate*ratio && whiteCounter <= upperRate*ratio && nextPixel == 0)
                    state = 4;
                    whiteCounter = 0;
                    end
                else
                    state = 0;
                    j = startPos;
                end
            case 4 % Black
                nextPixel = cropedImg(i,j+1);
                if(cropedImg(i,j) == 0)
                    blackCounter = blackCounter +1;
                    if(blackCounter >= lowerRate*ratio && blackCounter <= upperRate*ratio && nextPixel == 1)
                    state = 5;
                    blackCounter = 0;
                    end
                else
                    state = 0;
                    j = startPos;
                end
            case 5 % Last white
                if(cropedImg(i,j) == 1)
                    whiteCounter = whiteCounter +1;
                    if(whiteCounter >= 0.9*ratio && whiteCounter <= upperRate*ratio)
                        coordsX(counterCoordsX, 1) = j;
                        coordsX(counterCoordsX, 2) = i;
                        coordsX(counterCoordsX, 3) = startPos;
                        coordsX(counterCoordsX, 4) = i;
                    
                        counterCoordsX = counterCoordsX +1;

                        j = startPos;
                        state = 0;
                    end
                else
                    state = 0;
                    j = startPos;
                end
            otherwise
                state = 0;
        end
        j = j+1;
    end
    state = 0;
    j=1;
end

% Col by Col - Serach for White-Black-White-Black-White
nextPixel = 0;
state = 0;
i=1;
for j = 1 : colSize
    while(i<=rowSize)
        switch state
            case 0 % White
                if(cropedImg(i,j) == 1)
                    startPos = i;
                    state = 1;
                    ratio = 1;
                    whiteCounter = 0;
                    blackCounter = 0;
                end
            case 1 % White
                if(cropedImg(i,j) == 1)
                    ratio = ratio +1;
                else
                    state = 2;
                    blackCounter = blackCounter +1;
                end
            case 2 % Black
                nextPixel = cropedImg(i+1,j);
                if(cropedImg(i,j) == 0)
                    blackCounter = blackCounter +1;
                    if(blackCounter >= lowerRate*ratio && blackCounter <= upperRate*ratio && nextPixel == 1)
                    state = 3;
                    blackCounter = 0;
                    end
                else
                    state = 0;
                    i = startPos;
                end
            case 3 % White in the middle
                nextPixel = cropedImg(i+1,j);
                if(cropedImg(i,j) == 1)
                    whiteCounter = whiteCounter +1;
                    if(whiteCounter >= lowerRate*ratio && whiteCounter <= upperRate*ratio && nextPixel == 0)
                    state = 4;
                    whiteCounter = 0;
                    end
                else
                    state = 0;
                    i = startPos;
                end
            case 4 % Black
                nextPixel = cropedImg(i+1,j);
                if(cropedImg(i,j) == 0)
                    blackCounter = blackCounter +1;
                    if(blackCounter >= lowerRate*ratio && blackCounter <= upperRate*ratio && nextPixel == 1)
                    state = 5;
                    blackCounter = 0;
                    end
                else
                    state = 0;
                    i = startPos;
                end
            case 5 % Black
                if(cropedImg(i,j) == 1)
                    whiteCounter = whiteCounter +1;
                    if(whiteCounter >= 0.9*ratio && whiteCounter <= upperRate*ratio)
                        coordsY(counterCoordsY, 1) = j;
                        coordsY(counterCoordsY, 2) = i;
                        coordsY(counterCoordsY, 3) = j;
                        coordsY(counterCoordsY, 4) = startPos;
                    
                        counterCoordsY = counterCoordsY +1;

                        i = startPos;
                        state = 0;
                    end
                else
                    state = 0;
                    i = startPos;
                end
            otherwise
                state = 0;
        end
        i = i+1;
    end
    state = 0;
    i=1;
end

% Crop the matrix
coordsX = coordsX(1:counterCoordsX,:);
coordsY = coordsY(1:counterCoordsY,:);

%                               %
%                               %
% It's time to remove bad lines %
%                               %
%                               %
granne = 5;
antalgrannar = 5;

% Finna storleken p? coordsX och Y
[sizeX ~] = size(coordsX);
[sizeY ~] = size(coordsY);

coordsX = sortrows(coordsX,2);

% Flag lines with neighbours far away
for i = 1:sizeX-1
    if((coordsX(i+1,2) - coordsX(i,2)) > granne)
        coordsX(i,:) = [0, 0, 0 ,0];
    end
end
% Flag lines with few neighbours
for i = 1:sizeX-1
    if(sum(ismember(coordsX(:,1),coordsX(i,1), 'rows')) < antalgrannar)
        mask = (1-ismember(coordsX(:,1),coordsX(i,1), 'rows'));
        mask = [mask, mask, mask, mask];
        coordsX = coordsX.*mask;
    end
end

coordsY = sortrows(coordsY,1);
% Flag lines with neighbours far away
for i = 1:sizeY-1
    if((coordsY(i+1,1) - coordsY(i,1)) > granne)
        coordsY(i,:) = [0, 0, 0 ,0];
    end
end

% Flag lines with few neighbours
for i = 1:sizeY-1
    if(sum(ismember(coordsY(:,2),coordsY(i,2), 'rows')) < antalgrannar)
        mask = (1-ismember(coordsY(:,2),coordsY(i,2), 'rows'));
        mask = [mask, mask, mask, mask];
        coordsY = coordsY.*mask;
    end
end

% Remove flaged lines
coordsX(ismember(coordsX,[0 0 0 0], 'rows'), :) = [];
coordsY(ismember(coordsY,[0 0 0 0], 'rows'), :) = [];

% Check Size
[sizeX, ~] = size(coordsX);
[sizeY, ~] = size(coordsY);

% Index how many times intersect - Remove [Twice]
for i=1:2
    % Add an index for times intersecting
    coordsX = [coordsX zeros(sizeX,1)];
    coordsY = [coordsY zeros(sizeY,1)];

    for x = 1:sizeX
        for y = 1:sizeY
            if(coordsX(x,2) >= coordsY(y,4) && coordsX(x,2) <= coordsY(y,2) && coordsY(y,1) >= coordsX(x,3) && coordsY(y,1) <= coordsX(x,1))
                coordsX(x,5) = coordsX(x,5)+1;
                coordsY(y,5) = coordsY(y,5)+1;
            end
        end
    end
    
    % Check which lines who will be removed
    interval = floor(min([max(coordsX(:,5)) max(coordsY(:,5))])*0.75);

    % Remove bad lines
    for i=1:interval
        coordsX(ismember(coordsX(:,5),i-1, 'rows'), :) = [];
        coordsY(ismember(coordsY(:,5),i-1, 'rows'), :) = [];
    end
    
    [sizeX, ~] = size(coordsX);
    [sizeY, ~] = size(coordsY);

    % Remove the index
    coordsX = coordsX(:, 1:4);
    coordsY = coordsY(:, 1:4);
end

% Remove flaged lines
coordsX(ismember(coordsX,[0 0 0 0], 'rows'), :) = [];
coordsY(ismember(coordsY,[0 0 0 0], 'rows'), :) = [];

% Find our point by our lines
alignPY = floor(mean(coordsX(:,2)));
alignPX = floor(mean(coordsY(:,1)));

%Find points with labeling and centorids
iLabel = logical(cropedImg);
stat = regionprops(iLabel, 'centroid');
centroids = cat(1,stat.Centroid);

% Find the centridPoint that matches our point best.
[sizeCentroids ~] = size(centroids);
minDist = 1000;
thePoint = zeros(1,2);

for i = 1:sizeCentroids
    if(norm([centroids(i,1) centroids(i,2)] - [alignPX alignPY]) < minDist)
        minDist = norm([centroids(i,1) centroids(i,2)] - [alignPX alignPY]);
        thePoint(1,1) = centroids(i,1);
        thePoint(1,2) = centroids(i,2);
    end
end

% Set the point to the orignal coord-system
thePoint(1,1) = thePoint(1,1)+from_X-padVolume-1;
thePoint(1,2) = thePoint(1,2)+from_Y-padVolume-1;

                