function [IACC,wIACC,tIACC]=fun_CCFpara(ccfplotl,ccfplotr,rng,dlt)

% Function of calculation of ccfparameters

ccfplotl=[-1*ccfplotl(:,1) ccfplotl(:,2)];
ccf=cat(1, flipdim(ccfplotl(1:rng,[1 2]),1), ccfplotr(2:rng,[1 2]));       %CCF
ccfw=cat(1, flipdim(ccfplotl(1:rng*2,[1 2]),1), ccfplotr(2:rng*2,[1 2]));  %CCFw

%Calculation for IACC
[IACC,tau0] = max(ccf(:,2));

%Calculation for tau_IACC
tIACC  = ccf(tau0,1);

%Calculation for W_IACC
mns0 = ccfw(1:tau0+rng,:);
mns = flipdim(mns0,1);

if IACC<0
    wIACC=NaN;
else

mns2=[];pls2=[];
for i = 1:length(mns)
    mns2(i,[1 2]) = mns(i,[1 2]);
   if mns(i,2) < (1-dlt)*IACC
      break
   end
end

pls = ccfw(tau0+rng:end,:);
for j=1:length(pls)
    pls2(j,[1 2]) = pls(j,[1 2]);
   if pls(j,2) < (1-dlt)*IACC
      break
   end
end

wpls = interp1(mns2(length(mns2)-1:length(mns2),2),mns2(length(mns2)-1:length(mns2),1),(1-dlt)*IACC,'linear');
wmns = interp1(pls2(length(pls2)-1:length(pls2),2),pls2(length(pls2)-1:length(pls2),1),(1-dlt)*IACC,'linear');
wIACC = abs(wpls-wmns);
end