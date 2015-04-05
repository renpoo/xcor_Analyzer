X=linspace(0,pi).'; % generate 100 points of data from 0 to pi
Z=[abs(sin(X)),abs(sin(2*X)),abs(sin(3*X))];
Y=[zeros(size(X)),ones(size(X))/2,ones(size(X))];
count=1;
for xx=[10 30 60]
  for yy=[-57.5 -37.5 -17.5]
    subplot(3,3,count);
    count=count+1;
    plot3(X,Y,Z);axis tight
    grid;
    xlabel('X-axis');ylabel('Y-axis');zlabel('Z-axis')
    strtitle=['Az= ',num2str(yy),', El = ',num2str(xx)];
    title(strtitle);view(yy,xx);
  end;
end
set(0,'showhiddenhandles','on');
set(findobj('type','axes'),'fontsize',7);
set(findobj('type','text'),'fontsize',7);
set(0,'showhiddenhandles','off');
