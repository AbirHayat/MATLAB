function x = gauss_seidel(A,b,x0)
% Function to demonstrate the Gauss-Seidel method to solve a system Ax=b
%
% A is nxn matrix of coefficients
% b is nx1 column vector of constants
% xo is nx1 column vector of the initial guess
% x is the solution (nx1 column)
%
% Syntax: x = gauss_seidel(A,b,x0)

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

% Prepare U and L matrices
U = zeros(n);

for i=1:n
    for j = i+1:n
        U(i,j)=A(i,j);
    end
end
L = A - U;

% For display only
outmat = zeros(1,n+2);
outmat(1,:) = [count transpose(xnew) er]; 

% main loop
while(er>es && count<maxit)
    count = count + 1;              % increment the counter
    xold = xnew;                    % keep the old estimate
    
    % Calculate the new estimate by forward substitution
    xnew(1) = (b(1) - U(1,:)*xnew)/L(1,1);
    for i = 2:n
        sum = 0;
        for j = 1:i-1
            sum = sum + L(i,j)*xnew(j);
        end
    xnew(i) = (b(i)-U(i,:)*xnew-sum)/L(i,i);
    end
    
    er = norm(xnew-xold)/norm(xnew);    % absolute relative error
    outmat =[outmat; count transpose(xnew) er]; % for display
end

% Display the results
if count<maxit
    disp('Gauss-Seidel Method')
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
    fprintf('\n er = ');
    fprintf('%10.6g\n\n',er);
else
    disp(['Failed to converge in ',num2str(count),' iterations'])
    x = 'NAN';
end
