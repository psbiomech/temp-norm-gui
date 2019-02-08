function outputStringParts = splitstring(inputStrings, splitChar)


%%   Convert splitChar from cell to char if required

if iscell(splitChar)
    splitChar = char(splitChar);
end

numStrings = length(inputStrings);


%%  Break inputString into strings between the splitChars)
for i = 1:numStrings
    
    if iscell(inputStrings)
        inputString = char(inputStrings(i));
    else
        inputString = inputStrings(i,:);
    end
    
    splitCharIndexes = findstr(splitChar, inputString);
    if isempty(splitCharIndexes) == 0
        startName = 1;
        for j = 1:length(splitCharIndexes)
            outputStringParts(i,j) = cellstr(inputString(startName:splitCharIndexes(j)-1));
            startName = splitCharIndexes(j) + 1;
        end
        outputStringParts(i,j+1) = cellstr(inputString(splitCharIndexes(j)+1:end));
    else
        outputStringParts(i) = cellstr(inputString);
    end
end


