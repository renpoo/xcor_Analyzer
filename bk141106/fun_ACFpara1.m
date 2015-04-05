function [tau1m,phi1m,wphi0] = fun_ACFpara1(acfplot,Fs,mf0)

% Calculation of ACF parameters of tau1, phi1, tau1m, phi1m, and wphi0

trgl = 1;
linpeaks = zeros( floor(Fs/mf0)-1, 2 );

% ACF0NX_̃Xgo
for i = 1:Fs*0.1
   if (acfplot(i,2) < 0.0),
      trgl = i;break,
  end 
end

% Calculation of tau1 and phi1 (First peak of nACF)
for i = trgl : floor(Fs/mf0)-1
   if ( acfplot(i,2)>acfplot(i+1,2) ) && ( acfplot(i,2)>acfplot(i-1,2) ) && ( acfplot(i,2)>0.0 ),
      linpeaks(i,[1 2]) = acfplot(i,[1 2]);
      a = find(linpeaks(:,2));
      linpeaks = linpeaks(a,[1 2]);
   end
end
[phi1m,b] = max(linpeaks(:,2));        % Max peak of ACF
tau1m = linpeaks(b,1);

% Calculation of wphi0
for i = 1:floor(Fs/mf0)-1
   if acfplot(i,2) < 0.5
      break
   end
end


# Exception
#if (i == 1) i = 2; endif;


wpls=0;

number_of_errors = 0;
try

  wpls=interp1(acfplot(i-1:i,2),acfplot(i-1:i,1),0.5,'linear');

catch
  msg = lasterror.message;
  if ( strfind (msg, "at least one interval is needed") ),
    number_of_errors++;
    disp( cat('### ', i) );
  endif;
end_try_catch


wphi0=2*wpls;
