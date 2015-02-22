close all;
clear;


% --- Selecting WAV File to input
[ fname, pname ] = uigetfile( '*.wav', 'SELECT WAV FILE' );
audFileName = strcat( pname, '/', fname );

% ---  Partial Reading of WAV File:
% samples = [ start, end ] (duration*Fs),
% inf = whole time
samples = [ 1, inf ];
[ s0, Fs ] = audioread( audFileName, samples );

% --- Initializing
t0 = ( 1 : length(s0) ) / Fs; % Time vector
s0R = s0( 1 : length(s0), 1 ); % R channel
%s0L = s0( 1 : length(s0), 2 ); % L channel
s = s0R; % Selecting Single Channel of input WAV File



%sound( s0, Fs ); %Original audio



% --- Low-Pass Filter (MATLAB default) Process
if ( 1 ),
    cutf = 4000; % Cut-off frequency
    cutfnorm = cutf / ( Fs / 2 ); % Normalized frequency
    df = designfilt( 'lowpassfir', 'FilterOrder', 100, 'CutoffFrequency', cutfnorm );
    % --- Check Delay Effect by LPF above
    %grpdelay( df, 2048, Fs ); % When Group Delay is uniform, it
    %should be fixed by simply time shift
    D = mean( grpdelay( df ) ); % Average delay
    % --- Filter + Delay Fix
    slength = length( s );
    %s = filter( df, s ); % Filter without Delay Fix
    
    %                  X  <- WHY! WHY! WHY!
    s = filter( df, [ s; zeros(D,1) ] );
    s = s( D+1 : slength+D );
    %sound( s, Fs );
    %plot( t0, s0R, t0, s );
    %axis( [ 0.3, 0.35, -0.2, 0.2 ] );
end;



% --- FFT (MATLAB default) Process
dftsize = 512;
dftsize = dftsize * 4;
nframe = floor( length(s0) / dftsize );
clear sCplx; % Signal after FFT as Complex Number
clear sFreq; % Frequencies of Signal after FFT as Complex Number
clear sMagn; % Amplitudes of Signal after FFT as Complex Number
clear sPhas; % Phases of Signal after FFT as Complex Number
for i = 1 : nframe,
    tmpshift = dftsize * ( i - 1 );
    fftS = fft( s( tmpshift + 1 : tmpshift + dftsize ), dftsize );
    if ( i == 1 ),
        sCplx = fftS;
        sMagn = abs( fftS );
        sPhas = unwrap( angle( fftS ) );
    else
        sCplx = horzcat( sCplx, fftS );
        sMagn = horzcat( sMagn, abs( fftS ) );
        sPhas = horzcat( sPhas, unwrap( angle( fftS ) ) );
    end;
    for k = 1 : dftsize,
        sFreq( k, i ) = ( Fs / dftsize ) * (k);
    end;
end;



% WHY! WHY! WHY!

% --- Discard Process for Mirrored Frequencies
for k = 1 : nframe,
    t3D( k ) = ( dftsize/Fs ) * (k);
end;
for l=1:dftsize/2,
    f3D( l ) = ( Fs/dftsize ) * (l);
end;
for k = 1 : nframe,
    for l = 1 : dftsize/2,
        m3D( l, k ) = sMagn( l, k );
        db3D( l, k ) = 20 * log10( sMagn( l, k ) );
        x3D( l, k ) = sCplx( l, k );
    end;
end;
if (0),
    surf( t3D, f3D, db3D, 'FaceColor', 'interp', 'EdgeColor', 'none', 'FaceLighting', 'phong');
    %mesh(t3D,f3D,db3D);
    xlabel('Time [sec]');
    ylabel('Frequency [Hz]');
    zlabel('Magnitude [dB]');
end;


