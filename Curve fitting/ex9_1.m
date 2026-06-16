% Example 9.1
% Linear curve fit
clear all
close all
clc

x = [10 12 15 23 20];
y = [14 17 23 25 21];

n =length(x);
sx = sum(x);
sy = sum(y);
sxx = sum(x.*x);
sxy = sum(x.*y);

a = (n*sxy - sx*sy)/(n*sxx - sx^2);
b = (sy - a*sx)/n;

sr = sum((y - (a.*x+b)).^2);
st = sum((y - (1/n).*(sum(y))).^2);
R2 = 1-sr/st;

xplot = linspace(1,7);
yplot = a.*xplot+b;

figure
hold on
plot(x,y,'ok','MarkerSize',7,'MarkerFaceColor','k')
plot(xplot,yplot,'LineWidth',2)
xlabel('x')
ylabel('y')
xlim([0,8])
ylim([0,8])
title('Linear Model Fit')

disp('Intermediate Values')
fprintf('      sum(xi)    sum(yi)  sum(xi*yi)  sum(xi^2)   Sres       Stot\n');
fprintf('%10.4g %10.4g %10.4g %10.4g %10.4g %10.4g\n',sx,sy,sxy,sxx,sr,st);
disp('--------------------------------------------------------------------------')
disp('Model Parameters')
fprintf('      a         b          R^2\n')
fprintf('%10.6g %10.6g %10.6g\n',a,b,R2)
