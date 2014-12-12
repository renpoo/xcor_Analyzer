//------------------------------------------
// cwt 変換 ------------------------------------------
scale=[1:512];				// スケール
coef=cwt(y(1:512),scale,'gaus5');	//  cwt変換
surf(coef);				//  surf   3D表示を行います。
xgrid(1);
xtitle('cwt変換の3D表現');
xlabel('空間/時間');
ylabel('スケール');
figure(2);
//
cwtplot(coef,scale);			// ウェーブレット係数のプロット
xtitle('cwt変換の係数');
