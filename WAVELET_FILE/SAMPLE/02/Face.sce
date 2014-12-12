stacksize('max');		// スタックを可能な限り大きく確保します。
filename =  'people.jpg';	// 表示する画像ファイルの名称をパスとともに指定します。
// Windowsの場合はサブディレクトリをバックスラッシュがセパレータになるためにOSの識別を行います。
if getos() == 'Windows' then 
  filename=strsubst(filename,'/','\');
end
// 指定された画像ファイルを、ファイルハンドル im に受け取ります。
im = imread(filename);
face = detectfaces(im);		// 画像データから顔を認識しfaceに格納します。
[m,n] = size(face);		// 顔の数を確認し、データに枠をつけます。
for i=1:m,
    im = rectangle(im, face(i,:), [0,255,0]); // 枠を表示します。もちろんfaceに対して実施します。
end;
// 枠がつけられた状態で画像を表示します。
imshow(im);
