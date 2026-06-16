function x = jacobi(A,b,x0)
% Function to demonstrate the Jacobi method to solve a system Ax=b
%
% A is nxn matrix of coefficients
% b is nx1 column vector of constants
% xo is nx1 column vector of the initial guess
% x is the solution (nx1 column)
%
% Syntax: x = jacobi(A,b,x0)

clc

[rA,cA] = size(A);  % Determine the size of A
[rb,cb] = size(b);  % Determine the size of b

% Input checks
if rA ~= cA
    disp('Error: A is not a square matrix')
    return
else
    n = rA;
end
if cb ~= 1
    disp('Error: b is not a column vector')
    return
end
if cA ~= rb
    disp('Error: Matrix and vector dimensions are not compatible')
    return
end
dA = det(A);
if dA == 0
    disp('Error: Matrix is singular')
    return
end

% Initialize the variables
maxit = 100;
es = 0.0001;
er = 1;
xnew = x0; 
count = 0;

% Prepare R and D-inverse matrices
R = A;
Dinv = zeros(n);
for i=1:n
    R(i,i)=0;
    Dinv(i,i)=1/A(i,i);
end

% For display only
outmat = zeros(1,n+2);
outmat(1,:) = [count transpose(xnew) er]; 

% main loop
while(er>es && count<maxit)
    count = count + 1;          % Increment the counter
    xold = xnew;                % keep the old estimate
    xnew = Dinv*(b - R*xold);   % update the new estimate
    er = norm(xnew-xold)/norm(xnew);    % approximate relative error
    outmat =[outmat; count transpose(xnew) er]; % For display
end

% Display the results
if count<maxit
    disp('Jacobi Method')
    disp('-------------------------------------------------')
    disp('Output format:')
    disp('First column = iteration number')
    disp('Next columns = estimates of the components of x')
    disp('Last column = er')
    disp(' ')
    disp(outmat);
    disp(' ');
    x = xnew;
    disp(['In ',num2str(count),' iterations, x was found to be: '])
    disp(x);
    disp(' ');
else
    disp(['Failed to converge in ',num2str(count),' iterations'])
    x = NAN;
end

