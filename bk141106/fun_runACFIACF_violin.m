function res=fun_runACFIACF_violin(y,Fs,int,rs,gainL,gainR,fname)

% Function of calculation "fun_runACFIACF.m"
% Calculation manuscript of running ACF and IACF
% Output ACF parameters are phi0, tau1, phi1, tau1m, phi1m and taue.
% Output IACF parameters are IACC, tauIACC and wIACC.
% When you want to calculate IACF for each band, use "fun_runIACF.m"

debugFlag = 1;


yl=y(:,1);
yr=y(:,2);
d=length(y);            % Data length [sample]

if (debugFlag),
  dump_data_(yl, 'yl', 'dumpData_SANSOHKEN');
  dump_data_(yr, 'yr', 'dumpData_SANSOHKEN');
endif;


% Definitions of variables
Int=int*Fs;                  % Integration interval [sample]
step=rs*Fs;                  % Running step [sample]
mf0=20;                      % Minimum fundamemntal frequncy [Hz]
dl=Int*2;                    % Sample number of data [sample]
rng = floor(Fs*0.001);       % disply range of CCF [sample]
dlt = 0.1;                   % definition of the Wiacc

% Remove DC
yl=yl-mean(yl);
yr=yr-mean(yr);

if (debugFlag),
  dump_data_(yl, 'yl_subtruct_mean', 'dumpData_SANSOHKEN');
  dump_data_(yr, 'yr_subtruct_mean', 'dumpData_SANSOHKEN');
endif;


% Laveling of RunningStep
rnn=(1:floor(step):d-Int)';         % Label of running steps
RunningStep=length(rnn);            % Display the amount of running steps

yl=cat(1,yl,zeros(Int,1));           % Add zeros at the last frame
yr=cat(1,yr,zeros(Int,1));

if (debugFlag),
  dump_data_(yl, 'yl_append', 'dumpData_SANSOHKEN');
  dump_data_(yr, 'yr_append', 'dumpData_SANSOHKEN');
endif;


warning off; Ayl=afilter(yl,Fs);     % A-weighting signal (L)
warning off; Ayr=afilter(yr,Fs);     % A-weighting signal (R)

if (debugFlag),
  dump_data_(Ayl, 'Ayl', 'dumpData_SANSOHKEN');
  dump_data_(Ayr, 'Ayr', 'dumpData_SANSOHKEN');
endif;


if (debugFlag),
  dump_data_(rnn, 'rnn', 'dumpData_SANSOHKEN');
endif;


res=zeros(RunningStep,13);

