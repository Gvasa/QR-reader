function[pointMatrix] = findPoints(img, coordsX, coordsY)

pointMatrix = 0;
[sizeX ~] = size(coordsX);
[sizeY ~] = size(coordsY);

% Tar bort linjer som inte har n?gra n?ra grannar
for i = 1:sizeX-1
    if((coordsX(i+1,2) - coordsX(i,2)) > 5)
        coordsX(i,:) = [0, 0, 0 ,0];
    end
end

% Flaggar linjer som har grannar men f?
for i = 1:sizeX-1
    if(sum(ismember(coordsX(:,1),coordsX(i,1), 'rows')) < 3)
        mask = (1-ismember(coordsX(:,1),coordsX(i,1), 'rows'));
        mask = [mask, mask, mask, mask];
        coordsX = coordsX.*mask;
    end
end

% Tar bort linjer som inte har n?gra n?ra grannar
for i = 1:sizeY-1
    if((coordsY(i+1,1) - coordsY(i,1)) > 5)
        coordsY(i,:) = [0, 0, 0 ,0];
    end
end

% Flaggar linjer som har grannar men f?
for i = 1:sizeY-1
    if(sum(ismember(coordsY(:,2),coordsY(i,2), 'rows')) < 3)
        mask = (1-ismember(coordsY(:,2),coordsY(i,2), 'rows'));
        mask = [mask, mask, mask, mask];
        coordsY = coordsY.*mask;
    end
end

% Tar bort linjer som ?r flaggade
coordsX(ismember(coordsX,[0 0 0 0], 'rows'), :) = [];
coordsY(ismember(coordsY,[0 0 0 0], 'rows'), :) = [];

[sizeX ~] = size(coordsX);
[sizeY ~] = size(coordsY);

% Hitta linjer som sk?r varandra!
coordsX = [coordsX zeros(sizeX,1)];
coordsY = [coordsY zeros(sizeY,1)];

% Tar bort dom som inte sk?r varandra
for x = 1:sizeX
    for y = 1:sizeY
        if(coordsX(x,2) >= coordsY(y,4) && coordsX(x,2) <= coordsY(y,2) && coordsY(y,1) >= coordsX(x,3) && coordsY(y,1) <= coordsX(x,1))
            coordsX(x,5) = 1;
            coordsY(y,5) = 1;
        end
    end
end

coordsX(ismember(coordsX(:,5),0, 'rows'), :) = [];
coordsY(ismember(coordsY(:,5),0, 'rows'), :) = [];
coordsX(:,5) = [];
coordsY(:,5) = [];

[sizeX ~] = size(coordsX);
[sizeY ~] = size(coordsY);

% H?r finner vi mittpunkter! :D

minX = min(coordsX(:,3));
minY = min(coordsY(:,4));
maxX = max(coordsX(:,1));
maxY = max(coordsX(:,2));

medelX = (maxX - minX)/2 + minX;
medelY = (maxY - minY)/2 + minY;


% NW
NWMYx = (coordsX(:,2) < medelY);
NWMXx = (coordsX(:,1) < medelX);
NWMx = NWMYx.*NWMXx;
NWMx = [NWMx NWMx NWMx NWMx];

NWx = coordsX.*NWMx;
NWx(ismember(NWx,[0 0 0 0], 'rows'), :) = [];
finalNWX = floor(mean(NWx(:,2)));

NWMYy = (coordsY(:,2) < medelX);
NWMXy = (coordsY(:,3) < medelY);
NWMy = NWMYy.*NWMXy;
NWMy = [NWMy NWMy NWMy NWMy];

NWy = coordsY.*NWMy;
NWy(ismember(NWy,[0 0 0 0], 'rows'), :) = []
finalNWY = floor(mean(NWy(:,1)));

% ---------------------- SW
SWMYx = (coordsX(:,2) > medelY);
SWMXx = (coordsX(:,1) < medelX);
SWMx = SWMYx.*SWMXx;
SWMx = [SWMx SWMx SWMx SWMx];

SWx = coordsX.*SWMx;
SWx(ismember(SWx,[0 0 0 0], 'rows'), :) = [];
finalSWX = floor(mean(SWx(:,2)));

SWMYy = (coordsY(:,2) > medelX);
SWMXy = (coordsY(:,3) < medelY);
SWMy = SWMYy.*SWMXy;
SWMy = [SWMy SWMy SWMy SWMy];

SWy = coordsY.*SWMy;
SWy(ismember(SWy,[0 0 0 0], 'rows'), :) = []
finalSWY = floor(mean(SWy(:,1)));

% ------------------------- NE

NEMYx = (coordsX(:,2) < medelY);
NEMXx = (coordsX(:,1) > medelX);
NEMx = NEMYx.*NEMXx;
NEMx = [NEMx NEMx NEMx NEMx];

NEx = coordsX.*NEMx;
NEx(ismember(NEx,[0 0 0 0], 'rows'), :) = [];
finalNEX = floor(mean(NEx(:,2)));

NEMYy = (coordsY(:,2) < medelX);
NEMXy = (coordsY(:,3) > medelY);
NEMy = NEMYy.*NEMXy;
NEMy = [NEMy NEMy NEMy NEMy];

NEy = coordsY.*NEMy;
NEy(ismember(NEy,[0 0 0 0], 'rows'), :) = []
finalNEY = floor(mean(NEy(:,1)));

% ------------------------ SE

SEMYx = (coordsX(:,2) > medelY);
SEMXx = (coordsX(:,1) > medelX);
SEMx = SEMYx.*SEMXx;
SEMx = [SEMx SEMx SEMx SEMx];

SEx = coordsX.*SEMx;
SEx(ismember(SEx,[0 0 0 0], 'rows'), :) = [];
finalSEX = floor(mean(SEx(:,2)));

SEMYy = (coordsY(:,2) > medelX);
SEMXy = (coordsY(:,3) > medelY);
SEMy = SEMYy.*SEMXy;
SEMy = [SEMy SEMy SEMy SEMy];

SEy = coordsY.*SEMy;
SEy(ismember(SEy,[0 0 0 0], 'rows'), :) = []
finalSEY = floor(mean(SEy(:,1)));

% -------------------------- PLOT SHIT

figure,imshow(img)
hold on;
for i=1:(sizeX)
    plot([coordsX(i,1),coordsX(i,3)],[coordsX(i,2),coordsX(i,4)],'Color','r','LineWidth',1);
end
hold on

for i=1:sizeY
    plot([coordsY(i,1),coordsY(i,3)],[coordsY(i,2),coordsY(i,4)],'Color','r','LineWidth',1);
end
hold on;
plot([finalNWY,finalSWY,finalNEY,finalNWY],[finalNWX,finalSWX,finalNEX,finalNWX],'Color','g','LineWidth',1);
plot(finalNWY, finalNWX, 'g*');
plot(finalSWY, finalSWX, 'g*');
plot(finalNEY, finalNEX, 'g*');
plot(finalSEY, finalSEX, 'g*');
