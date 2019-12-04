function b = simdProject6(ax, p1, p2, p3, q1, q2, q3)
%SIMDPROJECT6 A common subroutine for each separating direction
%
% INPUT:
% - ax: 3x1 array
% - p1, p2, p3: 3x1 arrays
% - q1, q2, q3: 3x1 arrays
%
% OUTPUT:
% - b: boolean
%
%Reference: Shellshear, E., & Ytterlid, R. (2014). Fast Distance Queries
%for Triangles, Lines, and Points using SSE Instructions. Journal of
%Computer Graphics Techniques (JCGT), 3(4), 86–110. Retrieved from
%http://jcgt.org/published/0003/04/05/

P1 = dot(ax, p1);
P2 = dot(ax, p2);
P3 = dot(ax, p3);

Q1 = dot(ax, q1);
Q2 = dot(ax, q2);
Q3 = dot(ax, q3);

mx1 = max([P1,P2,P3]);
mn1 = min([P1,P2,P3]);
mx2 = max([Q1,Q2,Q3]);
mn2 = min([Q1,Q2,Q3]);

b =  (mn1 <= mx2) && (mn2 <= mx1);
end