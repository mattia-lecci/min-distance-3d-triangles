function b = closestEdgePoints(iTri1Pt, iClosestPtToTri1,...
    iTri2Pt, iClosestPtToTri2, iSepDir)
%CLOSESTEDGEPOINTS Find a direction that demonstrates that the current side
%is closest and separates the triangles.
%
% INPUT:
% - iTri1Pt, iClosestPtToTri1, iTri2Pt, iClosestPtToTri2, iSepDir: 1x3
% arrays
%
% OUTPUT:
% - b: boolean answer
%
%Reference: Shellshear, E., & Ytterlid, R. (2014). Fast Distance Queries
%for Triangles, Lines, and Points using SSE Instructions. Journal of
%Computer Graphics Techniques (JCGT), 3(4), 86–110. Retrieved from
%http://jcgt.org/published/0003/04/05/

awayDirection = iTri1Pt - iClosestPtToTri1;
isDiffDirection = dot(awayDirection, iSepDir);

awayDirection = iTri2Pt - iClosestPtToTri2;
isSameDirection = dot(awayDirection, iSepDir);

b = (isDiffDirection <= 0) &&...
    (isSameDirection >= 0);
end