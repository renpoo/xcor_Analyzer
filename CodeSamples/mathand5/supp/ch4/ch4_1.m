% �X�e�b�v�����̃V�~�����[�V����
tffunc=tf(1,[2,1]);%���萔�Q�̃��[�p�X�t�B���^
t=0:0.01:10; %10�b�Ԃ̃V�~�����[�V����
y=lsim(tffunc,ones(size(t)),t);
subplot(2,1,1);plot(t,y,[2,2],[0,1]);xlabel('Time[sec]');
subplot(2,1,2);plot(t,step(tffunc,t),[2,2],[0,1]);xlabel('Time[sec]');

%2�b�̂Ƃ��A63%�̗����オ��ɂȂ�͂��Bstep�֐��ɂ�鉞�����Alsim�֐��ɂ�鉞���������B