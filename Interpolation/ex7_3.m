% Example 7.3 - 7.6
% Newton's Interpolating Polynomials

%clear all
%close all
%clc

xp = [-4 -1 0 2 5];
yp = [1245 33 5 9 1335];

for i=1:length(xp)
    b(i)=ddiff(xp(1:i),yp(1:i));
end

% First two points
n=1;
xplot = linspace(0,4);
yplot = 0;
for i=1:n+1
    product = 1;
    for j = 1:i-1
        product = product.*(xplot-xp(j));
    end
    yplot = yplot + b(i).*product;
end


figure
hold on
plot(xplot,yplot,'LineWidth',2)
plot(xp(1:n+1),yp(1:n+1),'ok','MarkerSize',7,'MarkerFaceColor','k')
xlim([0,4])
ylim([-20,20])
fplot(0,'-k',xlim)
xlabel('x')
ylabel('y')
title('Two Points')


% First three points
n=2;
yplot = 0;
for i=1:n+1
    product = 1;
    for j = 1:i-1
        product = product.*(xplot-xp(j));
    end
    yplot = yplot + b(i).*product;
end

figure
hold on
plot(xplot,yplot,'LineWidth',2)
plot(xp(1:n+1),yp(1:n+1),'ok','MarkerSize',7,'MarkerFaceColor','k')
xlim([0,4])
ylim([-20,20])
fplot(0,'-k',xlim)
xlabel('x')
ylabel('y')
title('Three Points')


% First four points
n=3;
yplot = 0;
for i=1:n+1
    product = 1;
    for j = 1:i-1
        product = product.*(xplot-xp(j));
    end
    yplot = yplot + b(i).*product;
end

figure
hold on
plot(xplot,yplot,'LineWidth',2)
plot(xp(1:n+1),yp(1:n+1),'ok','MarkerSize',7,'MarkerFaceColor','k')
xlim([0,4])
ylim([-20,20])
fplot(0,'-k',xlim)
xlabel('x')
ylabel('y')
title('Four Points')


% Five points
n=4;
yplot = 0;
for i=1:n+1
    product = 1;
    for j = 1:i-1
        product = product.*(xplot-xp(j));
    end
    yplot = yplot + b(i).*product;
end

%------
% --- Display Polynomial in Command Window (Symbolic Method) ---
syms x
P_x = b(1); % Start with b0

for i = 2:length(xp)
    term = b(i);
    for j = 1:i-1
        term = term * (x - xp(j));
    end
    P_x = P_x + term;
end

fprintf('\n==================================================\n');
fprintf('Newton Interpolating Polynomial (Bracket Form):\n');
disp(P_x)

fprintf('\nSimplified Polynomial Equation:\n');
disp(simplify(P_x))
fprintf('==================================================\n');




%------

figure
hold on
plot(xplot,yplot,'LineWidth',2)
plot(xp(1:n+1),yp(1:n+1),'ok','MarkerSize',7,'MarkerFaceColor','k')
xlim([0,4])
ylim([-20,20])
fplot(0,'-k',xlim)
xlabel('x')
ylabel('y')
title('Five Points')