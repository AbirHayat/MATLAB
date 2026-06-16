% Example 9.6
% Nonlinear model fit for yield strength vs plastic strain
% model: sigma = K*eps^n

clear all
close all
clc

x = [0.0001 0.0003 0.0015 0.0025 0.004 0.005 0.015 0.025 0.04 0.05 0.1 0.15 0.2];
y = [204.18 226.4 270.35 276.86 296.86 299.3 334.65 346.56 371.81 377.45 398.01 422.45 434.42];

% Using the MATLAB function nlinfit
init = [100; 0];
[coeffs,R] = nlinfit(x,y,@(a,x) plastic(a,x),init);

sr = sum(R.^2);
st = sum(y.^2);
R2 = 1-sr/st;

disp('--------------------------------------------------------------------------')
disp('Model Parameters')
fprintf('      K        n           R^2\n')
fprintf('%10.6g %10.6g %10.6g\n',coeffs(1),coeffs(2),R2)

xplot = linspace(min(x),max(x));
yplot = coeffs(1).*xplot.^coeffs(2);

figure
hold on
plot(xplot,yplot,'LineWidth',2)
plot(x,y,'ok','MarkerSize',7,'MarkerFaceColor','k')
xlabel('Plastic Strain')
ylabel('Yield Strenth')
xlim([min(x),max(x)])
title('Yield Strength vs Plastic Strain')