//@
x = 0:4;
 y = zeros(1,5);
  y(3) = 2; 
  t = linspace(0,4,2^9);
sample = interp1(x,y,t);
//
noise = wnoise(5,9);		// G‰¹‚Ìì¬
nsample = sample+0.1*noise;	// G‰¹‚ğd‚Ë‚Ü‚·B
