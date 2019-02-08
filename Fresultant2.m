%   Fresultant2.m
%   Calculates the magnitude (R) and the angles made with the z, y and x axes
%   respectively given the coordinates (x, y, z) of 2 points
%
%   Syntax [R abc] = Fresultant2(P1, P2);
%
%   See also: Fresultant1
%
%   Peter Mills
%   20.02.2003

function [R, abc] = Fresultant2(P1, P2);

if size (P1) ~= size (P2);
    disp('Error. The two sets of coordinate data must be equal in size')
    return
end

[m,n]= size(P1);
if n > 3;
    P1 = P1';
    P2 = P2';
end

[m,n]= size(P1);
if n == 3
    R = sqrt((P2(:,1)-P1(:,1)).^2 +  (P2(:,2)-P1(:,2)).^2+ (P2(:,3)-P1(:,3)).^2);
elseif n == 2
    R = sqrt((P2(:,1)-P1(:,1)).^2 +  (P2(:,2)-P1(:,2)).^2);
else
    error('Vectors must be either 2 or 3 dimensional')
end

%for i = 1:3;
   % abc(:, 1) = acos((P2(:, 1)-P1(:, 1))./R);
   % abc(:, 2) = acos((P2(:, 2)-P1(:, 2))./R);
   % abc(:, 3) = acos((P2(:, 3)-P1(:, 3))./R);
%end

for i = 1:n;
    abc(:,n) = acos((P2(:, n)-P1(:, n))./R);
end

