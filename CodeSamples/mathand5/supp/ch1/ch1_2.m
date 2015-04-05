nedan=input('商品の値段（税込）を入れてください．->');
zeinuki=round(nedan/1.12);
zeikin=nedan-zeinuki;
disp(['商品の値段は，',num2str(round(nedan/1.12)),'円です．']);
disp(['消費税は，',num2str(zeikin),'円です．']);

