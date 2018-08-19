function output=variable(value)  
  val = value{1};
  if val == 1
    color = [.4 0.6 0.5];
  elseif val == 0
    color = [1 0.4 0.4];
  end
  output = color;
endfunction

## Matlab RGB Triplets

##white  = [1 1 1];
##black  = [0 0 0];
##lightGrey1   = [0.85 0.85 0.85];
##lightGrey2   = [0.7 0.7 0.7];
##
##darkGrey1  = [0.4 0.4 0.4];
##darkGrey2  = [0.2 0.2 0.2];
##cyan        = [0.2 0.8 0.8];
##brown       = [0.2 0 0];
##
##orange      = [1 0.5 0];
##blue        = [0 0.5 1];
##green       = [0 0.6 0.3];
##red         = [1 0.2 0.2];

##default bg  = [0.85 0.85 0.85]
##cool green  = [.4 0.6 0.5]
##cool red    = [1 0.4 0.4]