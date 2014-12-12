//　2次元ウェーブレット変換
clf;
x=rand(200,200);			// 乱数
[C,S]=wavedec2(x,3,'db2');		// レベル3でウェーブレット変換
//
coff=appcoef2(C,S,'db2',3);		// レベル3の近似係数
surf(coff);				//  surf で3D表示を行います。
xgrid(1);
title('ランダムノイズの変換');
