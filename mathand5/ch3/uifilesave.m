%�f�[�^�̕ۑ�data_in, data_time�ϐ���ۑ�����X�N���v�g
data_in=rand(1,100);
data_time=rand(1,100);
filename=uiputfile('*.mat');
save(filename,'data_in','data_time')
