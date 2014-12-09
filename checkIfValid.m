function[action] = checkIfValid(col, row)

action = true;

% Upper left fid
if(col < 9 && row < 9)
    action = false;
elseif (col < 9 && row > 33) % Lower left fid
    action = false;
elseif (col > 33 && row < 9) % Upper right dif
    action = false;
elseif (col < 38 && col > 32 && row < 38 && row > 32) % Aligment pattern
    action = false;
end

    