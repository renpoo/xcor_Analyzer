// 鉦の音の解析
// サンプル１
clf;
stacksize('max');
[y,Fs]=loadwave("ourin2.wav");		// wav形式のデータをロードする。
// Fsにはファイルからデータの情報があります。3番目がサンプルレートです。
size_w=length(y);			// データの生の大きさ
FS=Fs(3);				// 音声録音時のサンプリング周波数
//
xset('window',0);
plot(y(1:size_w))			// 元の信号
xgrid(1);
title(" 鉦の音 ");
xset('window',1);
//-------------------------------------
// dwt 変換 ------------------------------------------
[cA,cD]=dwt(y(1:size_w),'haar');	// 離散ウェーブレット変換
xsetech([0,0.5,1,0.45]); 
plot(cA);				//　範囲を制限し波形を見やすくする。
title('近似係数');
xgrid(1);
xsetech([0,0,1,0.45]);
plot(cD);
title('詳細係数');
xgrid(1);
//
xset('window',2);
//------------------------------------------
// cwt 変換 ------------------------------------------
scale=[1:128];        // スケール
// cwt 変換を行うときのサンプリングされたデータの間引きをおこなう。
MULT=8192;	// 間引きを行う
coef=cwt(y(1:MULT:size_w),scale,'gaus5');	//  cwt変換
surf(coef);					//  surf   3D表示を行います。
xgrid(1);
xtitle('cwt変換の3D表現');
xlabel('時間');
ylabel('スケール');
xset('window',3);
//
cwtplot(coef,scale);				//係数のプロット
xtitle('cwt変換の係数');
