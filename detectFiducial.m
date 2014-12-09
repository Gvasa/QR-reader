function [coordsX, coordsY] = detectFiducial(img)

% Initialize
startPos = 0;
ratio = 0;
state = 0;
whiteCounter = 0;
blackCounter = 0;

% Confidence interval
upperRate = 1.6;
lowerRate = 0.4;

% Our start and end points
coordsX = zeros(100000,4);
coordsY = zeros(100000,4);
counterCoordsX = 1;
counterCoordsY = 1;

nextPixel = 0;
[rowSize, colSize] = size(img);

% Pad the image
img = padarray(img, [1 1], 1,'both');
colSize = colSize + 1;
rowSize = rowSize + 1;

j=1;

for i = 1 : rowSize
    while(j<=colSize)
        switch state
            case 0
                if(img(i,j) == 1 && img(i,j+1) == 0) % White and next black
                    startPos = j;
                    state = 1;
                    ratio = 1;
                    whiteCounter = 0;
                    blackCounter = 0;
                end
            case 1 % Count black
                if(img(i,j) == 0)
                    ratio = ratio + 1;
                else
                    state = 2;
                end
                
            case 2 % count white
                nextPixel = img(i,j+1);
                if(img(i,j) == 1)
                    whiteCounter = whiteCounter+1;
                    if(whiteCounter >= lowerRate*ratio && whiteCounter <= upperRate*ratio && nextPixel == 0)
                        state = 3;
                        whiteCounter = 0;
                    end
                else % WRONG - Start over
                    state = 0;
                    j = startPos;
                end
                
            case 3 % count black
                nextPixel = img(i,j+1);
                if(img(i,j) == 0)
                    blackCounter = blackCounter + 1;
                    if(blackCounter >= lowerRate*3*ratio && blackCounter <= upperRate*3*ratio &&  nextPixel == 1)
                        state = 4;
                        blackCounter = 0;
                    end
                else % WRONG - Start over
                    state = 0;
                    j = startPos;
                end
            case 4 % count white
                nextPixel = img(i,j+1);
                if(img(i,j) == 1)
                    whiteCounter = whiteCounter+1;
                    if(whiteCounter >= lowerRate*ratio && whiteCounter <= upperRate*ratio &&  nextPixel == 0)
                        state = 5;
                        whiteCounter = 0;
                    end
                else % WRONG - Start over
                    state = 0;
                    j = startPos;
                end
            case 5 % Count black
                nextPixel = img(i,j+1);
                if(img(i,j) == 0)
                    blackCounter = blackCounter+1;
                    if(blackCounter >= lowerRate*ratio && blackCounter <= upperRate*ratio && nextPixel == 1) % Ok, add points
                        
                        coordsX(counterCoordsX, 1) = j;
                        coordsX(counterCoordsX, 2) = i;
                        coordsX(counterCoordsX, 3) = startPos;
                        coordsX(counterCoordsX, 4) = i;
                    
                        counterCoordsX = counterCoordsX +1;

                        j = startPos;
                        state = 0;
                    end
                else % WRONG - Start over
                    state = 0;
                    j = startPos;
                end
            otherwise% WRONG - Start over
                state = 0;
        end
        j = j+1;
    end
    state = 0;
    j=1;
end


% Check vertical
nextPixel = 0;
state = 0;
i = 1;

for j = 1 : colSize
    while(i<=rowSize)        
        switch state
            case 0
                if(img(i,j) == 1 && img(i+1,j) == 0) % If white and next pixel black
                    startPos = i;
                    state = 1;
                    ratio = 1;
                    whiteCounter = 0;
                    blackCounter = 0;
                end
            case 1 % count black
                if(img(i,j) == 0)
                    ratio = ratio + 1;
                else
                    state = 2;
                    i = i-1;
                end
            case 2 % count white
                nextPixel = img(i+1,j);
                if(img(i,j) == 1)
                    whiteCounter = whiteCounter+1;
                    if(whiteCounter >= lowerRate*ratio && whiteCounter <= upperRate*ratio && nextPixel == 0)
                        state = 3;
                        whiteCounter = 0;
                    end
                else % WRONG - Start over
                    state = 0;
                    i = startPos;
                end
            case 3 % count black
                nextPixel = img(i+1,j);
                if(img(i,j) == 0)
                    blackCounter = blackCounter + 1;
                    if(blackCounter >= lowerRate*3*ratio && blackCounter <= upperRate*3*ratio && nextPixel == 1)
                        state = 4;
                        blackCounter = 0;
                    end
                else % WRONG - Start over
                    state = 0;
                    i = startPos;
                end
            case 4 % count white
                nextPixel = img(i+1,j);
                if(img(i,j) == 1)
                    whiteCounter = whiteCounter+1;
                    if(whiteCounter >= lowerRate*ratio && whiteCounter <= upperRate*ratio &&  nextPixel == 0)
                        state = 5;
                        whiteCounter = 0;
                    end
                else % WRONG - Start over
                    state = 0;
                    i = startPos;
                end
            case 5 % count black
                nextPixel = img(i+1,j);
                if(img(i,j) == 0)
                    %disp('Svart!');
                    blackCounter = blackCounter+1;
                    if(blackCounter >= lowerRate*ratio && blackCounter <= upperRate*ratio && nextPixel == 1) % Add points
                        
                        coordsY(counterCoordsY, 1) = j;
                        coordsY(counterCoordsY, 2) = i;
                        coordsY(counterCoordsY, 3) = j;
                        coordsY(counterCoordsY, 4) = startPos;
                    
                        counterCoordsY = counterCoordsY +1;

                        i = startPos;
                        state = 0;
                    end
                else % WRONG - Start over
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

% Crop our point vectors
% coordsX(1) = end x
% coordsX(2) = end y
% coordsX(3) = start x
% coordsX(4) = start y
coordsX = coordsX(1:counterCoordsX,:);
coordsY = coordsY(1:counterCoordsY,:);
coordsX = sortrows(coordsX,1);
coordsY = sortrows(coordsY,1);