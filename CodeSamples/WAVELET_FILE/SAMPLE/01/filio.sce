// �ȒP�ȃt�@�C�� I/O ����
mode(7)                // �X�e�b�v����Ŏ��s���܂��B
filen = 'test.bin';    // �t�@�C�������w�肷��B
mopen(filen,'wb');     // �o�C�i��-�ŏ������ރt�@�C�����I�[�v�����܂��B
mput(1996,'l');mput(1996,'i');mput(1996,'s');mput(98,'c');

//  little-endian �Ńf�[�^��������
mput(1996,'ll');mput(1996,'il');mput(1996,'sl');mput(98,'cl');

// big-endian �Ńf�[�^��������
mput(1996,'lb');mput(1996,'ib');mput(1996,'sb');mput(98,'cb');

mclose();    // �t�@�C���N���[�Y
// �t�@�C���ւ̏������ݏI���B
// �ǂݏo���̊J�n
mopen(filen,'rb');
if 1996<>mget(1,'l') then pause,end
if 1996<>mget(1,'i') then pause,end
if 1996<>mget(1,'s') then pause,end
if   98<>mget(1,'c') then pause,end

// ���g���G���f�B�A��������
if 1996<>mget(1,'ll') then pause,end
if 1996<>mget(1,'il') then pause,end
if 1996<>mget(1,'sl') then pause,end
if   98<>mget(1,'cl') then pause,end

// �r�b�O�G���f�B�A��������
if 1996<>mget(1,'lb') then pause,end
if 1996<>mget(1,'ib') then pause,end
if 1996<>mget(1,'sb') then pause,end
if   98<>mget(1,'cb') then pause,end

mclose();
