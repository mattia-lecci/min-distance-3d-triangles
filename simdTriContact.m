function areTriInContact = simdTriContact(iTri1, iTri2)
%SIMDTRICONTACT Check if the triangles touch each other
%
% INPUT:
% - iTri1, iTri2: triangles as 1x9 arrays
%
% OUTPUT:
% - areTriInContact: boolean
%
%Reference: Shellshear, E., & Ytterlid, R. (2014). Fast Distance Queries
%for Triangles, Lines, and Points using SSE Instructions. Journal of
%Computer Graphics Techniques (JCGT), 3(4), 86–110. Retrieved from
%http://jcgt.org/published/0003/04/05/

P1 = iTri1(1:3);
P2 = iTri1(4:6);
P3 = iTri1(7:9);

Q1 = iTri2(1:3);
Q2 = iTri2(4:6);
Q3 = iTri2(7:9);

p1 = [0, 0, 0]; % P1 - P1;
p2 = P2 - P1;
p3 = P3 - P1;

q1 = Q1 - P1;
q2 = Q2 - P1;
q3 = Q3 - P1;

e1 = P2 - P1;
e2 = P3 - P2;

f1 = Q2 - Q1;
f2 = Q3 - Q2;

mask = true;

n1 = cross(e1, e2);
mask = mask && simdProject6(n1,p1,p2,p3,q1,q2,q3);
if ~any(mask)
    areTriInContact = false;
    return
end

m1 = cross(f1, f2);
mask = mask && simdProject6(m1,p1,p2,p3,q1,q2,q3);
if ~any(mask)
    areTriInContact = false;
    return
end

ef11 = cross(e1, f1);
mask = mask && simdProject6(ef11,p1,p2,p3,q1,q2,q3);
if ~any(mask)
    areTriInContact = false;
    return
end

ef12 = cross(e1, f2);
mask = mask && simdProject6(ef12,p1,p2,p3,q1,q2,q3);
if ~any(mask)
    areTriInContact = false;
    return
end

f3 = q1 - q3;
ef13 = cross(e1, f3);
mask = mask && simdProject6(ef13,p1,p2,p3,q1,q2,q3);
if ~any(mask)
    areTriInContact = false;
    return
end

ef21 = cross(e2, f1);
mask = mask && simdProject6(ef21,p1,p2,p3,q1,q2,q3);
if ~any(mask)
    areTriInContact = false;
    return
end

ef22 = cross(e2, f2);
mask = mask && simdProject6(ef22,p1,p2,p3,q1,q2,q3);
if ~any(mask)
    areTriInContact = false;
    return
end

ef23 = cross(e2, f3);
mask = mask && simdProject6(ef23,p1,p2,p3,q1,q2,q3);
if ~any(mask)
    areTriInContact = false;
    return
end

e3 = p1 - p3;
ef31 = cross(e3, f1);
mask = mask && simdProject6(ef31,p1,p2,p3,q1,q2,q3);
if ~any(mask)
    areTriInContact = false;
    return
end

ef32 = cross(e3, f2);
mask = mask && simdProject6(ef32,p1,p2,p3,q1,q2,q3);
if ~any(mask)
    areTriInContact = false;
    return
end

ef33 = cross(e3, f3);
mask = mask && simdProject6(ef33,p1,p2,p3,q1,q2,q3);
if ~any(mask)
    areTriInContact = false;
    return
end

g1 = cross(e1, n1);
mask = mask && simdProject6(g1,p1,p2,p3,q1,q2,q3);
if ~any(mask)
    areTriInContact = false;
    return
end

g2 = cross(e2, n1);
mask = mask && simdProject6(g2,p1,p2,p3,q1,q2,q3);
if ~any(mask)
    areTriInContact = false;
    return
end

g3 = cross(e3, n1);
mask = mask && simdProject6(g3,p1,p2,p3,q1,q2,q3);
if ~any(mask)
    areTriInContact = false;
    return
end

h1 = cross(f1, m1);
mask = mask && simdProject6(h1,p1,p2,p3,q1,q2,q3);
if ~any(mask)
    areTriInContact = false;
    return
end

h2 = cross(f2, m1);
mask = mask && simdProject6(h2,p1,p2,p3,q1,q2,q3);
if ~any(mask)
    areTriInContact = false;
    return
end

h3 = cross(f3, m1);
mask = mask && simdProject6(h3,p1,p2,p3,q1,q2,q3);
if ~any(mask)
    areTriInContact = false;
    return
end

areTriInContact = true;

end