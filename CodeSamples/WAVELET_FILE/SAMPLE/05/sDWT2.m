% �T���v���M��
% �����g�Ƀ����_���m�C�Y���d�˂܂��B1000�|�C���g�̃f�[�^�ł��B
y=sin(20.*linspace(0,pi,1000))+0.2*rand(1,1000);	%%  �G�����܂񂾐M���̍쐬
figure(1);
plot(y)
title(" Original Signal");
%%------------------------------------------
p = [0.707106781 0.707106781];
sup=length(p); % ����̒���
 q = - ( (-1).^(1:sup) ).*p(sup:-1:1); % 
%%
[ca1,cd1]  = dwt(y, p, q);				%% ���U�E�F�[�u���b�g�ϊ��@1���
figure(2);
subplot(2,1,2)
plot(cd1);
subplot(2,1,1)
plot(ca1);
title('After dwt .cA and cD, 1st stage, 1st stage');

[ca2,cd2]  = dwt(ca1, p, q);			%% ���U�E�F�[�u���b�g�ϊ��@2���
figure(3);
grid on;
subplot(2,1,2)
plot(cd2);
subplot(2,1,1)
plot(ca2);					%% �ߎ��W���̕\��
title('After dwt .cA and cD 2nd stage');
