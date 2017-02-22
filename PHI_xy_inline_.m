function Rxy = PHI_xy_inline_( x, y )

Nx = length(x);
Ny = length(y);

if (Nx ~= Ny)
    P = NaN;
    return;
end;


N2 = 2 * Nx - 1;
P = zeros(1, N2);


normX = sqrt(x' * x);
if (normX == 0.0)
    P = NaN(1, N2, 'double');    
    return;
end

normY = sqrt(y' * y);
if (normY == 0.0)
    P = NaN(1, N2, 'double');    
    return;
end


detXY = normX * normY;


for m = -Nx+1 : -1
    xSub = y(-m+1:Nx);
    ySub = x(1:(Ny+m));
    Rxy(Nx+m) = xSub' * ySub;
end;

for m = 0 : Nx-1
    xSub = x((m+1):Nx);
    ySub = y(1:(Ny-m));
    Rxy(Nx+m) = xSub' * ySub;
end;

Rxy = Rxy / detXY;

end
