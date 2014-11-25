function [coordsX, coordsY] = detectFiducial(img)

startPos = 0;
ratio = 0;
state = 0;
whiteCounter = 0;
blackCounter = 0;

upperRate = 1.6;
lowerRate = 0.4;

coordsX = zeros(100000,4);
coordsY = zeros(100000,4);

counterCoordsX = 1;
counterCoordsY = 1;

nextPixel = 0;

[rowSize, colSize] = size(img);
img = padarray(img, [1 1], 1,'both');
colSize = colSize + 1;
rowSize = rowSize + 1;

j=1;

for i = 1 : rowSize
    while(j<=colSize)
        switch state
            case 0
                if(img(i,j) == 1 && img(i,j+1) == 0)
                    startPos = j;
                    state = 1;
                    ratio = 1;
                    whiteCounter = 0;
                    blackCounter = 0;
                end
            case 1
                if(img(i,j) == 0)
                    %disp('Svart - case 1');
                    ratio = ratio + 1;
                else
                    %disp('Vidare till vit - Case 1');
                    state = 2;
                end
                
            case 2
                nextPixel = img(i,j+1);
                if(img(i,j) == 1)
                    %disp('Vit - case 2'); 
                    whiteCounter = whiteCounter+1;
                    if(whiteCounter >= lowerRate*ratio && whiteCounter <= upperRate*ratio && nextPixel == 0)
                        %disp('Vidare till svart - case 2');
                        state = 3;
                        whiteCounter = 0;
                    end
                else
                    %disp('Tillbaka fr?n b?rjan - case 2');
                    state = 0;
                    j = startPos;
                end
                
            case 3
                nextPixel = img(i,j+1);
                if(img(i,j) == 0)
                    %disp('Svart - case 3');
                    blackCounter = blackCounter + 1;
                    if(blackCounter >= lowerRate*3*ratio && blackCounter <= upperRate*3*ratio &&  nextPixel == 1)
                        %disp('Vidare till vit - case 3');
                        state = 4;
                        blackCounter = 0;
                    end
                else
                    %disp('Tillbaka till start - case 3');
                    state = 0;
                    j = startPos;
                end
            case 4
                nextPixel = img(i,j+1);
                if(img(i,j) == 1)
                    %disp('VIT - case 4');
                    whiteCounter = whiteCounter+1;
                    if(whiteCounter >= lowerRate*ratio && whiteCounter <= upperRate*ratio &&  nextPixel == 0)
                        %disp('Vidare till svart - case 4');
                        state = 5;
                        whiteCounter = 0;
                    end
                else
                    %disp('Fel, b?rja om - case 4');
                    state = 0;
                    j = startPos;
                end
            case 5
                nextPixel = img(i,j+1);
                if(img(i,j) == 0)
                    %disp('Svart!');
                    blackCounter = blackCounter+1;
                    if(blackCounter >= lowerRate*ratio && blackCounter <= upperRate*ratio && nextPixel == 1)
                        %disp('Klar - b?rja om');
                        
                        coordsX(counterCoordsX, 1) = j;
                        coordsX(counterCoordsX, 2) = i;
                        coordsX(counterCoordsX, 3) = startPos;
                        coordsX(counterCoordsX, 4) = i;
                    
                        counterCoordsX = counterCoordsX +1;

                        j = startPos;
                        state = 0;
                    end
                else
                    %disp('Fel, b?rja om - case 5');
                    state = 0;
                    j = startPos;
                end
            otherwise
                disp('n?nting gick fel');
                state = 0;
        end
        j = j+1;
    end
    state = 0;
    j=1;
end

nextPixel = 0;
state = 0;
i = 1;

for j = 1 : colSize
    while(i<=rowSize)
%         if(j == 101 && i > 512 & i < 600)
%             plot(j,i, 'r*');
%             state
%             pause;
%         end
        
        switch state
            case 0
                if(img(i,j) == 1 && img(i+1,j) == 0)
                    %disp('Svart - case 0');
                    startPos = i;
                    state = 1;
                    ratio = 1;
                    whiteCounter = 0;
                    blackCounter = 0;
                end
            case 1
                if(img(i,j) == 0)
                    %disp('Svart - case 1');
                    ratio = ratio + 1;
                else
                    %disp('Vidare till vit - Case 1');
                    state = 2;
                    i = i-1;
                end
            case 2
                nextPixel = img(i+1,j);
                if(img(i,j) == 1)
                    %disp('Vit - case 2'); 
                    whiteCounter = whiteCounter+1;
                    if(whiteCounter >= lowerRate*ratio && whiteCounter <= upperRate*ratio && nextPixel == 0)
                        %disp('Vidare till svart - case 2');
                        state = 3;
                        whiteCounter = 0;
                    end
                else
                    %disp('Tillbaka fr?n b?rjan - case 2');
                    state = 0;
                    i = startPos;
                end
                
            case 3
                nextPixel = img(i+1,j);
                if(img(i,j) == 0)
                    %disp('Svart - case 3');
                    blackCounter = blackCounter + 1;
                    if(blackCounter >= lowerRate*3*ratio && blackCounter <= upperRate*3*ratio && nextPixel == 1)
                        %disp('Vidare till vit - case 3');
                        state = 4;
                        blackCounter = 0;
                    end
                else
                    %disp('Tillbaka till start - case 3');
                    state = 0;
                    i = startPos;
                end
            case 4
                nextPixel = img(i+1,j);
                if(img(i,j) == 1)
                    %disp('VIT - case 4');
                    whiteCounter = whiteCounter+1;
                    if(whiteCounter >= lowerRate*ratio && whiteCounter <= upperRate*ratio &&  nextPixel == 0)
                        %disp('Vidare till svart - case 4');
                        state = 5;
                        whiteCounter = 0;
                    end
                else
                    %disp('Fel, b?rja om - case 4');
                    state = 0;
                    i = startPos;
                end
            case 5
                nextPixel = img(i+1,j);
                if(img(i,j) == 0)
                    %disp('Svart!');
                    blackCounter = blackCounter+1;
                    if(blackCounter >= lowerRate*ratio && blackCounter <= upperRate*ratio && nextPixel == 1)
                        %disp('Klar - b?rja om');
                        
                        coordsY(counterCoordsY, 1) = j;
                        coordsY(counterCoordsY, 2) = i;
                        coordsY(counterCoordsY, 3) = j;
                        coordsY(counterCoordsY, 4) = startPos;
                    
                        counterCoordsY = counterCoordsY +1;

                        i = startPos;
                        state = 0;
                    end
                else
                    %disp('Fel, b?rja om - case 5');
                    state = 0;
                    i = startPos;
                end
            otherwise
                %disp('n?nting gick fel');
                state = 0;
        end
        i = i+1;
    end
    state = 0;
    i=1;
end

figure;
% -------------------------- PLOT SHIT
imshow(img);
hold on;

coordsX = coordsX(1:counterCoordsX,:);
coordsY = coordsY(1:counterCoordsY,:);
coordsX = sortrows(coordsX,1);
coordsY = sortrows(coordsY,1);

for i=1:counterCoordsX
    plot([coordsX(i,1),coordsX(i,3)],[coordsX(i,2),coordsX(i,4)],'Color','r','LineWidth',1);
end
hold on

for i=1:counterCoordsY
    plot([coordsY(i,1),coordsY(i,3)],[coordsY(i,2),coordsY(i,4)],'Color','r','LineWidth',1);
end
pause;




    