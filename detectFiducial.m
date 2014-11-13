function [pixelSize, fid1, fid2, fid3] = detectFiducial(img)

counting = -1;
startPos = 0;
ratio = 0;
blackOrWhite = 0;

currentRow = zeros(1,41);

state = 0;
whiteCounter = 0;
blackCounter = 0;

for i = 3 : 41
    for j = 1 : 41
        switch state
            case 0
                if(img(i,j) == 0)
                    disp('case 0');
                    startPos = j;
                    state = 1;
                    ratio = 0;
                    ratio = ratio + 1;
                    j
                end
                
            case 1
                disp('hitta svart ratio');
                if(img(i,j) == 0)
                    ratio = ratio + 1;
                else
                    state = 2;
                end
                
            case 2
              disp('räkna vita * ratio'); 
                if(img(i,j) == 1)
                    whiteCounter = whiteCounter+1;
                    if(whiteCounter == ratio)
                        state = 3;
                        whiteCounter = 0;
                    end
                else
                    state = 0;
                    pause;
                    j = startPos + 1;
                end
                
            case 3
                disp('räkna svarta * ratio *3');
                if(img(i,j) == 0)
                    blackCounter = blackCounter + 1;
                    if(blackCounter == ratio*3)
                        state = 4;
                        blackCounter = 0;
                    end
                else
                    state = 0;
                    j = startPos + 1;
                end
            case 4
               disp('räkna vita * ratio');
                if(img(i,j) == 1)
                    whiteCounter = whiteCounter+1;
                    if(whiteCounter == ratio)
                        state = 5;
                        whiteCounter = 0;
                    end
                else
                    state = 0;
                    j = startPos + 1;
                end
            case 5
                disp('räkna svarta*ratio');
                if(img(i,j) == 0)
                    blackCounter = blackCounter+1;
                    if(blackCounter == ratio)
                        state = 0;
                        blackCounter = 0;
                        disp('HEEEJ DONE');
                    end
                else
                    state = 0;
                    j = startPos + 1;
                end
            otherwise
                disp('nånting gick fel');
                state = 1;
        end
    end
end





    
    %1. hitta 0 
    %2. kolla hur många 0
    %3. hitta 1
    %4. lika många 1
    
    