function[action] = checkIfValid(col, row)

action = true;

if(col < 9 && row < 9)
    action = false;
elseif (col < 9 && row > 33)
    action = false;
elseif (col > 33 && row < 9)
    action = false;
elseif (col < 38 && col > 32 && row < 38 && row > 32)
    action = false;
end

    