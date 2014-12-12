mode(7) // 休止モード、エンターキーで１行ずつ実行します。
stacksize('max');
//    まずこのプログラムが存在するパスを獲得しています。
// そのあとで画像データファイルのハンドルを用意します。
im=imread('/usr/share/scilab/contrib/sivp/images/people.jpg');
//    画像の表示を行います。
imshow(im);
