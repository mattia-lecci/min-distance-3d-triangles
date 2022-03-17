function y = clamp(x,lb,ub)
  y=min( max(x, lb), ub );
