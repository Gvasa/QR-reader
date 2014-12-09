function[centroidMatrix, antalgrannar] = findPoints(img, coordsX, coordsY, grannar)


granne = 3;
antalgrannar = grannar;

% Find size
[sizeX ~] = size(coordsX);
[sizeY ~] = size(coordsY);

% Sort
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
    if(sum(ismember(coordsY(:,2),  coordsY(i,2)  , 'rows')) < antalgrannar)
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
            if(coordsX(x,2) >= coordsY(y,4) && ...
                coordsX(x,2) <= coordsY(y,2) && ...
                coordsY(y,1) >= coordsX(x,3) && ...
                coordsY(y,1) <= coordsX(x,1))
            
                coordsX(x,5) = coordsX(x,5)+1;
                coordsY(y,5) = coordsY(y,5)+1;
            end
        end
    end
    
    % Check which lines who will be removed
    interval = floor(min([max(coordsX(:,5)) max(coordsY(:,5))])*0.75);

    % Remove lines
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

%                       %
%                       %
% Find centrum points   %
%                       %
%                       %

% Find centerpoint of the qr code.
minX = min(coordsX(:,3));
minY = min(coordsY(:,4));
maxX = max(coordsX(:,1));
maxY = max(coordsY(:,2));

medelX = (maxX - minX)/2 + minX;
medelY = (maxY - minY)/2 + minY;

% Find centerpoint North West   %
NWMYx = (coordsX(:,2) < medelY);
NWMXx = (coordsX(:,1) < medelX);
NWMx = NWMYx.*NWMXx;
NWMx = [NWMx NWMx NWMx NWMx];

NWx = coordsX.*NWMx;
NWx(ismember(NWx,[0 0 0 0], 'rows'), :) = [];
finalNWX = (mean(NWx(:,2)));

NWMYy = (coordsY(:,2) < medelY);
NWMXy = (coordsY(:,3) < medelX);
NWMy = NWMYy.*NWMXy;
NWMy = [NWMy NWMy NWMy NWMy];

NWy = coordsY.*NWMy;
NWy(ismember(NWy,[0 0 0 0], 'rows'), :) = [];
finalNWY = (mean(NWy(:,1)));

% Find centerpoint South West   %
SWMYx = (coordsX(:,2) > medelY);
SWMXx = (coordsX(:,1) < medelX);
SWMx = SWMYx.*SWMXx;
SWMx = [SWMx SWMx SWMx SWMx];

SWx = coordsX.*SWMx;
SWx(ismember(SWx,[0 0 0 0], 'rows'), :) = [];
finalSWX = (mean(SWx(:,2)));

SWMYy = (coordsY(:,2) > medelY);
SWMXy = (coordsY(:,3) < medelX);
SWMy = SWMYy.*SWMXy;
SWMy = [SWMy SWMy SWMy SWMy];

SWy = coordsY.*SWMy;
SWy(ismember(SWy,[0 0 0 0], 'rows'), :) = [];
finalSWY = (mean(SWy(:,1)));

% Find centerpoint North East   %
NEMYx = (coordsX(:,2) < medelY);
NEMXx = (coordsX(:,1) > medelX);
NEMx = NEMYx.*NEMXx;
NEMx = [NEMx NEMx NEMx NEMx];

NEx = coordsX.*NEMx;
NEx(ismember(NEx,[0 0 0 0], 'rows'), :) = [];
finalNEX = (mean(NEx(:,2)));

NEMYy = (coordsY(:,2) < medelY);
NEMXy = (coordsY(:,3) > medelX);
NEMy = NEMYy.*NEMXy;
NEMy = [NEMy NEMy NEMy NEMy];

NEy = coordsY.*NEMy;
NEy(ismember(NEy,[0 0 0 0], 'rows'), :) = [];
finalNEY = (mean(NEy(:,1)));

% Find points with labeling and centorids
iLabel = logical(img);
stat = regionprops(iLabel, 'centroid');
centroids = cat(1,stat.Centroid);

% Match our points with the centroid points. Smallest distance will be our
% centerpoint insteed.
[sizeCentroids ~] = size(centroids);
minDistNW = 10000;
minDistNE = 10000;
minDistSW = 10000;
centroidMatrix = zeros(3,2);

for i = 1:sizeCentroids
    if(norm([centroids(i,1) centroids(i,2)] - [finalNWY finalNWX]) < minDistNW)
        minDistNW = norm([centroids(i,1) centroids(i,2)] - [finalNWY finalNWX]);
        centroidMatrix(1,1) = centroids(i,1);
        centroidMatrix(1,2) = centroids(i,2);
        
    end
    if(norm([centroids(i,1) centroids(i,2)] - [finalNEY finalNEX]) < minDistNE)
        minDistNE = norm([centroids(i,1) centroids(i,2)] - [finalNEY finalNEX]);
        centroidMatrix(2,1) = centroids(i,1);
        centroidMatrix(2,2) = centroids(i,2);
    end
    if(norm([centroids(i,1) centroids(i,2)] - [finalSWY finalSWX]) < minDistSW)
        minDistSW = norm([centroids(i,1) centroids(i,2)] - [finalSWY finalSWX]);
        centroidMatrix(3,1) = centroids(i,1);
        centroidMatrix(3,2) = centroids(i,2);
    end
end