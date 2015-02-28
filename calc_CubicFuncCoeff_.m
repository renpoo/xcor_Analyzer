function [ a3, a2, a1, a0 ] = calc_CubicFuncCoeff_( ts, te, F1ts, F2te, D1ts, D2te )

% Target Formula: g(t) = a3*t^3 + a2*t^2 + a1*t + a0;
 

% Cross Product 
CP = ts * te;

% Delta
Delta = te - ts;


a3 = ( Delta * ( D1ts + D2te ) - 2 * ( F2te - F1ts ) ) / Delta^3;
a3n = (te*D2te - ts*D2te + te*D1ts - ts*D1ts - 2*F2te + 2*F1ts) / Delta^3;

disp (a3);
disp (a3n);


a2 = - ( ( te + 2 * ts ) * Delta * D2te - ( 2 * te + ts ) * Delta * D1ts - 3 * ( te + ts ) * ( F2te - F1ts ) ) / Delta^3;
a2n = -(te^2*D2te + te*ts*D2te - 2*ts^2*D2te + 2*te^2*D1ts - te*ts*D1ts - ts^2*D1ts - 3*te*F2te - 3*ts*F2te + 3*te*F1ts + 3*ts*F1ts)/Delta^3;

disp (a2);
disp (a2n);

a2 = a2n;

a1 = ( ( 2 * te + ts ) * Delta * ts * D2te + ( te + 2 * ts ) * Delta * te * D1ts - 6 * CP * ( F2te - F1ts ) ) / Delta^3;
a1n = (2*te^2*ts*D2te - te*ts^2*D2te - ts^3*D2te + te^3*D1ts + te^2*ts*D1ts - te*ts^2*2*D1ts - 6*te*ts*F2te + 6*te*ts*F1ts)/Delta^3;

disp (a1);
disp (a1n);

a0 = - ( Delta * CP * ( ts * D2te + te * D1ts ) - ( 3 * te - Delta ) * ts^2 * F2te - ( Delta + 3 *ts ) * te^2 * F1ts ) / Delta^3;
a0n = -(te^2*ts^2*D2te - te*ts^3*D2te + te^3*ts*D1ts - te^2*ts^2*D1ts - 3*te*ts^2*F2te + ts^3*F2te - te^3*F1ts + 3*te^2*ts*F1ts)/Delta^3;



disp (a0);
disp (a0n);

a0 = a0n;

