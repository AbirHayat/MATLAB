function falsePosition(f,a,b,maxit,es)
fplot(f,'LineWidth',2)
hold on
xlim([-5,5])
ylim([-20,20])
xlabel('X');
ylabel('f(x)');
title('Root finding Using Bisection Method');
fplot(0,'-k')
xlim([-5,5])
grid on
fa = f(a);
fb=f(b);
if sign(fa) == sign(fb)
    fprintf("\nError : no root or even number of roots in intervals\n");
    return;

end
fprintf("\n#    a    b    xi    f(a)    f(b)    f(xi)    er\n");
count = 0;
er =1;
xi = a;
xold=xi;
erplot=zeros(1,50);
%main loop
while(abs(er)>es&&count<maxit)
    count = count+1;
    xold=xi;
    xi=(a*fb-b*fa)/(fb-fa);%formula
    fxi=f(xi);
    plot(xi,fxi,'o');
    if count>0
        er=abs((xi)-xold)/xi;
    end
    erplot(count)=er;
    fprintf("\n%3g    %10g    %10g     %10g     %10.3g     %10.3g     %10.3g     %10.3g \n",count,a,b,xi,fa,fb,fxi,er);
    product=fa*fxi;
    if product==0
        er =0;
    elseif product<0
        b=xi;
        fb=fxi;
    else
        a=xi;
        fa=fxi;
    end
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