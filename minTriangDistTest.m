clear
close all
clc

% Code coverage and debug: check for errors and warnings
for i = 1:10000
    T1 = randn(1,9);
    T2 = randn(1,9);
    [d,p1,p2] = simdTriTri2(T1,T2);
end