function xyz = lorenz( t, y )
   s = 10;
   b = 8/3;
   r = 28;
   xyz = [ -s .* y(1) + s .* y(2),
            r .* y(1) - y(2) - y(1) .* y(3),
            y(1) .* y(2) - b .* y(3) ];
end