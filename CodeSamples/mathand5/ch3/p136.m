fp=fopen('test.m','rt');
S=fread(fp,'char');
fclose(fp);
S=char(S')
