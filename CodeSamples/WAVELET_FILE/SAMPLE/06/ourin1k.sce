// 鉦のスペクトラムの表示
// サンプル１
clf;
stacksize('max');
y=loadwave("ourin1.wav");	// wav形式のデータをロードする。
//------------------------------------------
// cwt 変換 ------------------------------------------
scale=[1:32]
coef=cwt(y(1:8192*0.5),scale,'gaus5');	//  cwt変換
surf(coef);				//  surf   3D表示を行います。
xgrid(1);
xtitle('cwt変換の3D表現');
xlabel('空間/時間');
ylabel('スケール');
figure(1);
cwtplot(coef,scale);	// cwtのプロット
xtitle('cwt変換の係数');
