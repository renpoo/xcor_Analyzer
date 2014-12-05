function p=CrossCorrelation_(x,window_size)
p = zeros(1,window_size);
pOrg = zeros(1,window_size);
pCustom = zeros(1,window_size);


den1org = 0.0;

for n=1:window_size,
   den1org = den1org + x(n)*x(n);
end


#den1custom = x' * x;
den1custom = x(1:window_size)' * x(1:window_size);
#disp(den1org);
#disp(den1custom);
#return;

den1org = sqrt(den1org);
den1custom = sqrt(den1custom);


if (1),
  for m=1:window_size,
    den2org = 0.0;

    for n=1:window_size,
        den2org = den2org + x(n+m-1)*x(n+m-1);
    endfor;

    den2org = sqrt(den2org);

    for n=1:window_size,
      pOrg(m) = pOrg(m) + x(n) * x(n+m-1);
    endfor;

    pOrg(m) = pOrg(m) / (den1org * den2org);
  endfor;
endif;


if (1),
  for m=1:window_size,
    den2custom = 0.0;
    x_sub = x(1:window_size);
    x_sub_shift_m = x(m:window_size+m-1);
    den2custom = x_sub_shift_m' * x_sub_shift_m;
    den2custom = sqrt(den2custom);

    pCustom(m) = x_sub' * x_sub_shift_m;
    pCustom(m) = pCustom(m) / (den1custom * den2custom);
  endfor;
endif;


#disp(den2org);
#disp(den2custom);


#disp(pOrg);
#disp(pCustom);
#disp(pCustom - pOrg);


p = pOrg;
#p = pCustom;
#p = pCustom - pOrg;
