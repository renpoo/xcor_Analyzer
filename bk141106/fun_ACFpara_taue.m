function [f0peaks,taue,reg]=fun_ACFpara_taue(lacfplot,Fs,tau1m)

% Take peaks at n*tau1_dash

last=round(length(lacfplot(:,2))/(tau1m*Fs/1000));
f0peaks=zeros(last,2);
for n=1:last-1
    f0range=lacfplot(floor((Fs/1000)*((n-0.49)*tau1m):(Fs/1000)*((n+0.49)*tau1m)),[1 2]);
    [f0phi,c] = max(f0range(:,2));
    f0tau = f0range(c,1);
    f0peaks(n,[1 2])=[f0tau f0phi];
    if f0phi<-5, break,                 % Threshold: Calc will be stopped
%    if f0phi<-5, break,                 % Definition
    end
end

% Calculation of taue
dl = nnz(f0peaks(:,2));
f0peaks = f0peaks(1:dl-1,:);

reg = polyfit(f0peaks(:,1),f0peaks(:,2),1);
taue  = (-10-reg(1,2))/reg(1,1);   % in [ms]