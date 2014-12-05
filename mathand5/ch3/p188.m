index=1;maxpower=power(index);
for i=2:length(power)
  if maxpower < power(i)
    index=i;maxpower=power(index);
  end
end
