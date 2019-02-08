% function [T,res] = Fsoder(x,y)%
% Description:	Program calculates the transformation matrix T containing
%		the rotation matrix (3x3) and the translation translation 
%		vector d (3x1) for a rigid body segment using a singular
%		value decomposition method (Soederkvist & Wedin 1993).
% 
% Input:    data:   columns represent the XYZ positions and the rows
%                   represent time. 
% Output:   T:      4x4 Matrix containing the rotation matrix R and the
%                   translation d: T = [R,d; 0 0 0 1]
%           res:    norm of residuals (measure of fit; "rigidity" of body
%
% References:     Soderkvist I. and Wedin P. -A., (1993). Determining the
%                 movements of the skeleton using well-configured markers.
%                 Journal of Biomechanics, 26:1473-1477      
%
% Author:	Christoph Reinschmidt, HPL, The University of Calgary
%               (Matlab code adapted from Ron Jacobs, 1993)
% Date:		February, 1995
% Last Changes: December 09, 1996
% Version:      3.1
%
    %%%%%%%%%%%%%%%%
    %   Adapted by:   Peter Mills         %
    %   Date:             07.03.2003       %
    %%%%%%%%%%%%%%%%
function [T,res] = Fsoder(x,y)

[nmarkers,ndimensions]=size(x);
% we could give an error message if ndimensions is not 3

mx=mean(x);
my=mean(y);
% construct matrices A and B, subtract the mean so there is only rotation
for i=1:nmarkers,
  A(i,:)=x(i,:)-mx;
  B(i,:)=y(i,:)-my;
end
A = A';
B = B';

C=B*A';
[P,T,Q]=svd(C);
R=P*diag([1 1 det(P*Q')])*Q';
d=my'-R*mx';

%T=[1 0 0 0;d,R];
T = [R,d; 0 0 0 1];
% Calculating the norm of residuals
A=A'; A(4,:)=ones(1,size(A,2));
B=B';
Bcalc=T*A; Bcalc(4,:)=[]; Diff=B-Bcalc; Diffsquare=Diff.^2;
%DOF=3*(number of points)-6 unknowns (Hx,Hy,Hz,alpha,beta,gamma):
DOF=size(B,1)*size(B,2)-6;
res=[sum(Diffsquare(:))/DOF].^0.5;