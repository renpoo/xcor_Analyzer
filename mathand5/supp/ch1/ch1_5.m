num=input('�w���ؔԍ����ꌅ�����Ă��������D->');
gakusei=1+num;
data=sin((1:1024)*2*pi/1024*gakusei);
[val,ind]=max(data);
fprintf('�ŏ��̃s�[�N�l�́C%g��%d�Ԗڂł��D\n',val,ind);
plot(data);hold on;plot(ind,val,'rp');hold off

