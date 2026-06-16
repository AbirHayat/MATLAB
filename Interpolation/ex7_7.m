% Example 7.7 - 7.10
% Lagrange Interpolating Polynomials

clear all
close all
clc

xp = [0 2 3 6];
yp = [648 704 729 792];

% First two points
n=1;
xplot = linspace(0,4);
yplot = 0;
for i=1:n+1
    product = 1;
    for j = 1:n+1
        if j~=i
            product = product.*(xplot-xp(j))/(xp(i)-xp(j));
        end
    end
    yplot = yplot + yp(i).*product;
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
    for j = 1:n+1
        if j~=i
            product = product.*(xplot-xp(j))/(xp(i)-xp(j));
        end
    end
    yplot = yplot + yp(i).*product;
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
    for j = 1:n+1
        if j~=i
            product = product.*(xplot-xp(j))/(xp(i)-xp(j));
        end
    end
    yplot = yplot + yp(i).*product;
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
% n=4;
% yplot = 0;
% for i=1:n+1
%     product = 1;
%     for j = 1:n+1
%         if j~=i
%             product = product.*(xplot-xp(j))/(xp(i)-xp(j));
%         end
%     end
%     yplot = yplot + yp(i).*product;
% end


% --- Display the Lagrange Polynomial in CMD ---
syms x
P_x = 0; % Initialize polynomial sum
n_points = length(xp);

for i = 1:n_points
    basis = 1;
    for j = 1:n_points
        if j ~= i
            basis = basis * (x - xp(j)) / (xp(i) - xp(j));
        end
    end
    P_x = P_x + yp(i) * basis;
end

fprintf('\n==================================================\n');
fprintf('Lagrange Interpolating Polynomial (Simplified):\n');
disp(simplify(P_x))
fprintf('==================================================\n');

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
