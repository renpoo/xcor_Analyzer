clear all;close all
n=1024;dt=0.01;t=(1:n)*dt-dt;f=t/dt/dt/n;
omega=2*pi*13; % 15Hz
data=sin(omega*t)+randn(size(t))*0.1;
figure(1)
subplot(2,2,1);plot(t,data);axis tight;
xlim([0 1]);
% check FFT offline simulation
fftdata=fft(data)/round(n/2);
len2=round(n/2+1);
f=t/dt/dt/length(t);
[val,ind]=max(abs(fftdata(1:len2)));
subplot(2,2,2);plot(f(1:len2),abs(fftdata(1:len2)),f(ind),val,'p');
title(['fft method ',num2str(f(ind)),'[Hz]']);
% AR model
% Adata=[x[1 2 3 4 5 6 7 8];
%            1 2 3 4 5 6 7 8
%              1 2 3 4 5 6 7 8
%x(k)=-a1*x(k-1)-a2*x(k-2)-a3*x(k-3);
%x(k)=[x(k-1) x(k-2) x(k-3)]*[-a1;-a2;-a3];
%x(k+4)=[x(k+3) x(k+2) x(k+1)]*[-a1;-a2;-a3];
%Y=AX
A=[data(3:end-1);data(2:end-2);data(1:end-3)]';
B=[data(4:end)'];
%a=inv(A'*A)*A'*B
a=A\B
roots([1,-a'])*dt*2*pi
result= log(roots([1,-a']))/dt
fprintf('Frequency [Hz]\n');
omega=abs(result)/pi/2
fprintf('\theta\n');
real(result)./omega
%Signal Processing Toolbox‚ª‚ ‚éê‡
dend=arcov(data(:),3);
ff=(0:0.01:50);
if 0 % Control System Toolbox‚ª‚ ‚éê‡
  [num,den]=d2cm(1,dend,dt);
  [mag,ph]=bode(tf(num,den),ff*2*pi);
else % Control System Toolbox‚ª‚È‚¢ê‡
  fdata=1./sum(repmat([1;-a],1,length(ff)).*exp(-dt*(0:length(a))'*ff*2*pi*sqrt(-1)));
  mag=abs(fdata);ph=angle(fdata)*180/pi;
end
[val,ind]=max(mag(:));
subplot(2,1,2);plot(ff,mag(:)'.',ff(ind),val,'p');
title(['ar method ',num2str(ff(ind)),'[Hz]']);
