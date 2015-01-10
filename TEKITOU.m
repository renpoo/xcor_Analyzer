pkg load io;
pkg load signal;

close all; 
clear;

#[ s0, fs, bits ] = wavread('Sounds/Akan00.wav');
[ s0, fs, bits ] = wavread('Sounds/140823TiturelAmfortas.WAV');

sound( s0, fs );

length_of_s0=length(s0);
duration = length_of_s0 / fs;  %duration (of input signal)

window_size=256;
shift_size=16;
dft_size=256;

Len = 16;
    
avg = 0.0;
    
number_of_frame=floor((length_of_s0-(window_size-shift_size))/shift_size)-1;

for frame=1:number_of_frame,
   offset=shift_size*(frame-1);
   for n=1:window_size,
     nMod = mod(n,Len);
     if (0<nMod && nMod<=Len),
        avg = avg + s0(offset+n);
     endif;
   end;
   avgResult(frame) = avg/Len;
   avg = 0.0;
   for n=1:window_size,
      x(n+offset) = avgResult(frame);
   end;
end;


sound(x, fs);


shift_size = 256;
number_of_frame=floor((length_of_s0-(window_size-shift_size))/shift_size)-1;

result = zeros(1,dft_size);
tmp = zeros(1,dft_size);

for frame=1:number_of_frame,
   offset=shift_size*(frame-1);


   X=fft(x(offset+1:offset+window_size),dft_size);

   
   for k=1:dft_size/2+1,
     A(k)=-20*log10(abs(X(k)));
   end

  [s, i] = sort(A,'descend');


  Amodified = zeros(1,dft_size/2+1);
  Xmodified = zeros(1,dft_size);


  for k=1:dft_size/2+1,
     for j=1:16,
       if (k == i(j)),
         Amodified(k) = A(k);
         Xmodified(k) = X(k);
         Xmodified(dft_size - k) = X(k);
       end;
     end;
  end;


  #for k=1:dft_size,
  #  Xmodified(k) = 1/10^(Xmodified(k)/20);
  #end;

if(0),  
  clf ();
  figure(1);
  plot(real(Xmodified));  
  pname = strcat( "Output\ Images", '/', 'test' );
  mkdir( pname );
  saveImageName = "abc";
  fname = strcat( saveImageName, '.jpg');
  outputDataFileName = strcat( pname, '/', fname );
  saveas( 1, strcat( outputDataFileName ) );
end;

  tmp = horzcat(tmp, Xmodified );

  result = horzcat(result, real(ifft(Xmodified,dft_size)) );

end;






#for k=1:length(result),
#  result(k) = (1/10^(result(k)/20)-1)*2500;
#end;




#sound(result,fs);




shift_size = 32;
window_size = 32;
number_of_frame=floor((length(result)-(window_size-shift_size))/shift_size)-1;
for frame=1:number_of_frame-1,
   offset=shift_size*(frame-1);
   for n=1:window_size,
     nMod = mod(n,Len);
     if (0<nMod && nMod<=Len),
        avg = avg + result(offset+n);
     endif;
   end;
   avgResult(frame) = avg/Len;
   avg = 0.0;
   for n=1:window_size,
      result2(n+offset) = avgResult(frame);
   end;
end;


for k=1:length(result2),
  result2(k) = (1/10^(result2(k)/20)-1)*2500*4;
end;

sound(result2, fs);


#sound(real(ifft(tmp, dft_size)),fs);


#x_real = real( ifft(X_real, dft_size/2+1) );