for z=1:RunningStep

    trg=rnn(z);
    yal=Ayl(floor(trg):floor(trg+dl-1));   % A-weighted signal (L)
    yar=Ayr(floor(trg):floor(trg+dl-1));   % A-weighted signal (R)
    ysl=yl(floor(trg):floor(trg+dl-1));    % Original signal (L)
    ysr=yr(floor(trg):floor(trg+dl-1));    % Original signal (R)

    Z1=zeros(floor(dl-Int),1);
    y0l=cat(1,yal(1:Int),Z1);                    
    y0r=cat(1,yar(1:Int),Z1);

    if (debugFlag),
      dump_data_(yal, 'yal', 'dumpData_SANSOHKEN');
      dump_data_(yar, 'yar', 'dumpData_SANSOHKEN');
      dump_data_(ysl, 'ysl', 'dumpData_SANSOHKEN');
      dump_data_(ysr, 'ysr', 'dumpData_SANSOHKEN');
      dump_data_(y0l, 'y0l', 'dumpData_SANSOHKEN');
      dump_data_(y0r, 'y0r', 'dumpData_SANSOHKEN');
    endif;

    
    ffl = fft(yal); ffr = fft(yar);
    ff0l = fft(y0l); ff0r=fft(y0r);

    if (debugFlag),
      dump_data_(ffl, 'ffl', 'dumpData_SANSOHKEN');
      dump_data_(ffr, 'ffr', 'dumpData_SANSOHKEN');
      dump_data_(ff0l, 'ff0l', 'dumpData_SANSOHKEN');
      dump_data_(ff0r, 'ff0r', 'dumpData_SANSOHKEN');
    endif;


    ACFl = real(ifft(ffl.*conj(ff0l)));
    ACFr = real(ifft(ffr.*conj(ff0r)));
    CCFl = real(ifft(ffl.*conj(ff0r)));
    CCFr = real(ifft(ffr.*conj(ff0l)));

    if (debugFlag),
      dump_data_(ACFl, 'ACFl', 'dumpData_SANSOHKEN');
      dump_data_(ACFr, 'ACFr', 'dumpData_SANSOHKEN');
      dump_data_(CCFl, 'CCFl', 'dumpData_SANSOHKEN');
      dump_data_(CCFr, 'CCFr', 'dumpData_SANSOHKEN');
    endif;


    % Normalize
    n=1;
    maxlag=floor(Int);
    normalizerL=zeros(1,maxlag);normalizerR=zeros(1,maxlag);
    normalizerBINL=zeros(1,maxlag);normalizerBINR=zeros(1,maxlag);
    for lag=0
        tmpl=yal(1:Int).*yal(1+lag:Int+lag);
        tmpr=yar(1:Int).*yar(1+lag:Int+lag);
        phitmpl=sum(tmpl);phitmpr=sum(tmpr);
        phitl=sum(tmpl);phitr=sum(tmpr);
        normalizerL(n)=(phitl*phitmpl)^0.5;
        normalizerR(n)=(phitr*phitmpr)^0.5;
        normalizerBINL(n)=(phitl*phitmpr)^0.5;
        normalizerBINR(n)=(phitr*phitmpl)^0.5;
        n=n+1;
    end

    for lag=1:maxlag-1
        phitmpl=phitmpl-yal(1+lag)^2+yal(Int+lag)^2;
        phitmpr=phitmpr-yar(1+lag)^2+yar(Int+lag)^2;
        normalizerL(n)=(phitl*phitmpl)^0.5;
        normalizerR(n)=(phitr*phitmpr)^0.5;
        normalizerBINL(n)=(phitl*phitmpr)^0.5;
        normalizerBINR(n)=(phitr*phitmpl)^0.5;
        n=n+1;
    end
  
    if (debugFlag),
      dump_data_(normalizerL, 'normalizerL', 'dumpData_SANSOHKEN');
      dump_data_(normalizerR, 'normalizerR', 'dumpData_SANSOHKEN');
      dump_data_(normalizerBINL, 'normalizerBINL', 'dumpData_SANSOHKEN');
      dump_data_(normalizerBINR, 'normalizerBINR', 'dumpData_SANSOHKEN');
    endif;

    
    nACFl=ACFl(1:maxlag)./normalizerL';
    nACFr=ACFr(1:maxlag)./normalizerR';
    nCCFl=CCFl(1:maxlag)./normalizerBINL';
    nCCFr=CCFr(1:maxlag)./normalizerBINR';

    if (debugFlag),
      dump_data_(nACFl, 'nACFl', 'dumpData_SANSOHKEN');
      dump_data_(nACFr, 'nACFr', 'dumpData_SANSOHKEN');
      dump_data_(nCCFl, 'nCCFl', 'dumpData_SANSOHKEN');
      dump_data_(nCCFr, 'nCCFr', 'dumpData_SANSOHKEN');
    endif;

    
    % Spectrum analysis
    fyl=fft(ysl); fyr=fft(ysr);
    Pfyl=fyl.*conj(fyl); Pfyr=fyr.*conj(fyr);
    log_Pfyl=10*log10(Pfyl/max(Pfyl)); log_Pfyr=10*log10(Pfyr/max(Pfyr));
    frq = (0:Fs/length(fyl):Fs);

    Laeq_L=10*log10(mean(yal.^2))+gainL;
    Laeq_R=10*log10(mean(yar.^2))+gainR;
    
    % Acoustical parameters of ACF
    tauscale=(0:maxlag-1)'./Fs*1000;      % tau axis in [ms]

    % Left channel
    acfplot=[tauscale nACFl(1:maxlag)];
    [tau1,phi1,wphi0] = fun_ACFpara1(acfplot,Fs,mf0);   % Calculation of tau1 phi1 wphi0
    [f0peaks,taue,reg]=fun_ACFpara_taue(acfplot,Fs,tau1);   % Calculation of taue
    paraL=[Laeq_L tau1 phi1 taue wphi0];

    % Right channel
    acfplot=[tauscale nACFr(1:maxlag)];
    [tau1,phi1,wphi0] = fun_ACFpara1(acfplot,Fs,mf0);   % Calculation of tau1 phi1 wphi0
    [f0peaks,taue,reg]=fun_ACFpara_taue(acfplot,Fs,tau1);   % Calculation of taue
    paraR=[Laeq_R tau1 phi1 taue wphi0];

    % Binaural channel
    ccfplotl=[tauscale nCCFl];ccfplotr=[tauscale nCCFr];
    ccfplotl=[-1*ccfplotl(:,1) ccfplotl(:,2)];
    ccfplot=cat(1, flipdim(ccfplotl(1:rng,[1 2]),1), ccfplotr(2:rng,[1 2]));      
    [IACC,wIACC,tIACC]=fun_CCFpara(ccfplotl,ccfplotr,rng,dlt);
    paraBIN=[IACC wIACC tIACC];

    para=[paraL paraR paraBIN];
    res(z,:)=para;

        
