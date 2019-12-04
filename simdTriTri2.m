function [minDistTriTri, oTri1Point, oTri2Point] = simdTriTri2(iTri1, iTri2)
%SIMDTRITRI2 Minimum distance between two given triangles.
%
% INPUT:
% - iTri1, iTri2: 1x9 arrays representing triangles in 3D space
%
% OUTPUT:
% - minDistTriTri: scalar
% - oTri1Point, oTri2Point: minimum distance points from each triangle as
% 1x3 arrays
%
%Reference: Shellshear, E., & Ytterlid, R. (2014). Fast Distance Queries
%for Triangles, Lines, and Points using SSE Instructions. Journal of
%Computer Graphics Techniques (JCGT), 3(4), 86–110. Retrieved from
%http://jcgt.org/published/0003/04/05/

% The three edges of the triangle. Keep orientation consistent.
tri1Edges = [iTri1(4:6), iTri1(1:3);...
    iTri1(7:9), iTri1(4:6);...
    iTri1(1:3), iTri1(7:9)];

tri2Edges = [iTri2(4:6), iTri2(1:3);...
    iTri2(7:9), iTri2(4:6);...
    iTri2(1:3), iTri2(7:9)];

isFinished = false;

%% Edge-to-edge distances
% All iTri1 edges against 1st iTri2 edge
[minDistTriTri, isFinished, oTri1Point, oTri2Point] = closestEdgeToEdge(...
    isFinished, tri1Edges, tri2Edges(1,:), iTri2(7:9));

if all(isFinished)
    return;
end

% All iTri1 edges against 2nd iTri2 edge
[tmpMinDist, isFinished, tri1Vector, tri2Vector] = closestEdgeToEdge(...
    isFinished, tri1Edges, tri2Edges(2,:), iTri2(1:3));

if tmpMinDist < minDistTriTri
    minDistTriTri = tmpMinDist;
    oTri1Point = tri1Vector;
    oTri2Point = tri2Vector;
else
    % do nothing
end

if all(isFinished)
    return;
end

% All iTri1 edges against 2nd iTri2 edge
[tmpMinDist, isFinished, tri1Vector, tri2Vector] = closestEdgeToEdge(...
    isFinished, tri1Edges, tri2Edges(3,:), iTri2(4:6));

if tmpMinDist < minDistTriTri
    minDistTriTri = tmpMinDist;
    oTri1Point = tri1Vector;
    oTri2Point = tri2Vector;
else
    % do nothing
end

if all(isFinished)
    return;
end

%% Now do vertex-triangle distances
[tmpMinDist, tri2Vector, tri1Vector] = closestVertToTri(iTri2, iTri1);
if tmpMinDist < minDistTriTri
    oTri1Point = tri1Vector;
    oTri2Point = tri2Vector;
    minDistTriTri = tmpMinDist;
else
    % do nothing
end

[tmpMinDist, tri1Vector, tri2Vector] = closestVertToTri(iTri1, iTri2);
if tmpMinDist < minDistTriTri
    oTri1Point = tri1Vector;
    oTri2Point = tri2Vector;
    minDistTriTri = tmpMinDist;
else
    % do nothing
end

%% We need to rule out the triangles colliding with each other. Hence test for collision.
if simdTriContact(iTri1, iTri2)
    minDistTriTri = 0;
    oTri1Point = nan(1, 3);
    oTri2Point = nan(1, 3);
else
    % do nothing
end

end