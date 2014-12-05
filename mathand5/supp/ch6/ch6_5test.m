x_true=0:0.1:10;
x_estim=[];
for x=x_true
    y=x^2;
    x_estim=[x_estim,ch6_5(y)];
end
subplot(2,1,1);plot(x_true,x_estim);
xlabel('x_{true}');ylabel('x_{estim}');
subplot(2,1,2);plot(x_true,x_true-x_estim);
xlabel('x_{true}');ylabel('Error');

    