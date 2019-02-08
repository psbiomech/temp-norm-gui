function stringIndexes = findstringincellarray(myString, myCellArray);
%
% stringIndexes = findstringincellarray(myString, myCellArray)
%
% FINDSTRINGINCELLARRAY returns the cell indexes of cells in 'myCellArray'
% that contain an occurance of the input character string 'myString'.
% An empty array is returned if no occurances are found. 
% findstringincellarray is case-sensitive

%   Peter Mills HMES UWA
%   August 11, 2004

A = zeros(length(myCellArray),1);
B = regexp(myCellArray, myString);
j = 1;

[m, n] = size(myCellArray);
for i = 1:length(myCellArray);
    if find(cell2mat(B(i))) ~= 0;
        stringIndexes(j) = i;
        j = j + 1;
    end
end

if exist('stringIndexes') == 0;
    %disp('??? No matching strings found in contents of cell array');
    stringIndexes = [];
    return
else
    stringIndexes = stringIndexes;
end