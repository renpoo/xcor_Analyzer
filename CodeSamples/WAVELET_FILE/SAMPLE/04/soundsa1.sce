// At first we create 2.5 seconds of sound parameters.
t=soundsec(2.5);
// Then we generate the sound.
s=sin(440*t)+sin(220*t)/2+sin(880*t)/2;	// 3�̐����g������
[nr,nc]=size(t);
s(nc/2:nc)=sin(330*t(nc/2:nc));
analyze(s);
xgrid();
xtitle('���g���X�y�N�g��');
