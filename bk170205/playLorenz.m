clear;

[t,xyz] = ode45('lorenz',[0,30],[5;3;1]);



figure();
plot3(xyz(:,1), xyz(:,2), xyz(:,3));
grid on;
pause( 2.0 );


fs = 44000;

minX = min(xyz(:,1));
minY = min(xyz(:,2));
minZ = min(xyz(:,3));

maxX = max(xyz(:,1));
maxY = max(xyz(:,2));
maxZ = max(xyz(:,3));

Dist = sqrt((maxX-minX)^2 + (maxY-minY)^2 + (maxZ-minZ)^2);

%return;


%for i = 1 : length( xyz ),    
for i = 1 : 600,    
    disp( i );
    
    if ( 0 ),
        s = generateSinWave_(xyz(i,3)/maxZ, ...
            max( 0, xyz(i,1) / (maxX - minX) * 10000 + 440 ), ...
            fs, max( 0, xyz(i,2) ), 0 );
    end;

    
    if ( 1 ),
        dist = sqrt(xyz(i,1)^2 + xyz(i,2)^2 + xyz(i,3)^2) / Dist;

        %f1base = 440;
        %f2base = 733;
        %f3base = 1100;
        %f1base = 261 * 2;
        %f2base = f1base * 5/4;
        %f3base = f1base * 3/2;                
        f1base = 261 * 1;
        f2base = f1base * 3/2;
        f3base = f1base * 3/1;

        %f1 = 2^log2( dist ) + f1base;
        %f2 = 2^log2( dist ) + f2base;
        %f3 = 2^log2( dist ) + f3base;
        %f1 = max( 0, dist * f1base/2 + f1base );
        %f2 = max( 0, dist * f2base/2 + f2base );
        %f3 = max( 0, dist * f3base/2 + f3base );
        f1 = max( 0, (xyz(i,1))/20 * f1base/2 + f1base );
        f2 = max( 0, (xyz(i,2))/30 * f2base/2 + f2base );
        f3 = max( 0, (xyz(i,3))/60 * f3base/2 + f3base );

        timeL = (1 - dist) / 0.2;

        Abase = 0.2;
        Al = xyz(i,1) / 30 * Abase;
        Ar = -Al + Abase;
        Al = Al + Abase;
        
        sL1 = generateSinWave_(Al, ...
            f1, ...
            fs, timeL, 0 );

        sR1 = generateSinWave_(Ar, ...
            f1, ...
            fs, timeL, 0 );
        
        sL2 = generateSinWave_(Al, ...
            f2, ...
            fs, timeL, 0 );
        
        sR2 = generateSinWave_(Ar, ...
            f2, ...
            fs, timeL, 0 );

        sL3 = generateSinWave_(Al, ...
            f3, ...
            fs, timeL, 0 );
        
        sR3 = generateSinWave_(Ar, ...
            f3, ...
            fs, timeL, 0 );

        sL = ( sL1 + sL2 + sL3 ) / 8;
        sR = ( sR1 + sR2 + sR3 ) / 8;

        %sL = sL / max(abs(sL));
        %sR = sR / max(abs(sR));
        
        
        w = HanningWindow_( length( sL ) );

        s = [ sL.*w', sR.*w' ];
    end;
    
    
    if ( 0 ),
        s = generateSinWave_(xyz(i,3)/maxZ, ...
            max( 0, ( xyz(i,1) - minX ) / (maxX - minX) / 2.0 * 440 + 440 ), ...
            fs, max( 0, xyz(i,2) ), 0 );
    end;
    
    
    if ( 0 ),
        dist = sqrt(xyz(i,1)^2 + xyz(i,2)^2 + xyz(i,3)^2) / Dist;
        f = 2^log2( dist * 2^12 ) + 440;

        sL = generateSinWave_(xyz(i,1)/30*0.5 + 0.5, ...
            f, ...
            fs, (1 - dist)/4, 0 );
        sR = generateSinWave_(-xyz(i,1)/30*0.5 + 0.5, ...
            f, ...
            fs, (1 - dist)/4, 0 );

        w = HanningWindow_( length( sL ) );

        s = [ sL.*w' , sR.*w' ];
        
        D( i ) = dist;
        F( i ) = f;
    end;
    
    
    if ( 0 ),
        dist = sqrt(xyz(i,1)^2 + xyz(i,2)^2 + xyz(i,3)^2) / Dist;
        f = 2^log2( dist * 2^12 ) + 440;

        sLx = generateSinWave_(xyz(i,1)/30*0.5 + 0.5, ...
            2^log(xyz(i,1)+30)+440, ...
            fs, (1 - dist)/4, 0 );
        sLy = generateSinWave_(xyz(i,1)/30*0.5 + 0.5, ...
            2^log(xyz(i,2)+30)+440, ...
            fs, (1 - dist)/4, 0 );
        sLz = generateSinWave_(xyz(i,1)/30*0.5 + 0.5, ...
            2^log(xyz(i,3))+440, ...
            fs, (1 - dist)/4, 0 );

        sL = sLx + sLy + sLz;
        
        sRx = generateSinWave_(-xyz(i,1)/30*0.5 + 0.5, ...
            2^log(xyz(i,1)+30)+440, ...
            fs, (1 - dist)/4, 0 );
        sRy = generateSinWave_(-xyz(i,1)/30*0.5 + 0.5, ...
            2^log(xyz(i,2)+30)+440, ...
            fs, (1 - dist)/4, 0 );
        sRz = generateSinWave_(-xyz(i,1)/30*0.5 + 0.5, ...
            2^log(xyz(i,3))+440, ...
            fs, (1 - dist)/4, 0 );

        sR = sRx + sRy + sRz;

        w = HanningWindow_( length( sL ) );

        s = [ sL.*w' , sR.*w' ];
        
        D( i ) = dist;
        F( i ) = f;
    end;
    
    
    if ( 0 ),
        dist = sqrt((maxX-minX)^2 + (maxY-minY)^2 + (maxZ-minZ)^2);
        s = generateSinWave_(xyz(i,3)/maxZ, ...
            sqrt(xyz(i,1)^2 + xyz(i,2)^2 + xyz(i,3)^2) / dist * 2000, ...
            fs, max( 0, xyz(i,2) ), 0 );
    end;
    
    
    %w = HanningWindow_( length( s ) );
    
    %pause( (1 - dist)/4 );
    pause( 0.05 );
    sound( s, fs );


    %sound( s, fs );
    %pause( xyz(i,2) );
end;
