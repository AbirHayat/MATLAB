% Example 9.4
% Linearization of nonlinear exponential model
clear all
close all
clc

x = [1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.1 2.2];
y = [1.93 1.61 2.27 3.19 3.19 3.71 4.29 4.95 6.07 7.48 8.72 9.34 11.62];

n =length(x);
u = x;
v = log(y);

su = sum(u);
sv = sum(v);
suu = sum(u.*u);
suv = sum(u.*v);

c1 = (n*suv - su*sv)/(n*suu - su^2);
c2 = (sv - c1*su)/n;

a = c1;
b = exp(c2);


sr = sum((y - (b.*exp(a.*x))).^2);
st = sum(y.^2);
R2 = 1-sr/st;

xplot = linspace(min(x),max(x));
yplot = b.*exp(a.*xplot);

figure
hold on
plot(xplot,yplot,'LineWidth',2)
plot(x,y,'ok','MarkerSize',7,'MarkerFaceColor','k')
xlabel('x')
ylabel('y')
xlim([0,2.5])
ylim([0,14])
title('Exponential Model')

disp('Intermediate Values')
fprintf('     sum(xi)    sum(yi)  sum(xi*yi)  sum(xi^2)   Sres       Stot\n');
fprintf('%10.4g %10.4g %10.4g %10.4g %10.4g %10.4g\n',su,sv,suv,suu,sr,st);
disp('--------------------------------------------------------------------------')
disp('Model Parameters')
fprintf('      a         b          R^2\n')
fprintf('%10.6g %10.6g %10.6g\n',a,b,R2)

