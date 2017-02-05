function detXY = initial_PHI_xy_( x, y )

% if (length(x) ~= length(y))
%     detXY = NaN;
%     return;
% end

normX = sqrt(x * x');
normY = sqrt(y * y');

if (normX == 0.0 || normY == 0.0)
    detXY = NaN;
    return;
end


detXY = normX * normY;

end
