function [b,filter_size]=FirLpf_(fs,fe,delta)
fc=(fe+delta/2)/fs;
delta=delta/fs;
filter_size=floor(3.1/delta);
if mod(filter_size,2)==0
   filter_size=filter_size+1;
end
w=HanningWindow_(filter_size);
offset=(filter_size-1)/2+1;
for k=-(filter_size-1)/2:(filter_size-1)/2,
   if k==0
      b(offset+k)=2*fc;
   else
      b(offset+k)=2*fc*sin(2*pi*fc*k)/(2*pi*fc*k);
   end
end
for k=1:filter_size,
   b(k)=b(k)*w(k);
end
