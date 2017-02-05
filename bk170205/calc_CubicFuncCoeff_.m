function [ a3, a2, a1, a0 ] = calc_CubicFuncCoeff_( ts, te, F1ts, F2te, D1ts, D2te )

% Target Formula: g(t) = a3*t^3 + a2*t^2 + a1*t + a0;

a3 = (te*D2te - ts*D2te + te*D1ts - ts*D1ts - 2*F2te + 2*F1ts) / (te - ts)^3;
a2 = -(te^2*D2te + te*ts*D2te - 2*ts^2*D2te + 2*te^2*D1ts - te*ts*D1ts - ts^2*D1ts - 3*te*F2te - 3*ts*F2te + 3*te*F1ts + 3*ts*F1ts)/(te - ts)^3;
a1 = (2*te^2*ts*D2te - te*ts^2*D2te - ts^3*D2te + te^3*D1ts + te^2*ts*D1ts - te*ts^2*2*D1ts - 6*te*ts*F2te + 6*te*ts*F1ts)/(te - ts)^3;
a0 = -(te^2*ts^2*D2te - te*ts^3*D2te + te^3*ts*D1ts - te^2*ts^2*D1ts - 3*te*ts^2*F2te + ts^3*F2te - te^3*F1ts + 3*te^2*ts*F1ts)/(te - ts)^3;
