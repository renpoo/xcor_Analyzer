// ファイル化された音声データの解析 
clf;
y=loadwave("kane1.wav");
playsnd(y);    // 音の再生
//
analyze(y,10,300);
xgrid(1);
xlabel('周波数');
title('信号解析結果');
