function gain=GainEstimation_(e)
length_of_e=length(e);
gain=0;
for n=1:length_of_e,
   if gain<abs(e(n))
      gain=abs(e(n));
   end
end
