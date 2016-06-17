function LM = LogisticMap( alpha, n )

LM(1) = 0.1;

for i = 2 : n,
    LM(i) = alpha * LM(i-1) * (1 - LM(i-1));
end;
