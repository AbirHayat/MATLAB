% Example Trapezoidal Rule
clearvars
close all


f = @(x) 2 + 2.*x + x.^2 + sin(2*pi()*x) + cos(2*pi()*x./0.5);
a = 0;
b = 1.5;

n = 7;
h = (b-a)/n;

x1 = [a:h:b];
y1 = f(x1);

% Exact Integral
I = integral(f,a,b);
xplot = linspace(a,b);
yactual = f(xplot);

% Numerical Integral
IT=0;
for i=1:n
    IT = IT+(f(a+(i-1)*h) + f(a+i*h))*h/2;
end
eT = I - IT;

% Plotting
figure
plot(xplot,yactual,'LineWidth',2)
hold on
area(x1,y1,'EdgeColor',[0.8500, 0.3250, 0.0980],'FaceAlpha',0.2)
plot(x1,y1,'ok','MarkerSize',7,'MarkerFaceColor','k')
xlabel('x')
ylabel('y')
title(['IT = ',num2str(IT)])
hold off