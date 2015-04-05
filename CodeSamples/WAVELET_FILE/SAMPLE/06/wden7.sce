// wden による雑音除去
clc;
mode(-1);
lines(0);
stacksize('max');	// スタックを確保
//
level=input('スレッシュホールドレベル？：');	// スレッシュホールドレベルの数を入力する。
clf;
filename=input('使用するファイル名は？：','s');
if getos() == 'Windows' then 
  filename=strsubst(filename,'/','\');
end
//
signal=loadwave(filename);
x=signal(1:100000);
disp('データサイズ=',length(signal));
//
xd = wden(x,'heursure','s','one',level,'sym8');
// 信号のプロット 
subplot(211), plot(x); 
a=gca();a.data_bounds=[1 2048 -1.0 1.0];
title('元の信号'); 
subplot(212), plot(xd), a=gca();a.data_bounds=[1 2048 -1.0 1.0];
TITLES={'スレッシュホールドレベル',..
string(fix(level))};
title(TITLES);
// 雑音削除後の音の再生
sound(xd)