% --- Sort & Select by Magnitudes
if (0),
    sortTop( 1 : nframe ) = 8;
    clear sScplx; % Selected Signal after FFT as Complex Number
    clear sSfreq; % Selected Frequencies of Signal after FFT as Complex Number
    clear sSmagn; % Selected Amplitudes of Signal after FFT as Complex Number
    clear sSphas; % Selected Phases of Signal after FFT as Complex Number
    for k = 1 : nframe,
        [ sSmagntemp, sortIdx ] = sortrows( m3D, -1*k );
        for l = 1 : sortTop(k),
            sSmagn( l, k ) = sSmagntemp( l, k );
            sScplx( l, k ) = sCplx( sortIdx( l ), k );
            sSfreq( l, k ) = sFreq( sortIdx( l ), k );
            sSphas( l, k ) = sPhas( sortIdx( l ), k );
        end;
    end;
    % --- 2D Graph plot
    if (0),
        for k = 1 : nframe,  %
            for l = 1 : sortTop,
                t3D2( k ) = ( dftsize / Fs ) * (k);
                f2D( 1, (k-1) * sortTop + l ) = sSfreq( l, k );
                f2D( 2, (k-1) * sortTop + l ) = t3D2( k );
            end;
        end;
        scatter( f2D( 2, : ), f2D( 1, : ), 50, '+');
        xlabel( 'Time [sec]' );
        ylabel( 'Frequency [Hz]' );
        %axis( [ 1.0, 1.5, 0, 4000 ] );
        axis( [ 0, 3.5, 0, 4000 ] );
    end;
    % --- 3D Graph plot
    if (0),
        for l = 1 : sortTop,  % Freq Axis
            for k = 1 : nframe,  % Time Axis
                t3D2( k) = ( dftsize / Fs ) * (k);
                f3D2( l, k ) = sSfreq( l, k );
                m3D2( l, k ) = sSmagn( l, k );
                db3D2( l, k ) = 20 * log10( sSmagn( l, k ) );
            end;
            if ( l == 1 ),
                scatter3( t3D2, f3D2( l, : ), db3D2( l, : ) );
                xlabel( 'Time [sec]' );
                ylabel( 'Frequency [Hz]' );
                zlabel( 'Magnitude [dB]' );
                hold on;
            else
                scatter3( t3D2, f3D2( l, : ), db3D2( l, : ) );
            end;
        end;
        hold off;
        
        if (0),
            surf( t3D2, f3D2, db3D2, 'FaceColor', 'interp', 'EdgeColor', 'none', 'FaceLighting', 'phong' );
            %surf(t3D2,f3D2,db3D2);
            %mesh(t3D2,f3D2,db3D2);
            %scatter3(t3D2,f3D2,db3D2);
        end;
    end;
    % --- IFFT Process after simply Sort & Select by Magnitudes (above)
    if (0),
        ifftS = zeros( 1, dftsize );
        for k = 1 : nframe,
            for l = 1 : sortTop,
                Xp( l ) = sScplx( l, k );
                Xp( dftsize - l ) = sScplx( l, k );
            end;
            % Amplpify the REAL part of the result by IFFT
            ifftS = horzcat( ifftS, real( ifft( Xp, dftsize ) * 5.5 ) );
        end;
        sound( ifftS, Fs );
        plot( ifftS );
        %axis( [ 8190, 12288, -0.8, 0.8 ] );
    end;
    % --- Sort by Frequencies
    clear sFcplx; % Frquency-Sorted Signal after FFT as Complex Number
    clear sFfreq; % Frquency-Sorted Frequencies of Signal after FFT as Complex Number
    clear sFmagn; % Frquency-Sorted Amplitudes of Signal after FFT as Complex Number
    clear sFphas; % Frquency-Sorted Phases of Signal after FFT as Complex Number
    for k = 1 : nframe,
        [ sCfreqtemp, sortIdx ] = sortrows( sSfreq, k );
        for l = 1 : sortTop( k ),
            sFmagn( l, k ) = sSmagn( sortIdx(l), k );
            sFcplx( l, k ) = sScplx( sortIdx(l), k );
            sFfreq( l, k ) = sCfreqtemp( l, k );
            sFphas( l, k ) = sSphas( sortIdx(l), k );
        end;
    end;
    % --- IFFT Process after simply Sort & Select by Frequencies (above)
    if(0),
        for k = 1 : nframe,
            for l = 1 : sortTop,
                Xp( l ) = sFcplx( l, k );
                Xp( dftsize - l ) = sFcplx( l, k );
            end;
            if ( k == 1 ),
                ifftS = real( ifft( Xp, dftsize ) * 5.5 );
            else
                ifftS = horzcat( ifftS, real( ifft( Xp, dftsize ) * 5.5 ) );
            end;
        end;
        sound( ifftS, Fs );
        tXp = ( 1 : length(ifftS) ) / Fs; % Time vector
        plot( tXp, ifftS );
        %axis( [ 1, 1.1, -0.7, 0.7 ] );
    end;
