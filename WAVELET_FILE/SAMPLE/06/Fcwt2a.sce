//　cwt変換による分析プログラム
clc;            // コンソールをクリアーする。
clf;            // 画像クリアー
stacksize('max');    // スタックを確保
// ファイル名をコンソールから入力。ファイルは wave 形式のみ。
filename=input('使用するファイル名は？：','s');
//　この部分はSCILABに限定される記述です。
if getos() == 'Windows' then 
  filename=strsubst(filename,'/','\');
end
//
signal=loadwave(filename);			// wav形式のデータをロードする。
disp('データサイズ=',length(signal));		// ファイルの大きさを表示
//
waven=input('使用するウェーブレットは？：','s');
//
numb=input('スケール？：');			// 分解レベルの数を入力する。
start=input('最初のサンプルポイント？：');	// 最初のサンプルポイント。
last=input('最後のサンプルポイント？：');	// 最後のサンプルポイント。
bitt=input('間引き数？：');			// 最後のサンプルポイント。
//
scale=1:numb;
// 連続ウェーブレット変換
coef=cwt(signal(start:bitt:last),scale,waven);		// cwt変換
surf(coef);						// 3D表示
xgrid(1);
title('ウエブレット係数 ');
//
cwtplot(coef,scale);	// 係数の表示
//
title('cwt変換　使用したウェーブレットは '+waven);
//
