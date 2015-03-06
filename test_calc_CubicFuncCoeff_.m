function test_calc_CubicFuncCoeff_()

clear;

A1 = 1.0;
A2 = 0.8;
omega1 = 1;
omega2 = 3/2;
sigma1 = 0;
sigma2 = pi/3;
T = 2*pi;
%ts = T/2-pi/4;
ts = T/2-pi/2;
%te = T-pi/3;
te = T/2;
t1 = ts;
t2 = te;


    function plot_f1_t = f1_plot( A1, omega1, sigma1 )
        plot_f1_t = @wave_f1;
        
        function y = wave_f1( x )
            y = A1 * sin( omega1.*x + sigma1 );
        end
    end

    function plot_f2_t = f2_plot( A2, omega2, sigma2 )
        plot_f2_t = @wave_f2;
        
        function y = wave_f2( x )
            y = A2 * sin( omega2.*x + sigma2 );
        end
    end


    function f1_t = f1( t, A1, omega1, sigma1 )
        f1_t = A1 * sin( omega1.*t + sigma1 );
    end

    function f2_t = f2( t, A2, omega2, sigma2 )
        f2_t = A2 * sin( omega2.*t + sigma2 );
    end


    function d1_t = df1dt( t, A1, omega1, sigma1 )
        d1_t = A1 * omega1 * cos( omega1.*t + sigma1 );
    end


    function d2_t = df2dt( t, A2, omega2, sigma2 )
        d2_t = A2 * omega2 * cos( omega2.*t + sigma2 );
    end


    function g_t = g( a3, a2, a1 ,a0 )
        g_t = @cubic_f;
        
        function y = cubic_f( x )
            y = a3 * x.^3 + a2 * x.^2 + a1 * x + a0;
        end
    end


[ a3, a2, a1, a0 ] = calc_CubicFuncCoeff_( ts, te, ...
    f1( ts, A1, omega1, sigma1 ), ...
    f2( te, A2, omega2, sigma2 ), ...
    df1dt( ts, A1, omega1, sigma1 ), ...
    df2dt( te, A2, omega2, sigma2 ) );


%disp( strcat( '### ', num2str(a3), ' ### ', num2str(a2), ' ### ', num2str(a1), ' ### ', num2str(a0) ) );

range = [ 0, T ];
%{
firstPlot =  f1( [0, ts], A1, omega1, sigma1 );
secondPlot =  f2( [te, T], A2, omega2, sigma2 );
thirdPlot = g( [ts, te], a3, a2, a1 ,a0 );
%}
%{
firstPlot =  f1_plot( range, A1, omega1, sigma1 );
secondPlot =  f2_plot( range, A2, omega2, sigma2 );
thirdPlot = g( range, a3, a2, a1 ,a0 );
%}
firstPlot =  f1_plot( A1, omega1, sigma1 );
secondPlot =  f2_plot( A2, omega2, sigma2 );
thirdPlot = g( a3, a2, a1 ,a0 );


figure;
hold on
fplot(firstPlot, range, 'b');
fplot(secondPlot, range, 'r' );
fplot(thirdPlot, range, 'g' );
%{
fplot(firstPlot, [0, ts], 'b:')
fplot(secondPlot, [te, T], 'r:' )
fplot(thirdPlot, [ts, te], 'g:' )
%}

axis( [ 0, T, -1, 1 ], 'square' );

hold off;


end
