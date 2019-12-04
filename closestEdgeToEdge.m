function [dist, oIsFinished, oTriAPoint, oTriBPoint] = closestEdgeToEdge(...
    oIsFinished, iTriAEdges, iTriBEdge, iTriBLastPt)
%CLOSESTEDGETOEDGE Compute the distance between a triangle edge and another
%triangle’s edges
%
% INPUT:
% - oIsFinished (I/O): flag
% - iTriAEdges: edges of triangle A as 3x6 array
% - iTriBEdge: edge of triangle B as 1x6 array
% - iTriBLastPt: vertex not included in iTriBEdge as 1x3 array
%
% OUTPUT:
% - dist
% - oIsFinished (I/O): updated flag
% - oTriAPoint, oTriBPoint: corresponding minimum distance points as
% 1x3 arrays
%
%Reference: Shellshear, E., & Ytterlid, R. (2014). Fast Distance Queries
%for Triangles, Lines, and Points using SSE Instructions. Journal of
%Computer Graphics Techniques (JCGT), 3(4), 86–110. Retrieved from
%http://jcgt.org/published/0003/04/05/

% Test the triangle edge against all three edges of the triangle iTriA.
[A, oTriAPoint, oTriBPoint] = simdSegmentSegment2(iTriAEdges(1,:), iTriBEdge);

%Test to see if the distances found so far were the closest
separatingDir = oTriBPoint - oTriAPoint;
oIsFinished = oIsFinished ||...
    closestEdgePoints(iTriAEdges(2, 1:3), oTriAPoint,...
    iTriBLastPt, oTriBPoint, separatingDir);

if all(oIsFinished)
    dist = A;
    return
end

[B, A2p, B2p] = simdSegmentSegment2(iTriAEdges(2,:), iTriBEdge);
separatingDir = B2p - A2p;
oIsFinished = oIsFinished ||...
    closestEdgePoints(iTriAEdges(3,1:3), A2p,...
    iTriBLastPt, B2p, separatingDir);

if A < B
    ABdist = A;
else
    ABdist = B;
    oTriAPoint = A2p;
    oTriBPoint = B2p;
end

if all(oIsFinished)
    dist = ABdist;
    return
end

[C, A3p, B3p] = simdSegmentSegment2(iTriAEdges(3,:), iTriBEdge);
separatingDir = B3p - A3p;
oIsFinished = oIsFinished ||...
    closestEdgePoints(iTriAEdges(1, 1:3), A3p,...
    iTriBLastPt, B3p, separatingDir);

if ABdist < C
    dist = ABdist;
else
    oTriAPoint = A3p;
    oTriBPoint = B3p;
    dist = C;
end

end