end;



% --- Select by the Picking-Up Freq. Peaks in WAV form
if (1),
    sortTop( 1 : nframe ) = 0;
    tmpStop = 0;
    clear sFcplx; % Frequency-Selected Signal after FFT as Complex Number
    clear sFfreq; % Frequency-Selected Frequencies of Signal after FFT as Complex Number
    clear sFmagn; % Frequency-Selected Amplitudes of Signal after FFT as Complex Number
    clear sFphas; % Frequency-Selected Phases of Signal after FFT as Complex Number
    for k = 1 : nframe,
        tmpStop = 0;
        if ( sMagn( 1, k ) > 0.1),
            if ( sMagn( 1, k ) >= sMagn( 2, k ) ),
                tmpStop = tmpStop + 1;
                sFmagn( tmpStop, k ) = sMagn( 1, k );
                sFcplx( tmpStop, k ) = sCplx( 1, k );
                sFfreq( tmpStop, k ) = sFreq( 1, k );
                sFphas( tmpStop, k ) = sPhas( 1, k );
                sFfreqtmp( tmpStop, k ) = sFreq( 1, k ); % For 2D Graph plot
                sFmagntmp( tmpStop, k ) = sMagn( 1, k ); % For 2D Graph plot
            end;
        end;
        for l = 2 : dftsize / 2 - 1,
            if ( sMagn( l, k ) > 0.1),
                if ( sMagn( l, k ) >= sMagn( l-1, k ) ) && ( sMagn( l, k ) >= sMagn( l+1, k ) ),
                    tmpStop = tmpStop + 1;
                    sFmagn( tmpStop, k ) = sMagn( l, k );
                    sFcplx( tmpStop, k ) = sCplx( l, k );
                    sFfreq( tmpStop, k ) = sFreq( l, k );
                    sFphas( tmpStop, k ) = sPhas( l, k );
                    % For 2D Graph plot
                    sFfreqtmp( l, k ) = sFreq( l, k );
                    % For 2D Graph plot
                    sFmagntmp( l, k ) = sMagn( l, k );
                end;
            end;
        end;
        if ( sMagn( dftsize/2, k ) > 0.1),
            if ( sMagn( dftsize/2, k ) >= sMagn( dftsize/2-1, k ) ),
                tmpStop = tmpStop + 1;
                sFmagn( tmpStop, k ) = sMagn( dftsize/2, k );
                sFcplx( tmpStop, k ) = sCplx( dftsize/2, k );
                sFfreq( tmpStop, k ) = sFreq( dftsize/2, k );
                sFphas( tmpStop, k ) = sPhas( dftsize/2, k );
                sFfreqtmp( l, k ) = sFreq( dftsize/2, k );
                % For 2D Graph plot
                sFmagntmp( l, k ) = sMagn( dftsize/2, k );
                % For 2D Graph plot
            end;
        end;
        sortTop( k ) = tmpStop;
    end;
    % --- 2D Graph plot
    if(0),
        plot( m3D( :, 101 ) );
        hold on;
        plot( sFmagntmp( :, 101 ), 'bo' );
        hold off;
        axis( [ 0, 50, 0, 15 ] );
    end;
end;
% --- 2D Graph plot
if(0),
    for k = 1 : nframe,  % Time Axis
        t3D2( k ) = (dftsize/Fs) * (k);
    end;
    scatter( t3D2, sFfreq( 1, : ), 30, '+');
    xlabel( 'Time [sec]' );
    ylabel( 'Frequency [Hz]' );
    %axis( [1.0, 1.5, 0, 4000 ] );
    %axis( [0.5, 2.0, 0, 700 ] );
    %axis( [0, 3.5, 0, 4500 ] );
    hold on;
    for l = 2 : max( sortTop ),
        scatter( t3D2, sFfreq( l, : ), 30, '+' );
    end;
    hold off;
end;



% --- Connecting Check by Freqs
delta = 2^(1/12);
strcnt = 0;

