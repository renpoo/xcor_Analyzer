pkg load io;
pkg load signal;

close all; 
clear;

[ s0, fs, bits ] = wavread('Sounds/Akan00.wav');

sound( s0, fs );

length_of_s0=length(s0);
duration = length_of_s0 / fs;  %duration (of input signal)

window_size=256;
shift_size=4;
dft_size=256;

Len = 4;
    
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
     for j=1:8,
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
  
  clf ();
  figure(1);
  plot(real(Xmodified));  
  pname = strcat( "Output\ Images", '/', 'test' );
  mkdir( pname );
  saveImageName = "abc";
  fname = strcat( saveImageName, '.jpg');
  outputDataFileName = strcat( pname, '/', fname );
  saveas( 1, strcat( outputDataFileName ) );

  tmp = horzcat(tmp, Xmodified );

  result = horzcat(result, real(ifft(Xmodified,dft_size)) );

end;


for k=1:length(result),
  result(k) = (1/10^(result(k)/20)-1)*2500;
end;

sound(result,fs);

#sound(real(ifft(tmp, dft_size)),fs);


#x_real = real( ifft(X_real, dft_size/2+1) );

 