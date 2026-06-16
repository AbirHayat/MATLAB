function [tout,xout] = explicit_euler(fun,t,x0)
% Function to demonstrate the Explicit Euler method for solution of IVP
% fun: is a function handle describing a first order ODE of the form
%       dx/dt = f(x,t)
% t: is a vector of time points. Assuming even spacing h = t(2)-t(1).
% x0: is the initial condition x(t=0)

xout = zeros(length(t),1);
xout(1)=x0;
h = t(2)-t(1);
tout = zeros(length(t),1);
tout(1)=t(1);

for i=1:length(t)-1
    tout(i+1) = tout(i)+h;
    xout(i+1) = xout(i) + fun(xout(i),tout(i))*h;
end
