pkg load io;
pkg load signal;

close all; 
clear;

[ s0, fs, bits ] = wavread('Sounds/Akan00.wav');
#[ s0, fs, bits ] = wavread('Sounds/140823TiturelAmfortas.WAV');

sound( s0, fs );

length_of_s0=length(s0);
duration = length_of_s0 / fs;  %duration (of input signal)

window_size=256;
shift_size=2;
dft_size=256;

Len = shift_size;
    
avg = 0.0;
    
number_of_frame=floor((length_of_s0-(window_size-shift_size))/shift_size)-1;

for frame=1:number_of_frame,
   offset=shift_size*(frame-1);
   for n=1:Len:window_size,
     subS0 = s0(offset+n:offset+n+Len-1);
     avg = mean(subS0);
     x(offset+n:offset+n+Len-1) = avg;
     avg = 0.0;
   end;
end;


sound(x, fs);


#return;

TopRanks = 4;
shift_size = 256;
number_of_frame=floor((length_of_s0-(window_size-shift_size))/shift_size)-1;

result_x = zeros(1,dft_size);
tmp = zeros(1,dft_size);

for frame=1:number_of_frame,
   offset=shift_size*(frame-1);


   X=fft(x(offset+1:offset+window_size),dft_size);

   
   for k=1:dft_size/2+1,
     A(k)=-20*log10(abs(X(k)));
   end

  [sortX, index] = sort(A,'descend');


  Amodified = zeros(1,dft_size/2+1);
  Xmodified = zeros(1,dft_size);


  if(1),
  for k=1:dft_size/2+1,
     for j=1:TopRanks,
       if (k == index(j)),
         Amodified(k) = A(k);
         Xmodified(k) = sortX(k);
         Xmodified(dft_size - k) = sortX(k);
       end;
     end;
  end;
  end;
  
  #Xmodified = X;

  #for k=1:dft_size,
  #  Xmodified(k) = 1/10^(Xmodified(k)/20);
  #end;

  
  
if(1),  
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

  result_x = horzcat( result_x, real( ifft( Xmodified, dft_size )));

end;





#for k=1:length(result_x),
#  result_x(k) = (1/10^(result_x(k)/20)-1)*2500;
#end;


sound(result_x, fs);

#return;


#sound(result,fs);




shift_size = 1;
window_size = 1;
number_of_frame=floor((length(result_x)-(window_size-shift_size))/shift_size)-1;

for frame=1:number_of_frame,
   offset=shift_size*(frame-1);
   for n=1:Len:window_size,
     subResX = result_x(offset+n:offset+n+Len-1);
     avg = mean(subResX);
     finalResult(offset+n:offset+n+Len-1) = avg;
     avg = 0.0;
   end;
end;


#for k=1:length(finalResult),
#  finalResult(k) = (1/10^(finalResult(k)/20)-1)*2500;
#end;

sound(finalResult, fs);


#sound(real(ifft(tmp, dft_size)),fs);


#x_real = real( ifft(X_real, dft_size/2+1) );




