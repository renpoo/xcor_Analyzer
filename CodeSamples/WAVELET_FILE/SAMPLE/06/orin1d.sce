// ２つの信号のスペクトラムの表示
// この例では減衰している元の信号を65536サンプル表示し、そのあとにdwt変換を行います。
// 結果は全体の先頭部分の1024ポイントを表示しています。
clf;
stacksize('max');
y=loadwave("ourin1.wav");    // wav形式のデータをロードする。
figure(1);
//
plot(y(1:8192*8))    // 元の信号65536サンプル表示
xgrid(1);
title(" Original Signal");
figure(2);
// dwt 変換 ------------------------------------------
[cA,cD]=dwt(y(1:8192*8),'haar');
xsetech([0,0.5,1,0.45]); 
plot(cA);				//　65536サンプルに範囲を制限し波形を見やすくする。
title('近似係数');
xgrid(1);
xsetech([0,0,1,0.45]);
plot(cD);
title('詳細係数');
xgrid(1);
//
figure(3);
xsetech([0,0.5,1,0.45]); 
plot(cA(1:1024));			//　さらに範囲を狭くし波形を見やすくする。
title('近似係数（拡大）');
xgrid(1);
xsetech([0,0,1,0.45]);
plot(cD(1:1024));
title('詳細係数(拡大)');
xgrid(1);
