% Example Simpson's 1/3 Rule
clearvars
close all


f = @(x) 2 + 2.*x + x.^2 + sin(2*pi()*x) + cos(2*pi()*x./0.5);
a = 0;
b = 1.5;

n = 3;
h = (b-a)/(2*n);  %2h = (b-a)/n

x1 = [a:h:b];

% Exact Integral
I = integral(f,a,b);
xplot = linspace(a,b);
yactual = f(xplot);

% Numerical Integral
IS1=0;
for i=1:n
    IS1 = IS1+(f(a+(2*i-2)*h) + 4*f(a+(2*i-1)*h) + f(a+(2*i)*h))*h/3;
end
eS1 = I - IS1;

% % For plotting
coeffs = zeros(n,3);
for i = 1:n
    coeffs(i,:) = polyfit(x1(2*(i-1)+1:2*(i-1)+3),f(x1(2*(i-1)+1:2*(i-1)+3)),2);
end

for i=1:length(xplot)
    for j = 1:n
        if xplot(i)<=x1(2*(j-1)+3)             
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
title(['IS1 = ',num2str(IS1)])
hold off