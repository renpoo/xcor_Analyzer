// �Q�̐M���̃X�y�N�g�����̕\��
// ���̗�ł͌������Ă��錳�̐M����65536�T���v���\�����A���̂��Ƃ�dwt�ϊ����s���܂��B
// ���ʂ͑S�̂̐擪������1024�|�C���g��\�����Ă��܂��B
clf;
stacksize('max');
y=loadwave("ourin1.wav");    // wav�`���̃f�[�^�����[�h����B
figure(1);
//
plot(y(1:8192*8))    // ���̐M��65536�T���v���\��
xgrid(1);
title(" Original Signal");
figure(2);
// dwt �ϊ� ------------------------------------------
[cA,cD]=dwt(y(1:8192*8),'haar');
xsetech([0,0.5,1,0.45]); 
plot(cA);				//�@65536�T���v���ɔ͈͂𐧌����g�`�����₷������B
title('�ߎ��W��');
xgrid(1);
xsetech([0,0,1,0.45]);
plot(cD);
title('�ڍ׌W��');
xgrid(1);
//
figure(3);
xsetech([0,0.5,1,0.45]); 
plot(cA(1:1024));			//�@����ɔ͈͂��������g�`�����₷������B
title('�ߎ��W���i�g��j');
xgrid(1);
xsetech([0,0,1,0.45]);
plot(cD(1:1024));
title('�ڍ׌W��(�g��)');
xgrid(1);
