% �X�e�b�v�����̃V�~�����[�V����
[numd,dend]=c2dm(1,[2,1],0.01);%���萔�Q�̃��[�p�X�t�B���^���T���v������0.01�b��c2dm�֐����g�����U�l��
tffunc=tf(1,[2,1]);%���萔�Q�̃��[�p�X�t�B���^
t=0:0.01:10; %10�b�Ԃ̃V�~�����[�V����
yd=filter(numd,dend,ones(size(t)));
yc=lsim(tffunc,ones(size(t)),t);
subplot(2,1,1);plot(t,yd,t,yc,[2,2],[0,1]);
xlabel('Time[sec]');legend('Discrete','Continuous');
subplot(2,1,2);plot(t,yd(:)-yc(:));
ylabel('Error');xlabel('Time[sec]');

%�A���n�Ɨ��U�n�ł̃V�~�����[�V�����A�����قƂ�ǂȂ����߁A�덷��\�����Ă���B10�́|15����x�ł��邽�ߎ��p��͖��Ȃ����Ƃ��m�F�ł���B
