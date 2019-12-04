function [dist, oLine1Point, oLine2Point] = simdSegmentSegment2(iLine1, iLine2)
%SIMDSEGMENTSEGMENT2 Compute minimum distance between two segments
%
% INPUT:
% - iLine1, iLine2: segments as 1x6 arrays
%
% OUTPUT:
% - dist: minimum distance between the given segments
% - oLine1Point, oLine2Point: points with minimum distance on the given
% segments
%
%Reference: Shellshear, E., & Ytterlid, R. (2014). Fast Distance Queries
%for Triangles, Lines, and Points using SSE Instructions. Journal of
%Computer Graphics Techniques (JCGT), 3(4), 86–110. Retrieved from
%http://jcgt.org/published/0003/04/05/

dir1 = iLine1(4:6) - iLine1(1:3);
dir2 = iLine2(4:6) - iLine2(1:3);
lineDiff = iLine1(1:3) - iLine2(1:3);
% The following are a set of values to assist computations
a = dot(dir1, dir1);
e = dot(dir2, dir2);
f = dot(dir2, lineDiff);
c = dot(dir1, lineDiff);
b = dot(dir1, dir2);

% s and t are the parameter values from iLine1and iLine2.
denom = a*e-b*b;
denom = max(denom, eps(denom));
s = clamp((b*f - c*e) / denom, 0, 1);
e = max(e, eps(e));
t = (b*s + f) / e;
% If t in [0,1] done. Else clamp t, recompute s for the new value of t and clamp s to [0, 1]
newT = clamp(t, 0, 1);
if newT ~= t
    % Now choose correct values for s based on what positions the line segments were in.
    s = clamp((newT*b - c) / a, 0, 1);
end
% Compute closest points and return distance.
oLine1Point = iLine1(1:3) + dir1* s;
oLine2Point = iLine2(1:3) + dir2* newT;
dist = norm(oLine1Point - oLine2Point);
end