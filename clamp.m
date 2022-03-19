function y = clamp(x, lb, ub)
%CLAMP Clamp a value between a lower and an upper bound
%
% INPUT:
% - x: input value
% - lb: lower bound
% - ub: upper bound
%
% OUTPUT:
% - y: clamped value

assert(lb <= ub, 'Lower bound must not be greater than upper bound');
y = min(max(lb, x), ub);
