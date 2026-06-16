% Example 12.2 pollutant in the lake

clear all
close all
clc

% Set the initial value
x0 = 5;    % ppb

% Define the ODE of the form dc/dt = f(c,t)
f = @(c,t) (100+50.*cos(2*pi()*t/365))/10000*(5.*exp(-2.*t./1000)-c);

% set the time vector (in days)
t = [0:730];

% Solve ODE using explict Euler method
[tout,xout] = explicit_euler(f,t,x0);

% Plot Result
figure
hold on
plot(tout,xout,'LineWidth',2)
xlabel('time (days)')
ylabel('Concentration of Pollutant in the Lake (ppb)')
title('Pollutant in a lake')