clear sFstno; % String Container Array after Connecting Check
sFstno = zeros( max( sortTop ), nframe );
clear sCcplx; % String "Complex" Container Array after Connecting Check
clear sCfreq; % String "Frequencies" Container Array after Connecting Check
sCfreq = zeros( max( sortTop ), nframe );
clear sCmagn; % String "Amplitudes" Container Array after Connecting Check
clear sCphas; % String "Phases" Container Array after Connecting Check

if (1),
    for k = 1 : nframe-1,
        for l = 1 : sortTop( k ),
            for m = 1 : sortTop( k + 1 ),
                if ( sFfreq( l, k ) ~= 0) && ( sFfreq( m, k + 1 ) ~= 0) && ( sFfreq( l, k ) == sFfreq( m, k + 1 ) ),
                    if ( sFstno( l, k ) == 0 ),
                        strcnt = strcnt + 1;
                        sFstno( l, k ) = strcnt;
                        sFstno( m, k+1 ) = strcnt;
                        sCmagn( strcnt, k ) = sFmagn( l, k );
                        sCcplx( strcnt, k ) = sFcplx( l, k );
                        sCfreq( strcnt, k ) = sFfreq( l, k );
                        sCphas( strcnt, k ) = sFphas( l, k );
                        sCmagn( strcnt, k+1 ) = sFmagn( m, k+1 );
                        sCcplx( strcnt, k+1 ) = sFcplx( m, k+1 );
                        sCfreq( strcnt, k+1 ) = sFfreq( m, k+1 );
                        sCphas( strcnt, k+1 ) = sFphas( m, k+1 );
                    else
                        sFstno( m, k+1 ) = sFstno( l, k );
                        sCmagn( sFstno( l, k ), k+1 ) = sFmagn( m, k+1 );
                        sCcplx( sFstno( l, k ), k+1 ) = sFcplx( m, k+1 );
                        sCfreq( sFstno( l, k ), k+1 ) = sFfreq( m, k+1 );
                        sCphas( sFstno( l, k ), k+1 ) = sFphas( m, k+1 );
                    end;
                end;
            end;
        end;
        for l = 1 : sortTop( k ) - 1,
            if ( sFstno( l, k ) == 0),
                tempStringFlag = 0;
            else
                tempStringFlag = sCfreq( sFstno( l,k ), k+1 );
            end;
            if (tempStringFlag == 0),
                fDiff = -1;
                dDiff = sFfreq( l, k ) * ( delta - 1 );
                tmpR = 0;
                for m = 1 : sortTop( k + 1 ),
                    if ( sFfreq( l, k ) ~= 0 ) && ( sFfreq( m, k+1 ) ~= 0) && ( sFstno( m, k+1 ) == 0 ),
                        if ( abs( sFfreq( l, k ) - sFfreq( m, k+1 ) ) <= dDiff) ...
                                && ( abs( sFfreq( l, k ) - sFfreq( m, k+1 ) ) <= abs( sFfreq( l + 1, k ) - sFfreq( m, k + 1 ) ) ),
                            if ( fDiff < 0 ),
                                fDiff = abs( sFfreq( l, k ) - sFfreq( m, k + 1 ) );
                                tmpR = m;
                            else
                                if ( abs( sFfreq( l, k ) - sFfreq( m, k + 1 ) ) < fDiff ),
                                    fDiff = abs( sFfreq( l, k ) - sFfreq( m, k + 1 ) );
                                    tmpR = m;
                                else
                                    break;
                                end;
                            end;
                        end;
                    end;
                end;
                if ( tmpR ~= 0 ),
                    if( sFstno( l, k ) == 0 ),
                        strcnt = strcnt + 1;
                        sFstno( l, k ) = strcnt;
                        sFstno( tmpR, k+1  )= strcnt;
                        sCmagn( strcnt, k ) = sFmagn( l, k );
                        sCcplx( strcnt, k ) = sFcplx( l, k );
                        sCfreq( strcnt, k ) = sFfreq( l, k );
                        sCphas( strcnt, k ) = sFphas( l, k );
                        sCmagn( strcnt, k+1 ) = sFmagn( tmpR, k+1 );
                        sCcplx( strcnt, k+1 ) = sFcplx( tmpR, k+1 );
                        sCfreq( strcnt, k+1 ) = sFfreq( tmpR, k+1 );
                        sCphas( strcnt, k+1 ) = sFphas( tmpR, k+1 );
                    else
                        sFstno( tmpR, k+1 ) = sFstno( l, k );
                        sCmagn( sFstno( l, k ),k+1 ) = sFmagn( tmpR, k+1 );
                        sCcplx( sFstno( l, k ),k+1 ) = sFcplx( tmpR, k+1 );
                        sCfreq( sFstno( l, k ),k+1 ) = sFfreq( tmpR, k+1 );
                        sCphas( sFstno( l, k ),k+1 ) = sFphas( tmpR, k+1 );
                    end;
                end;
            end;
        end;
        for l = 1 : sortTop( k ),
            if ( sFstno( l, k ) == 0 ),
                tempStringFlag = 0;
            else
                tempStringFlag = sCfreq( sFstno( l, k ), k+1 );
            end;
            if ( tempStringFlag == 0 ),
                fDiff = -1;
                dDiff = sFfreq( l, k ) * ( delta - 1 );
                tmpR = 0;
                for m = 1 : sortTop( k + 1 ),
                    if ( sFfreq( l, k ) ~= 0) && ( sFfreq( m, k + 1 ) ~= 0) && ( sFstno( m, k + 1 ) == 0),
                        if ( abs( sFfreq( l, k ) - sFfreq( m, k + 1 ) ) <= dDiff ),
                            if ( fDiff < 0 ),
                                fDiff = abs( sFfreq( l, k ) - sFfreq( m, k + 1 ) );
                                tmpR = m;
                            else
                                if ( abs( sFfreq( l, k ) - sFfreq( m, k + 1 ) ) < fDiff ),
                                    fDiff = abs( sFfreq( l, k ) - sFfreq( m, k + 1 ) );
                                    tmpR = m;
                                else
                                    break;
                                end;
                            end;
                        end;
                    end;
                end;
                if ( tmpR ~= 0 ),
                    if ( sFstno( l, k ) == 0 ),
                        strcnt = strcnt + 1;
                        sFstno( l, k)=strcnt;
                        sFstno( tmpR, k + 1 )=strcnt;
                        sCmagn( strcnt, k ) = sFmagn( l, k );
                        sCcplx( strcnt, k ) = sFcplx( l, k );
                        sCfreq( strcnt, k ) = sFfreq( l, k );
                        sCphas( strcnt, k ) = sFphas( l, k );
                        sCmagn( strcnt, k +1 ) = sFmagn( tmpR, k+1);
                        sCcplx( strcnt, k +1 ) = sFcplx( tmpR, k+1);
                        sCfreq( strcnt, k +1 ) = sFfreq( tmpR, k+1);
                        sCphas( strcnt, k +1 ) = sFphas( tmpR, k+1);
                    else
                        sFstno( tmpR, k + 1 ) = sFstno( l, k );
                        sCmagn( sFstno( l, k ), k+1 ) = sFmagn( tmpR, k+1 );
                        sCcplx( sFstno( l, k ), k+1 ) = sFcplx( tmpR, k+1 );
                        sCfreq( sFstno( l, k ), k+1 ) = sFfreq( tmpR, k+1 );
                        sCphas( sFstno( l, k ), k+1 ) = sFphas( tmpR, k+1 );
                    end;
                end;
            end;
        end;
    end;
    % --- 2D Graph plot
    if(0),
        plot( sCfreq( 116, : ) );
    end;
