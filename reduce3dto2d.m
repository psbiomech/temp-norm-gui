function array2d = reduce3dto2d(array3d);

[l, m, n] = size(array3d);

point = 1;
for i = 1:3:m*n;
    array2d(:,i:i+2) = squeeze(array3d(:,point,:));
    point = point + 1;
end