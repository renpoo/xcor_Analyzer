clear;

%[t,xyz] = ode45('lorenz',[0,30],[5;3;1]); % Ver.A
%[t,xyz] = ode45('lorenz',[0,30],[30;3;1]); % Ver.B
%[t,xyz] = ode45('lorenz',[0,30],[100;0;1]); % Ver.C
%[t,xyz] = ode45('lorenz',[0,30],[0;100;1]); % Ver.D
[t,xyz] = ode45('lorenz',[0,30],[5;3;100]); % Ver.E

x = xyz(:,1); xmin = min(x); xmax = max(x);
y = xyz(:,2); ymin = min(y); ymax = max(y);
z = xyz(:,3); zmin = min(z); zmax = max(z);

for i = 1 : length( t )

    figNumber = 1;
    
    figure( figNumber );
    
    plot3(x(1:i),y(1:i),z(1:i),...
        x(1),y(1),z(1),'or',...
        x(i),y(i),z(i),'ob');
    axis([xmin xmax ymin ymax zmin zmax]);
    xlabel('x'); ylabel('y'); zlabel('z');
    view( 15, 15 );
    grid on;
    
    %return;
    
    pause(0.1);
    
    saveImageName = strcat( 'lorenz-01E.', num2str( i, '%d') );
    fname = strcat( saveImageName, '.png');
    pnameImg = strcat( '_Output Images', '/', 'lorenz-01E' );
    
    if ( exist( pnameImg, 'dir' ) == 0 ),
        mkdir( pnameImg );
    end;
    
    outputGraphFileName = strcat( pnameImg, '/', fname );
    
    saveas( figNumber, strcat( outputGraphFileName ) );
end;