end;



% --- 2D Graph plot
if(0),
    for k = 1 : nframe,  % Time Axis
        t3D2( k ) = ( dftsize / Fs ) * (k);
    end;
    scatter( t3D2, sCfreq( 1, : ), 30, '+' );
    xlabel( 'Time [sec]' );
    ylabel( 'Frequency [Hz]' );
    %axis( [ 1.0, 1.5, 0, 4000 ] );
    axis( [ 0.5, 2.0, 0, 700 ] );
    %axis( [ 0, 3.5, 0, 4500 ] );
    hold on;
    for l = 2 : strcnt,
        scatter( t3D2, sCfreq( l, : ), 30, '+' );
    end;
    hold off;
end;




% --- Sort & Select by the Length of Connected Strings
clear sCstln; % Array for the Length of Connected Strings
clear sLcplx; % Select-by-the-Length Signal after FFT as Complex Number
clear sLfreq; % Select-by-the-Length Frequencies after FFT as Complex Number
clear sLmagn; % Select-by-the-Length Amplitudes after FFT as Complex Number
clear sLphas; % Select-by-the-Length Phases after FFT as Complex Number
nString = strcnt;
strLen = 13;
nSstring = 0;
if (1),
    for l = 1 : nString,
        len = 0;
        for k = 1 : nframe,
            if ( sCcplx( l, k ) ~= 0 ),
                len = len + 1;
            end;
        end;
        sCstln( l, 1 ) = len;
        if ( len >= strLen ),
            nSstring = nSstring + 1;
        end;
    end;
    [ sCstlntemp, sortIdx ] = sortrows( sCstln, -1 );
    for l = 1 : nSstring,
        for k = 1 : nframe,
            sLmagn( l, k ) = sCmagn( sortIdx( l ), k );
            sLcplx( l, k ) = sCcplx( sortIdx( l ), k );
            sLfreq( l, k ) = sCfreq( sortIdx( l ), k );
            sLphas( l, k ) = sCphas( sortIdx( l ), k );
        end;
    end;
