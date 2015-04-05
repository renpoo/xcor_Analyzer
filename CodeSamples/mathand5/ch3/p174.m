n=1024;dt=0.01;
t=(1:n)*dt-dt;
omega = 2*pi*1; % 1[Hz]
y=sin(omega*t);
maxf=1/(2*dt);
F1=10;% [Hz] for lowpass
F2=0.5;%[Hz] for highpass
if((F1>maxf)|(F2>maxf))
	disp([' ナイキスト周波数を超えています．']);
	disp(['F1,F2 を',num2str(maxf),'[Hz] 以下にして下さい．']);
end
if(F1<F2) disp('F1(Lowpass)< F2(Highpass) です．全ての周波数をカットすることになります．');end
ffty=fft(y);
index1= round(F1*dt*n+1);
index2= n+2-index1;
Lowpass=ones(size(ffty));
Lowpass(index1+1:index2-1)=zeros(size((index1+1):(index2-1)));
index1= round(F2*dt*n+1);
index2= n+2-index1;
Highpass=zeros(size(ffty));
Highpass(index1:index2)=ones(size(index1:index2));
yout = real(ifft(Lowpass.* Highpass.*ffty));
subplot(2,1,1);plot(t,y,t,yout);legend('original','filtered');
axis tight
subplot(2,1,2);plot([[Lowpass(:),Highpass(:)]*max(abs(ffty(:))),abs(ffty(:))]);
axis tight;legend('Lowpass','Highpass','original')
