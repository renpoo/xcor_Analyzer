t=(1:length(data))/dt-dt;% �܂����Ԏ����쐬����B
f=t/dt/dt/length(data);% ���g�������쐬����B
f=f(1:end/2+1); % �v�Z�������g�����O�������݂̂����o��
fftdat=fft(data)/(length(data)/2);% fft�֐��ɂ��v�Z
fftdat=fftdat(1:end/2+1); % fftdat�̑O�������݂̂����o���B
fftdat(1)=fftdat(1)/2;
% ���������̑�������ӏ��݂̂�1/2�{���U���𑵂���B
% �����ɂ́Ay���𑵂��邽�ߕK�v�ł��邪�A
% �������́A�J�b�g���Ă���fft��������ꍇ���قƂ�ǂł���_�ƁA
% �ΐ��\������ꍇ�͎g��Ȃ��Ȃǂ̗��R�ɂ��A
% ���p��͓���Ȃ��Ă悢�B
subplot(2,1,1);plot(f,abs(fftdat));axis tight; %�U����\��
xlabel('Frequency [Hz]');ylabel('Amplitude');
subplot(2,1,2);plot(f,anble(fftdat)*180/pi);axis tight;
% �ʑ���\���B�P�ʂ́A�x
xlabel('Frequency [Hz]');ylabel('Angle [degree]');