end;
% -----------------------------------------------
if (0),
    % The Process as if sorted every raws form a single string
    sLcplx = sFcplx;
    sLmagn = sFmagn;
    sLfreq = sFfreq;
    sLphas = sFphas;
    for k = 1 : nframe,
        for l = 1 : sortTop,
            sCstno( l, k ) = l;
            sCstor( l, k ) = k;
        end;
    end;
end;
% -----------------------------------------------



% --- 2D Graph plot
if (0),
    for k = 1 : nframe,  % Time Axis
        t3D2( k ) = ( dftsize / Fs ) * (k);
    end;
    scatter( t3D2, sLfreq( 1, : ), 50, '+' );
    xlabel( 'Time [sec]' );
    ylabel( 'Frequency [Hz]' );
    %axis( [ 1.0, 1.5, 0, 4000 ] );
    axis( [ 0, 3.5, 0, 4500 ] );
    hold on;
    for l = 2 : nSstring,
        scatter( t3D2, sLfreq( l, : ), 50, '+' );
    end;
    hold off;
end;



% --- 3D Graph plot
if (1),
    for l = 1 : nSstring,  % Number of Strings
        for k = 1 : nframe,  % Frame
            t3D2( k ) = ( dftsize / Fs ) * (k);
            f3D2( l, k ) = sLfreq( l, k );
            m3D2( l, k ) = sLmagn( l, k );
            db3D2( l, k ) = 20 * log10( sLmagn( l, k ...
                ) );
        end;
        lw = 3;
        ms = 5;
        if( l == 1 ),
            %surf( t3D2, f3D, db3D, 'FaceColor', 'interp',
            %'EdgeColor', 'none', 'FaceLighting', 'phong' );
            %mesh( t3D2, f3D, db3D );
            plot3( t3D2, f3D2( l, : ), db3D2( l, : ), '-ob', 'LineWidth', lw, 'MarkerSize', ms );
            %plot3( t3D2, f3D2( 1, : ), db3D2( 1, : ) );
            %scatter3( t3D2, f3D2( 1, : ), db3D2( 1, : ) );
            xlabel( 'Time [sec]' );
            ylabel( 'Frequency [Hz]' );
            zlabel( 'Magnitude [dB]' );
            hold on;
            grid on;
        else
            colorNo = mod(l,5);
            switch colorNo
                case 1
                    %strC = 'b';
                    plot3(t3D2,f3D2(l,:),db3D2(l,:),'-ob', 'LineWidth',lw, 'MarkerSize',ms);
                case 2
                    %strC = 'r';
                    plot3(t3D2,f3D2(l,:),db3D2(l,:),'-or', 'LineWidth',lw, 'MarkerSize',ms);
                case 3
                    %strC = 'g';
                    plot3(t3D2,f3D2(l,:),db3D2(l,:),'-og', 'LineWidth',lw, 'MarkerSize',ms);
                case 4
                    %strC = 'y';
                    plot3(t3D2,f3D2(l,:),db3D2(l,:),'-oy', 'LineWidth',lw, 'MarkerSize',ms);
                case 0
                    %strC = 'k';
                    plot3(t3D2,f3D2(l,:),db3D2(l,:),'-ok', 'LineWidth',lw, 'MarkerSize',ms);
            end;
            %plot3( t3D2, f3D2( l, : ), db3D2( l, : ), strC %);
            %scatter3( t3D2, f3D2( l, : ), db3D2( l, : ) );
        end;
    end;
    hold off;
