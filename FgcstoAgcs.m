%   FgcstoAgcs.m
%
%   Transformation of coordinates in transmitters GCS to alternative GCS defined by user
%
%   Written by:             Peter Mills 
%   Last modified:          10.03.2003

function p = FgcstoAgcs(P,P1,P2,P3,p1,p2,p3);

%   P1 is the position of the first point used to define the alternate global coordinate system, defined in the current GCS
%   P2 is the position of the second point used to define the alternate global coordinate system, in the current GCS
%   P3 is the position of the third point used to define the alternate global coordinate system, in the current GCS
%   p1 is the position of the first point used to define the alternate global coordinate system, in the new GCS
%   p2 is the position of the second point used to define the alternate global coordinate system, in the new GCS
%   p3 is the position of the third point used to define the alternate global coordinate system, in the new GCS
%   P is the position of the point to be transformed, defined in the current GCS
%   p is the position of the point to be transformed, defined in the new GCS

XYZ = [P1;P2;P3];
xyz = [p1;p2;p3];

%   Use modified soder function to generate 4*4 Transformation matrix [T]
[T, res] = Fsoder(XYZ, xyz);

%   Calculate inverse of T
inT = inv(T);

%   Calculate virtual point position in LCS through multiplication with inverse of transformation matrix: [P2] = [inT] * [p2]
p = T*[1 P]';
