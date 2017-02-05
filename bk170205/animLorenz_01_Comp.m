clear;

t = [ 0 : 0.01 : 30 ];

[t01,xyz01] = ode45('lorenz',t,[5;3;1]); % Ver.A
[t02,xyz02] = ode45('lorenz',t,[30;3;1]); % Ver.B
[t03,xyz03] = ode45('lorenz',t,[100;0;1]); % Ver.C
[t04,xyz04] = ode45('lorenz',t,[0;100;1]); % Ver.D
[t05,xyz05] = ode45('lorenz',t,[5;3;100]); % Ver.E

x01 = xyz01(:,1); xmin01 = min(x01); xmax01 = max(x01);
y01 = xyz01(:,2); ymin01 = min(y01); ymax01 = max(y01);
z01 = xyz01(:,3); zmin01 = min(z01); zmax01 = max(z01);

x02 = xyz02(:,1); xmin02 = min(x02); xmax02 = max(x02);
y02 = xyz02(:,2); ymin02 = min(y02); ymax02 = max(y02);
z02 = xyz02(:,3); zmin02 = min(z02); zmax02 = max(z02);

x03 = xyz03(:,1); xmin03 = min(x03); xmax03 = max(x03);
y03 = xyz03(:,2); ymin03 = min(y03); ymax03 = max(y03);
z03 = xyz03(:,3); zmin03 = min(z03); zmax03 = max(z03);

x04 = xyz04(:,1); xmin04 = min(x04); xmax04 = max(x04);
y04 = xyz04(:,2); ymin04 = min(y04); ymax04 = max(y04);
z04 = xyz04(:,3); zmin04 = min(z04); zmax04 = max(z04);

x05 = xyz05(:,1); xmin05 = min(x05); xmax05 = max(x05);
y05 = xyz05(:,2); ymin05 = min(y05); ymax05 = max(y05);
z05 = xyz05(:,3); zmin05 = min(z05); zmax05 = max(z05);

xmin = min([xmin01, xmin02, xmin03, xmin04, xmin05]);
ymin = min([ymin01, ymin02, ymin03, ymin04, ymin05]);
zmin = min([zmin01, zmin02, zmin03, zmin04, zmin05]);

xmax = max([xmax01, xmax02, xmax03, xmax04, xmax05]);
ymax = max([ymax01, ymax02, ymax03, ymax04, ymax05]);
zmax = max([zmax01, zmax02, zmax03, zmax04, zmax05]);


for i = 3001 : length( t01 );
    close all;
    
    hold on;
    
    figNumber = 1;
    
    figure( figNumber );
    
    plot3(x01(1:i),y01(1:i),z01(1:i),'b');
    plot3(x02(1:i),y02(1:i),z02(1:i),'r');
    plot3(x03(1:i),y03(1:i),z03(1:i),'Color',[0,0.5,0]);
    plot3(x04(1:i),y04(1:i),z04(1:i),'m');
    plot3(x05(1:i),y05(1:i),z05(1:i),'Color',[1.0,0.7,0]);

    plot3(x01(i),y01(i),z01(i),'ob');
    plot3(x02(i),y02(i),z02(i),'or');
    plot3(x03(i),y03(i),z03(i),'og');
    plot3(x04(i),y04(i),z04(i),'om');
    plot3(x05(i),y05(i),z05(i),'ok');
    
    axis([xmin xmax ymin ymax zmin zmax]);

    xlabel('x'); ylabel('y'); zlabel('z');
    view( 15, 15 );
    grid on;
    
    hold off;
    
    %return;
    
    pause(0.01);
    
    saveImageName = strcat( 'lorenz-01-Comp.', num2str( i, '%d') );
    fname = strcat( saveImageName, '.png');
    pnameImg = strcat( '_Output Images', '/', 'lorenz-01-Comp' );
    
    if ( exist( pnameImg, 'dir' ) == 0 ),
        mkdir( pnameImg );
    end;
    
    outputGraphFileName = strcat( pnameImg, '/', fname );
    
    saveas( figNumber, strcat( outputGraphFileName ) );
end;