end;


clear SUMSUM;
clear SUMSUMSUM;
SUMSUM = [];
SUMSUMSUM = [];

% --- IFFT and Cubic Interpolations for the Rest of Strings (sL series)
if (1),
    for l = 1 : nSstring,
        for k = 1 : nframe,
            %        if( sLcplx( l, k ) ~= 0 ),
            Xp( l + 1 ) = sLcplx( l, k );
            Xp( dftsize - l + 1 ) = sLcplx( l, k );
            %        end;
            if ( k == 1 ),
                ifftS = real( ifft( Xp, dftsize ) ) * 2 ;
            else
                ifftS = horzcat( ifftS, real( ifft( Xp, dftsize ) ) * 2 );
                if(1), % Cubic Interplation Caluculation
                    gThree = 0;
                    gTwo = 0;
                    gOne = 0;
                    gZero = 0;
                    gTtmp1 = 0;
                    gTtmp2 = 0;
                    alpha1 = 0;
                    alpha2 = 0;
                    alphaF = 0;
                    beta1 = 0;
                    beta2 = 0;
                    betaF = 0;
                    for tempj = 1 : dftsize - 1,
                        originIdx = dftsize * ( k - 1 ) + 1;
                        searchIdx = originIdx - tempj;
                        if ( sign( ifftS( searchIdx ) ) * sign( ifftS( searchIdx - 1 ) ) <=  0 ),
                            if ( alphaF == 0 ),
                                alpha1 = searchIdx;
                                alpha2 = searchIdx - 1;
                                alphaF = 1;
                            else
                                if ( alpha2 ~= searchIdx ),
                                    beta1 = searchIdx;
                                    beta2 = searchIdx - 1;
                                    betaF = 1;
                                end;
                            end;
                        end;
                        if (betaF == 1),
                            break;
                        end;
                    end;
                    gZero = ifftS( originIdx );
                    gOne = ( ifftS( originIdx + 1 ) - ifftS( originIdx ) ) / ( 1 / Fs );
                    gTtmp1 = ifftS( beta1 );
                    gTtmp2 = ( ifftS( beta1 ) - ifftS( beta2 ) ) / ( 1 / Fs );
                    gTwo = ( -3 / ( ( beta1 - originIdx ) / Fs ) ^ 2 ) * ( gZero - gTtmp1 ) + ( -1 / ( ( beta1 - originIdx ) / Fs ) ) ...
                        * ( 2 * gOne + gTtmp2 );
                    gThree = ( 2 / ( ( beta1 - originIdx ) / Fs ) ^ 3 ) * ( gZero - gTtmp1 ) + ( 1 / ( ( beta1 - originIdx ) / Fs ) ^ 2 ) ...
                        * ( gOne + gTtmp2 );
                    for tempi = beta2 : originIdx - 1,
                        ifftS( tempi ) = gThree * ( ( tempi - originIdx ) / Fs ) ^ 3 ...
                            + gTwo * ( ( tempi - originIdx ) / Fs ) ^ 2 + gOne * ( ( tempi - originIdx ) / Fs ) + gZero;
                    end;
                end;
            end;
        end; % End of Process for Every Frames

        % Replay Each Strings separately ###############
        if (1),
            sound( ifftS, Fs );
            pause( 1 );
            SUMSUMSUM = horzcat( SUMSUMSUM, ifftS );
            
        end;
        
        % Adding Every Strings together        
        if ( l == 1 ),
            sumS = ifftS;
        else
            sumS = sumS + ifftS;
        end;
    end;  % End of Process for Every Strings
    sound( sumS, Fs );
    tXp  =  (1:length(sumS))/Fs; % Time vector
    plot( tXp, sumS );
    axis( [ 0.0, 1.55, -0.5, 0.5 ]);
end;