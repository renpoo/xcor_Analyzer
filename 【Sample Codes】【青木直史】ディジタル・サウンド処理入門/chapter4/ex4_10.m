clear;
fs=8000;
lpc_order=10;
fid=fopen('ai[lpc].txt','rt');
lpc0=fscanf(fid,'%f');
fclose(fid);
length_of_lpc0=length(lpc0);
number_of_frame=length_of_lpc0/(lpc_order+1);
length_of_lsp0=lpc_order*number_of_frame;
lsp0=zeros(1,length_of_lsp0);
lpc=zeros(1,lpc_order+1);
for frame=1:number_of_frame,
   offset=(lpc_order+1)*(frame-1);
   for m=1:lpc_order+1,
      lpc(m)=lpc0(offset+m);
   end
   lsp=LpcToLsp_(lpc,lpc_order,fs);
   offset=lpc_order*(frame-1);
   for m=1:lpc_order,
      lsp0(offset+m)=lsp(m);
   end
end
fid=fopen('ai[lsp].txt','wt');
fprintf(fid,'%f\n',lsp0);
fclose(fid);
