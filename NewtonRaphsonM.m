function NewtonRaphsonM(f,fp,x0,maxit,es)
fplot(f,'LineWidth',2)
hold on
xlim([-5,5])
ylim([-20,20])
xlabel('X');
ylabel('f(x)');
title('Root finding Using Newton Raphson Method');
fplot(0,'-k')
xlim([-5,5])
grid on
%fprintf("\n#    xi    f(xi)    er\n");
fprintf('\n%4s  %12s  %12s  %12s  %12s  %12s  %12s  %12s\n', ...
        '#','a','b','xi','f(a)','f(b)','f(xi)','er');

fprintf('--------------------------------------------------------------------------------------------\n');

count = 0;
er=1;
xi=x0;
xold=xi;
erplot= zeros(1,maxit);

while(abs(er)>es&&count<maxit)
    count = count +1;
    xold=xi;
    xi=xold-(f(xold)/fp(xold));
    fxi = f(xi);
    plot(xi,fxi,'o');
    %add
    % Draw a dashed line from the curve down to the new xi on the x-axis
    line([xold, xi], [f(xold), 0], 'Color', 'r', 'LineStyle', '--');
    
    if count>0
        er=abs((xi)-xold)/xi;
    end
    erplot(count)=er;
   % fprintf("\n%3g    %10g     %10.3g     %10.3g \n",count,xi,fxi,er);

    fprintf('%4d  %12.6f  %12.6f  %12.6f  %12.3e  %12.3e  %12.3e  %12.3e\n', ...
        count,a,b,xi,fa,fb,fxi,er);
end
%final root
fprintf("\nRoot found at x=%10.6g\n",xi);
hold off;
%figure2
figure;
hold on;
fplot(0,'-k')
xlim([0,count])
plot(erplot(1:count),'LineWidth',2)
title('Relative Error')
xlabel('Iteration Number')
ylabel('relative error')
grid on
hold off;
end
