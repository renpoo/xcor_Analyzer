function P = PHI_xy_( x, y, LRCflag )

Nx = length(x);
Ny = length(y);


if ( LRCflag == 'L' )
    P = zeros(1, Nx);
    for m = -Nx+1 : 0
        P(Nx+m) = rowCC_(y, x, -m, Nx);
    end
%     for m = 0 : Ny-1
%         P(m+1) = rowCC_(x, y, m, Ny);
%     end
elseif ( LRCflag == 'R' )
    P = zeros(1, Ny);
    for m = 0 : Ny-1
        P(m+1) = rowCC_(x, y, m, Ny);
    end
else
    P = zeros(1, 2 * Nx - 1);
    for m = -Nx+1 : -1
        P(Nx+m) = rowCC_(y, x, -m, Nx);
    end
    
    for m = 0 : Nx-1
        P(Nx+m) = rowCC_(x, y, m, Nx);
    end
end


end


function Rxy = rowCC_(x, y, m, N)
xSub = x( (m+1) : N );
ySub = y( 1 : (N-m) );
%Rxy = xSub * ySub';
Rxy = xSub' * ySub;
end
