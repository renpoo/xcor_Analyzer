// 
clf;
// 擬似信号の作成
a=sin(20.*linspace(0,%pi,1000))+0.2*rand(1,1000);    //  信号
// cwt 変換 を行います。------------------------------------------
scale=[1:32]                        // スケール
coef=cwt(a,scale,'haar');    	 //  cwt変換
surf(coef);    				    //  surf   3D表示を行います。
xgrid(1);
xtitle('cwt変換の3D表現');
xlabel('サンプルポイント');
ylabel('スケール');
// ウエーブレット係数の表示
cwtplot(coef,scale);    			// cwtのプロット
xlabel('サンプルポイント')
xtitle('cwt変換の係数');
