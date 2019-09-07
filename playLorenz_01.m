clear;

%[t,xyz] = ode45('lorenz',[0,30],[5;3;1]); % Ver.A
%[t,xyz] = ode45('lorenz',[0,30],[30;3;1]); % Ver.B
%[t,xyz] = ode45('lorenz',[0,30],[100;0;1]); % Ver.C
%[t,xyz] = ode45('lorenz',[0,30],[0;100;1]); % Ver.D
[t,xyz] = ode45('lorenz',[0,30],[5;3;100]); % Ver.E



figure();
plot3(xyz(:,1), xyz(:,2), xyz(:,3));
grid on; hold on;
xlabel('x');
ylabel('y');
zlabel('z');
hold off;


pause( 2.0 );


fs = 44100;

minX = min(xyz(:,1));
minY = min(xyz(:,2));
minZ = min(xyz(:,3));

maxX = max(xyz(:,1));
maxY = max(xyz(:,2));
maxZ = max(xyz(:,3));

Dist = sqrt((maxX-minX)^2 + (maxY-minY)^2 + (maxZ-minZ)^2);

pow = 10; % power number for generated freqs.

%return;


%for i = 1 : length( xyz ),    
for i = 1 : 600,
    fprintf( 'Iteration: %d times\n', i );
    
    if ( 1 ),
        dist = sqrt(xyz(i,1)^2 + xyz(i,2)^2 + xyz(i,3)^2) / Dist;

        %f1base = 440;
        %f2base = 733;
        %f3base = 1100;
        %f1base = 261 * 2;
        %f2base = f1base * 5/4;
        %f3base = f1base * 3/2;                
        f1base = 261 / 2;
        f2base = f1base * 3/2;
        f3base = f1base * 3/1;

        %f1 = 2^log2( dist * 2^10 ) + f1base;
        %f2 = 2^log2( dist * 2^10 ) + f2base;
        %f3 = 2^log2( dist * 2^10 ) + f3base;
        %f1 = max( 0, dist * f1base/2 + f1base );
        %f2 = max( 0, dist * f2base/2 + f2base );
        %f3 = max( 0, dist * f3base/2 + f3base );
        %f1 = max( 0, (xyz(i,1))/20 * f1base/2 + f1base );
        %f2 = max( 0, (xyz(i,2))/30 * f2base/2 + f2base );
        %f3 = max( 0, (xyz(i,3))/60 * f3base/2 + f3base );
        f1 = 2^log2( abs(xyz(i,1))/20 * 2^pow ) + f1base;
        f2 = 2^log2( abs(xyz(i,2))/30 * 2^pow ) + f2base;
        f3 = 2^log2( abs(xyz(i,3))/60 * 2^pow ) + f3base;

        %fprintf( 'Scale: %s (%04.2f Hz)\n', ConvertScaleToString_( ConvertHertzToScale_(f1) ), f1 );
        %fprintf( 'Scale: %s (%04.2f Hz)\n', ConvertScaleToString_( ConvertHertzToScale_(f2) ), f2 );
        %fprintf( 'Scale: %s (%04.2f Hz)\n', ConvertScaleToString_( ConvertHertzToScale_(f3) ), f3 );
        
        timeL = (1 - dist) / 0.2;

        Abase = 0.2;
        Al = xyz(i,1) / 30 * Abase;
        Ar = -Al + Abase;
        Al = Al + Abase;
        
        sL1 = generateSinWave_(Al, f1, fs, timeL, 0 );
        sR1 = generateSinWave_(Ar, f1, fs, timeL, 0 );
        sL2 = generateSinWave_(Al, f2, fs, timeL, 0 );
        sR2 = generateSinWave_(Ar, f2, fs, timeL, 0 );
        sL3 = generateSinWave_(Al, f3, fs, timeL, 0 );
        sR3 = generateSinWave_(Ar, f3, fs, timeL, 0 );

        %sL = sL / max(abs(sL));
        %sR = sR / max(abs(sR));
        sL = ( sL1 + sL2 + sL3 ) / 8;
        sR = ( sR1 + sR2 + sR3 ) / 8;
                
        w = hann( length( sL ) );

        s = [ sL.*w', sR.*w' ];
    end;
    
   
    sound( s, fs );

    %pause( (1 - dist)/4 );
    
   
    pause( 0.05 );


end;
