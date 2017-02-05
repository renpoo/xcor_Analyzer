function P = PHI_xy_( x, y )

Nx = length(x);
Ny = length(y);

if (Nx ~= Ny)
    P = NaN;
    return;
end;


N2 = 2 * Nx - 1;
P = zeros(1, N2);


normX = sqrt(x * x');
if (normX == 0.0)
    P = NaN(1, N2, 'double');
    return;
end

normY = sqrt(y * y');
if (normY == 0.0)
    P = NaN(1, N2, 'double');
    return;
end


detXY = normX * normY;


for m = -Nx+1 : -1
    P(Nx+m) = rowCC_(y, x, -m, Nx);
end;

for m = 0 : Nx-1
    P(Nx+m) = rowCC_(x, y, m, Nx);
end;

P = P / detXY;

end


function Rxy = rowCC_(x, y, m, N)
    xSub = x((m+1):N);
    ySub = y(1:(N-m));
    Rxy = xSub * ySub';
end
