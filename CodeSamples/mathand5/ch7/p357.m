Fs = 11025;
r = audiorecorder(Fs, 16, 1);
recordblocking (r,3); % �}�C�N�Ɍ������Ęb��..
y = getaudiodata(r, 'int16'); % �f�[�^�� int16 �z��Ƃ��Ď擾
p=audioplayer(y,Fs)
play(p);
