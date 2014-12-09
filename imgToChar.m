function[charMat] = imgToChar(img)
 
% Qr code version six can have 183 chars and each is 8 bits.
binMat = zeros(183, 8);
 
RowCounter = 1;
ColCounter = 1;

% Iterate and check if it's black our white(0 or 1) an add this to the
% matrix
for col = 1 : 41
    for row = 1 : 41
         if(checkIfValid(row, col) == 1)
             binMat(RowCounter, ColCounter) = img(row, col);

             if(ColCounter == 8)
                 RowCounter = RowCounter+1;
                 ColCounter = 1;
             else
                 ColCounter = ColCounter+1;
             end
         end
    end
end
RowCounter-1;

% Matrix of characters
charMat = zeros(1, RowCounter);

% Check each row and calculate which character it will be.
for i = 1:183
     charMat(1,i) = bi2de(fliplr(binMat(i, :)));
    if binMat(i, :) == 0
        charMat = charMat(1, 1:i-1);
        break;
    end
end