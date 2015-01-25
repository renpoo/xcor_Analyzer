function [ a3, a2, a1, a0 ] = calc_cubicCoefficientsForInterp_( ts, te, F1, F2, D1, D2 )

%delta = te - ts;
%D1 = df1dt(ts)
%D2 = df2dt(te)
%F1 = f1(ts)
%F2 = f2(te)
%CP = ts*te;

%a0 = -( delta*CP*(ts*D2 + te*D1) - (2*te + delta)*ts^2*F2 - (delta - 2*ts)*te^2*F1 ) / delta^3;
%a1 = ((2*te + ts)*delta*ts*D2 + (te + 2*ts)*delta*te*D1 - 6*CP*(F2 - F1)) / delta^3;
%a2 = -((te + 2*ts)*delta*D2 + (2*te + ts)*delta*D1 - 3*(te + ts)*F2 + 3*(te + ts)*F1 ) / delta^3;
%a3 = (delta*(D2 + D1) - 2*(F2 - F1)) / delta^3;

a0 = F2;
a1 = D2;
a2 = -((F1 + 2*D2)*ts + 3*F2)/ts^2;
a3 = ((D1 + D2)*ts + 2*F2)/ts^3;

return;
