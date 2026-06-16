% Example 12.1 population growth

clear all
close all
clc

% Set the ODE parameters
birth = 0.06;
death = 0.01;
k = birth - death;
x0 = 35;    % Million

% Define the ODE of the form dx/dt = f(x,t)
f = @(x,t) k.*x;        

% Define the exact solution x(t) = x0*exp(k*t)
fexact = @(t) x0.*exp(k.*t);

% set the time vector (in years)
t = [0:1:50];

% Solve ODE using explict Euler method
[tout,xout] = explicit_euler(f,t,x0);

% Calculate true error at each time
Et = zeros(length(tout),1);
for i = 1:length(tout)
    Et(i) = fexact(tout(i))-xout(i);
end

% Plot Result
figure
hold on
fplot(fexact,[min(t),max(t)],'--','LineWidth',2)
plot(tout,xout,'ok','MarkerFaceColor',[0,0,0],'MarkerSize',3)
xlabel('time (years)')
ylabel('Canadian Population (millions)')
title(['Canadian Population Growth with ',num2str(birth*100),'% birth rate'])
legend('Exact',['Euler with h = ',num2str(t(2)-t(1)),],'Location','northwest')

% Display the result as a table
fprintf('\n        t       xi        E\n')
disp('--------------------------------------')
disp([tout,xout,Et])


