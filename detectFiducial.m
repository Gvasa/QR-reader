function [pixelSize, fid1, fid2, fid3] = detectFiducial(img)

startPos = 0;
ratio = 0;
state = 0;
whiteCounter = 0;
blackCounter = 0;

coordsX = zeros(11,4);
coordsY = zeros(11,4);

counterCoordsX = 1;
counterCoordsY = 1;

j=1;
c = 0;

for i = 1 : 41
    while(j<42)
        switch state
            case 0
                if(img(i,j) == 0)
                    disp('Svart - case 0');
                    startPos = j;
                    state = 1;
                    ratio = 1;
                    whiteCounter = 0;
                    blackCounter = 0;
                end
                
            case 1
                if(img(i,j) == 0)
                    disp('Svart - case 1');
                    ratio = ratio + 1;
                else
                    disp('Vidare till vit - Case 1');
                    state = 2;
                    j = j-1;
                end
                
            case 2
                if(img(i,j) == 1)
                    disp('Vit - case 2'); 
                    whiteCounter = whiteCounter+1;
                    if(whiteCounter == ratio)
                        disp('Vidare till svart - case 2');
                        state = 3;
                        whiteCounter = 0;
                    end
                else
                    disp('Tillbaka fr?n b?rjan - case 2');
                    state = 0;
                    j = startPos + 1;
                end
                
            case 3
                if(img(i,j) == 0)
                    disp('Svart - case 3');
                    blackCounter = blackCounter + 1;
                    if(blackCounter == ratio*3)
                        disp('Vidare till vit - case 3');
                        state = 4;
                        blackCounter = 0;
                    end
                else
                    disp('Tillbaka till start - case 3');
                    state = 0;
                    j = startPos + 1;
                end
            case 4
                if(img(i,j) == 1)
                    disp('VIT - case 4');
                    whiteCounter = whiteCounter+1;
                    if(whiteCounter == ratio)
                        disp('Vidare till svart - case 4');
                        state = 5;
                        whiteCounter = 0;
                    end
                else
                    disp('Fel, b?rja om - case 4');
                    state = 0;
                    j = startPos + 1;
                end
            case 5
                if(img(i,j) == 0)
                    disp('Svart!');
                    blackCounter = blackCounter+1;
                    if(blackCounter == ratio)
                        disp('Klar - b?rja om');
                        %img(i,startPos) = 1;
                        %img(i,j) = 1;
                        
                        coordsX(counterCoordsX, 1) = j;
                        coordsX(counterCoordsX, 2) = i;
                        coordsX(counterCoordsX, 3) = startPos;
                        coordsX(counterCoordsX, 4) = i;
                    
                        counterCoordsX = counterCoordsX +1;

                        j = startPos + 1;
                        state = 0;
                    end
                else
                    disp('Fel, b?rja om - case 5');
                    state = 0;
                    j = startPos + 1;
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


for j = 1 : 41
    while(i<42)
        switch state
            case 0
                if(img(i,j) == 0)
                    disp('Svart - case 0');
                    startPos = i;
                    state = 1;
                    ratio = 1;
                    whiteCounter = 0;
                    blackCounter = 0;
                end
                
            case 1
                if(img(i,j) == 0)
                    disp('Svart - case 1');
                    ratio = ratio + 1;
                else
                    disp('Vidare till vit - Case 1');
                    state = 2;
                    i = i-1;
                end
                
            case 2
                if(img(i,j) == 1)
                    disp('Vit - case 2'); 
                    whiteCounter = whiteCounter+1;
                    if(whiteCounter == ratio)
                        disp('Vidare till svart - case 2');
                        state = 3;
                        whiteCounter = 0;
                    end
                else
                    disp('Tillbaka fr?n b?rjan - case 2');
                    state = 0;
                    i = startPos + 1;
                end
                
            case 3
                if(img(i,j) == 0)
                    disp('Svart - case 3');
                    blackCounter = blackCounter + 1;
                    if(blackCounter == ratio*3)
                        disp('Vidare till vit - case 3');
                        state = 4;
                        blackCounter = 0;
                    end
                else
                    disp('Tillbaka till start - case 3');
                    state = 0;
                    i = startPos + 1;
                end
            case 4
                if(img(i,j) == 1)
                    disp('VIT - case 4');
                    whiteCounter = whiteCounter+1;
                    if(whiteCounter == ratio)
                        disp('Vidare till svart - case 4');
                        state = 5;
                        whiteCounter = 0;
                    end
                else
                    disp('Fel, b?rja om - case 4');
                    state = 0;
                    i = startPos + 1;
                end
            case 5
                if(img(i,j) == 0)
                    disp('Svart!');
                    blackCounter = blackCounter+1;
                    if(blackCounter == ratio)
                        disp('Klar - b?rja om');
                        %img(i,startPos) = 1;
                        %img(i,j) = 1;
                        
                        coordsY(counterCoordsY, 1) = j;
                        coordsY(counterCoordsY, 2) = i;
                        coordsY(counterCoordsY, 3) = j;
                        coordsY(counterCoordsY, 4) = startPos;
                    
                        counterCoordsY = counterCoordsY +1;

                        i = startPos + 1;
                        state = 0;
                    end
                else
                    disp('Fel, b?rja om - case 5');
                    state = 0;
                    i = startPos + 1;
                end
            otherwise
                disp('n?nting gick fel');
                state = 0;
        end
        i = i+1;
    end
    state = 0;
    i=1;
end

coordsX
coordsX = sortrows(coordsX,1)
figure,imshow(img)
hold on
for i=1:(11)
    plot([coordsX(i,1),coordsX(i,3)],[coordsX(i,2),coordsX(i,4)],'Color','r','LineWidth',1);
end
hold on

for i=1:11
    plot([coordsY(i,1),coordsY(i,3)],[coordsY(i,2),coordsY(i,4)],'Color','r','LineWidth',1);
end





    
    %1. hitta 0 
    %2. kolla hur m?nga 0
    %3. hitta 1
    %4. lika m?nga 1
    
    