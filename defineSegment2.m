function [origin, xAxis, yAxis, zAxis] = defineSegment2(segmentOrigin,defLine1,defLine2,token)

   %   This method of defining a segment is analogous to the BodyBuilder
   %   technique

if token == 'yzx'

    origin = segmentOrigin;
    yAxis = peteUnit(defLine1);
    zAxis = peteUnit(cross(defLine2,yAxis));
    xAxis = peteUnit(cross(yAxis,zAxis));

elseif token == 'yxz'

    origin = segmentOrigin;
    yAxis = peteUnit(defLine1);
    xAxis = peteUnit(cross(defLine2,yAxis));
    zAxis = peteUnit(cross(xAxis,yAxis));

elseif token == 'zxy'

    origin = segmentOrigin;
    zAxis = peteUnit(defLine1);
    xAxis = peteUnit(cross(defLine2,zAxis));
    yAxis = peteUnit(cross(xAxis,zAxis));

elseif token == 'zyx'
    origin = segmentOrigin;
    zAxis = peteUnit(defLine1);
    yAxis = peteUnit(cross(defLine2,zAxis));
    xAxis = peteUnit(cross(yAxis,zAxis));


elseif token == 'xzy'
    origin = segmentOrigin;
    xAxis = peteUnit(defLine1);
    zAxis = peteUnit(cross(defLine2,xAxis));
    yAxis = peteUnit(cross(zAxis,xAxis));

end

