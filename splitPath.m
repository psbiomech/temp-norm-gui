% pathParts = splitPath(fullPath)
function pathParts = splitPath(fullPath)

slashIndexes = findstr('\', fullPath);
startPath = 1;
for i = 1:length(slashIndexes)
    pathParts(i) = cellstr(fullPath(startPath:slashIndexes(i)-1));

    pathParts(i) = cellstr(fullPath(startPath:slashIndexes(i)-1));
    startPath = slashIndexes(i) + 1;
end  
pathParts(i+1) = cellstr(fullPath(slashIndexes(i)+1:end));