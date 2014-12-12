% �T���v���M���̃X�y�N�g�����\���Ɨ��U�E�F�[�u���b�g�ϊ��̌���
t=0:0.001:0.512;				%  �T���v�����O�Ԋu�@0.001
y=sin(2*pi*50*t)+0.5*sin(2*pi*400*t);	%  50Hz�̐M����400Hz�̐M���i�����g�j
grid on
figure(1);
subplot(2,1,1)
plot(y(1:512))
axis([0, 512, -1.5,  1.5]);
title(" Original Signal");

%% FFT�\��
Y=fft(y,512);			%% 512�t�[���G�ϊ��ɂ����g���̈�ɕϊ�
Pyy=Y.*conj(Y)/512;		%% �X�y�N�g�����x
f=1000*(0:511)/512;

subplot(2,1,2)
plot(f,Pyy(1:512))
title(" spectrum   f1=50Hz, noise=400Hz")
xlabel("(Hz)")
%%#------------------------------------------
%% �E�F�[�u���b�g�֐��̒l�@Octave�ł͐����Ŏw�肷��K�v������܂��B
p = [0.482962913145 0.836516303738 0.224143868042 -0.129409522551];
sup=length(p);		% ����̒���
q = - ( (-1).^(1:sup) ).*p(sup:-1:1);
%
g = p;
h = q;
ss=y(1:512);			% ���̐M���̔z��
[ca1,cd1]  = dwt(ss, g, h);		%% ���U�E�F�[�u���b�g�ϊ�
figure(2);
subplot(2,1,2)
plot(cd1);			%% �ߎ��W���̕\��
subplot(2,1,1)
plot(ca1);			%% �ڍ׌W���̕\��
title('After dwt .cA and cD');
