% Example 9.2
% Generalized least squares
% model: y(x) = a1 + a2*x + a3*cos(pi*x)

clear all
close all
clc

x = [10 12 15 23 20];
y = [14 17 23 25 21];
n = length(x);
m = 3; 

A = zeros(m);
b = zeros(m,1);

% Set up the linear system of equations
for i = 1:m
    for j = 1:m
        sumf = 0;
        sumy = 0;
        for k = 1:n
            fvals = f(x(k));
            sumf = sumf + fvals(i)*fvals(j);
            sumy = sumy + y(k)*fvals(i);
        end
        A(i,j) = sumf;
        b(i) = sumy;
    end
end

% Display the resulting system
disp('A:')
disp(A)
disp('b:')
disp(b)

% Calculate the coefficients
a = A\b;

% Calculate R^2
tmp = a.*f(x);      % returns a matrix where column i is {a1*f1(xi), a2*f1(xi), a3*f1(xi)...]
ymodel = sum(tmp);  % sums the elements in each column to give the model prediction of y(xi)

sr = sum((y - (ymodel)).^2);
st = sum((y - (1/n).*(sum(y))).^2);
R2 = 1-sr/st;

disp('--------------------------------------------------------------------------')
disp('Model Parameters')
fprintf('      a1        a2         a3         R^2\n')
fprintf('%10.6g %10.6g %10.6g %10.6g\n',a(1),a(2),a(3),R2)


xplot = linspace(1,7);
tmp = a.*f(xplot);      % returns a matrix where column i is {a1*f1(xi), a2*f1(xi), a3*f1(xi)...]
yplot = sum(tmp);

figure
hold on
plot(xplot,yplot,'LineWidth',2)
plot(x,y,'ok','MarkerSize',7,'MarkerFaceColor','k')
xlabel('x')
ylabel('y')
xlim([0,8])
ylim([0,8])
title('Model: y = a1 + a2*x + a3*cos(pi*x)')