%   figure
  if (1),
    subplot(3,2,1),
    plot(tauscale,nACFl);axis([0 maxlag/Fs*1000 -1 1]);title('ACF-Left');hold on;
    plot(paraL(4),0.1,'g+');
    xlabel('Delay [ms]'), ylabel('nACF');
    subplot(3,2,2),
    plot(tauscale,nACFr,'r');axis([0 maxlag/Fs*1000 -1 1]);title('ACF-Right');hold on;
    plot(paraR(4),0.1,'g+');
    xlabel('Delay [ms]'), ylabel('nACF');
    subplot(3,2,3),
    semilogx(frq(1:length(fyl)/2),log_Pfyl(1:length(fyl)/2));title('Spectrum-Left');
    axis([20 10000 -100 0])
    xlabel('Frequency [Hz]'), ylabel('Magnitude [dB]');
    subplot(3,2,4),
    semilogx(frq(1:length(fyr)/2),log_Pfyr(1:length(fyr)/2),'r');title('Spectrum-Right');
    axis([20 10000 -100 0])
    xlabel('Frequency [Hz]'), ylabel('Magnitude [dB]');
    subplot(3,2,5),
    plot(ccfplot(:,1),ccfplot(:,2));axis([-1 1 -1 1]);title('IACF');
    xlabel('Delay [ms]'), ylabel('IACF');
  endif;  

end

Vx=zeros(RunningStep,1);
for z=1:RunningStep
    Vx(z)=(z-1)*rs;
end
Vx=num2cell(Vx);
Hd={'Time[s]','L_Phi(0)[dB]','L_tau1[ms]','L_phi1','L_taue[ms]','L_wphi0[ms]','R_Phi(0)[dB]','R_tau1[ms]','R_phi1','R_taue[ms]','R_wphi0[ms]','IACC','wIACC','tIACC'};
Hd=cellstr(Hd);
res=num2cell(res);
res=[Vx res]; 
res=[Hd;res];
fina=strrep(fname,'.wav','_FactorACFIACF.xlsx');
#xlswrite(fina,res); 


#disp(res(:,:));
#return;


if (1),
  pkg load io;
  outputDataFileName = strrep(fina,'Sounds','Output\ Data');
  xlswrite( outputDataFileName, res', 'Sheet1' ); 
endif;

#end;
