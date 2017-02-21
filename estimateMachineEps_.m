function eps = estimateMachineEps_()

eps = 1.0;
one = 0.0;

while 1
    eps = 0.5 * eps;
    one = eps + 1.0;
    if (one == 1.0) break; end;
end

eps = 2.0 * eps;

end
