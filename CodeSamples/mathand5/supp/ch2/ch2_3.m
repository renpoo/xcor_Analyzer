X=[0,1,1,0,0];
Y=[0,0,1,1,0];
Z=zeros(1,5);
X=[X,X];
Y=[Y,Y];
Z=[Z,ones(1,5)];
XX1=[1,1,0;1,1,0];
YY1=[0,1,1;0,1,1];
ZZ1=[1,1,1;0,0,0];
plot3(X,Y,Z,XX1,YY1,ZZ1,'b','linewidth',5);
axis equal
%�ʉ��@Nan���g����3�̍s��ɂ܂Ƃ߂邱�Ƃ��ł���D
X=[0,1,1,0,0];
Y=[0,0,1,1,0];
Z=zeros(1,5);
X=[X,X];
Y=[Y,Y];
Z=[Z,ones(1,5)];
X=[X,nan,1,1,nan,1,1,nan,0,0];
Y=[Y,nan,0,0,nan,1,1,nan,1,1];
Z=[Z,nan,1,0,nan,1,0,nan,1,0];
plot3(X,Y,Z,'linewidth',5);
axis equal


