function [dist, oTriPoint] = simdTriPoint2(iTri, iPoint)
%SIMDTRIPOINT2 Compute minimum distance between point and triangle
%
% INPUT:
% - iTri: 1x9 array
% - iPoint: 1x3 array
%
% OUTPUT:
% - dist: minimum distance between the given triangle and point
% - oTriPoint: point of minimum distance from
%
%Reference: Shellshear, E., & Ytterlid, R. (2014). Fast Distance Queries
%for Triangles, Lines, and Points using SSE Instructions. Journal of
%Computer Graphics Techniques (JCGT), 3(4), 86–110. Retrieved from
%http://jcgt.org/published/0003/04/05/

ab = iTri(4:6) - iTri(1:3);
ac = iTri(7:9) - iTri(1:3);
ap = iPoint - iTri(1:3);
d1 = dot(ab, ap);
d2 = dot(ac, ap);
mask1 = (d1 <= 0) & (d2 <= 0);
oTriPoint = iTri(1:3);
exit = mask1;
if all(exit)
    dist = norm(oTriPoint - iPoint);
    return
end

bp = iPoint - iTri(4:6);
d3 = dot(ab, bp);
d4 = dot(ac, bp);
mask2 = (d3 >= 0) & (d4 <= d3);
% Closest point is the point iTri(4:6). Update if necessary.
if ~exit && mask2
    oTriPoint = iTri(4:6);
end

exit = exit || mask2;
if all(exit)
    dist = norm(oTriPoint - iPoint);
    return
end

cp = iPoint - iTri(7:9);
d5 = dot(ab, cp);
d6 = dot(ac, cp);
mask3 = (d6>=0) & (d5<=d6);
% Closest point is the point iTri(7:9). Update if necessary.
if ~exit && mask3
    oTriPoint = iTri(7:9);
end

exit = exit || mask3;
if all(exit)
    dist = norm(oTriPoint - iPoint);
    return
end

vc = d1*d4 - d3*d2;
mask4 = (vc <= 0) & (d1 >= 0) & (d3 <= 0);
v1 = d1/ (d1 - d3);
answer1 = iTri(1:3) + v1* ab;
% Closest point is on the line ab. Update if necessary.
if ~exit && mask4
    oTriPoint = answer1;
end

exit = exit || mask4;
if all(exit)
    dist = norm(oTriPoint - iPoint);
    return
end

vb = d5*d2 - d1*d6;
mask5 = (vb <= 0) & (d2 >= 0) & (d6 <= 0);
w1 = d2/ (d2 - d6);
answer2 = iTri(1:3) + w1* ac;
% Closest point is on the line ac. Update if necessary.
if ~exit && mask5
    oTriPoint = answer2;
end

exit = exit || mask5;
if all(exit)
    dist = norm(oTriPoint - iPoint);
    return
end

va = d3*d6 - d5*d4;
mask6 = (va <= 0) & ((d4 - d3) >= 0) & ((d5 - d6) >= 0);
w2 = (d4 - d3) / ((d4 - d3) + (d5 - d6));
answer3 = iTri(4:6) + w2*(iTri(7:9) - iTri(4:6));
% Closest point is on the line bc. Update if necessary.
if ~exit && mask6
    oTriPoint = answer3;
end

exit = exit || mask6;
if all(exit)
    dist = norm(oTriPoint - iPoint);
    return
end

denom = 1 / (va + vb + vc);
v2 = vb * denom;
w3 = vc * denom;
answer4 = iTri(1:3) + ab * v2+ ac * w3;
mask7 = norm(answer4 - iPoint) < norm(oTriPoint - iPoint);
% Closest point is inside triangle. Update if necessary.
if ~exit && mask7
    oTriPoint = answer4;
end

dist = norm(oTriPoint - iPoint);

end