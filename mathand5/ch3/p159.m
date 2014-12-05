t=(1:length(data))/dt-dt;% まず時間軸を作成する。
f=t/dt/dt/length(data);% 周波数軸を作成する。
f=f(1:end/2+1); % 計算した周波数軸前半半分のみを取り出す
fftdat=fft(data)/(length(data)/2);% fft関数による計算
fftdat=fftdat(1:end/2+1); % fftdatの前半半分のみを取り出す。
fftdat(1)=fftdat(1)/2;
% 直流成分の相当する箇所のみを1/2倍し振幅を揃える。
% 厳密には、y軸を揃えるため必要であるが、
% 直流分は、カットしてからfft処理する場合がほとんどである点と、
% 対数表示する場合は使わないなどの理由により、
% 実用上は入れなくてよい。
subplot(2,1,1);plot(f,abs(fftdat));axis tight; %振幅を表示
xlabel('Frequency [Hz]');ylabel('Amplitude');
subplot(2,1,2);plot(f,anble(fftdat)*180/pi);axis tight;
% 位相を表示。単位は、度
xlabel('Frequency [Hz]');ylabel('Angle [degree]');
