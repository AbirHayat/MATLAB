% Example Simpson's 3/8 Rule
clearvars
close all

f = @(x) 2 + 2.*x + x.^2 + sin(2*pi()*x) + cos(2*pi()*x./0.5);
a = 0;
b = 1.5;

n = 3;
h = (b-a)/(3*n);  %3h = (b-a)/n

x1 = [a:h:b];

% Exact Integral
I = integral(f,a,b);
xplot = linspace(a,b);
yactual = f(xplot);

% Numerical Integral
IS2=0;
for i=1:n
    IS2 = IS2+(f(a+(3*i-3)*h) + 3*f(a+(3*i-2)*h) + 3*f(a+(3*i-1)*h) + f(a+(3*i)*h))*3*h/8;
end
eS2 = I - IS2;

% % For plotting
coeffs = zeros(n,4);
for i = 1:n
    coeffs(i,:) = polyfit(x1(3*(i-1)+1:3*(i-1)+4),f(x1(3*(i-1)+1:3*(i-1)+4)),3);
end

for i=1:length(xplot)
    for j = 1:n
        if xplot(i)<=x1(3*(j-1)+4)             
            y1(i)=polyval(coeffs(j,:),xplot(i));
            break
        end
    end
end




% Plotting
figure
plot(xplot,yactual,'LineWidth',2)
hold on
area(xplot,y1,'EdgeColor',[0.8500, 0.3250, 0.0980],'FaceAlpha',0.2)
plot(x1,f(x1),'ok','MarkerSize',7,'MarkerFaceColor','k')
xlabel('x')
ylabel('y')
title(['IS2 = ',num2str(IS2)])
hold off