function [dist, oTriAPoint, oTriBPoint] = closestVertToTri(iTriA, iTriB)
%CLOSESTVERTTOTRI Compute the distance between iTriB vertexes and
%another triangle iTriA
%
% INPUT:
% - iTriA, iTriB: 1x9 arrays representing triangles in 3D space
%
% OUTPUT:
% - dist: distance of closest vertex of iTriB from iTriA
% - oTriAPoint, oTriBPoint: corresponding minimum distance points as
% 1x3 arrays
%
%Reference: Shellshear, E., & Ytterlid, R. (2014). Fast Distance Queries
%for Triangles, Lines, and Points using SSE Instructions. Journal of
%Computer Graphics Techniques (JCGT), 3(4), 86–110. Retrieved from
%http://jcgt.org/published/0003/04/05/

[A, Ap] = simdTriPoint2(iTriA, iTriB(1:3));
[B, Bp] = simdTriPoint2(iTriA, iTriB(4:6));
[C, Cp] = simdTriPoint2(iTriA, iTriB(7:9));

if A < B
    ABdist = A;
    ABp = Ap;
else
    ABdist = B;
    ABp = Bp;
end

if ABdist < C
    oTriAPoint = ABp;
    if A < B
        oTriBPoint = iTriB(1:3);
    else
        oTriBPoint = iTriB(4:6);
    end
    dist = ABdist;
else
    oTriAPoint = Cp;
    oTriBPoint = iTriB(7:9);
    dist = C;
end

end