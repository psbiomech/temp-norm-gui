function outNames = repblanks(inNames, repChar)

outNames = inNames;
for i = 1:length(inNames);
    outName = deblank(char(inNames(i)));
    spaceIndexes = isspace(outName);
    outName(spaceIndexes) = repChar;
    outNames(i) = cellstr(outName);
end
