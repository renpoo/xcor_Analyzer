// 簡単なファイル I/O 操作
mode(7)                // ステップ動作で実行します。
filen = 'test.bin';    // ファイル名を指定する。
mopen(filen,'wb');     // バイナリ-で書き込むファイルをオープンします。
mput(1996,'l');mput(1996,'i');mput(1996,'s');mput(98,'c');

//  little-endian でデータ書き込み
mput(1996,'ll');mput(1996,'il');mput(1996,'sl');mput(98,'cl');

// big-endian でデータ書き込み
mput(1996,'lb');mput(1996,'ib');mput(1996,'sb');mput(98,'cb');

mclose();    // ファイルクローズ
// ファイルへの書き込み終了。
// 読み出しの開始
mopen(filen,'rb');
if 1996<>mget(1,'l') then pause,end
if 1996<>mget(1,'i') then pause,end
if 1996<>mget(1,'s') then pause,end
if   98<>mget(1,'c') then pause,end

// リトルエンディアンを強制
if 1996<>mget(1,'ll') then pause,end
if 1996<>mget(1,'il') then pause,end
if 1996<>mget(1,'sl') then pause,end
if   98<>mget(1,'cl') then pause,end

// ビッグエンディアンを強制
if 1996<>mget(1,'lb') then pause,end
if 1996<>mget(1,'ib') then pause,end
if 1996<>mget(1,'sb') then pause,end
if   98<>mget(1,'cb') then pause,end

mclose();
