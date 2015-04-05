data=sin(-1:0.1:2);
xjiku=1;
yjiku=data(xjiku);
for i=2:length(data)
	if data(i)>yjiku
		xjiku=i;
		yjiku=data(xjiku);
	end
end
[yjiku xjiku]
