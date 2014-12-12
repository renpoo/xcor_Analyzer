// 
clf;
// 擬似信号の作成
a=sin(20.*linspace(0,%pi,1000))+0.2*rand(1,1000);    //  信号
//a = sin(2*%pi*s/100)+sin(3*%pi*s/100); 	// 基本の正弦波を作成
// ウエーブレット変換を行います。
[ca1,cd1] = dwt(a,'haar');   	             // ウエブレット関数名db2を使用
//xsetech([0,0.5,1,0.45]) 　⇒　SCILAB的な記述
subplot(2,1,2)
plot(cd1);
xgrid(1);	
xlabel('サンプルポイント');		// 目盛り	
title('詳細係数');
subplot(211);            // MATLAB的な記述
//xsetech([0,0,1,0.45]);
plot(ca1);
xgrid(1);
xlabel('サンプルポイント');
xtitle('近似係数');

