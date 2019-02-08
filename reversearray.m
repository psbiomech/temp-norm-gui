function reversedArray = reversearray(originalArray)

[m,n] = size(originalArray)
j = m;
for i = 1:m
    reversedArray(j,:) = originalArray(i,:);
    j = j-1;
end