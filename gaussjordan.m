function x = gaussjordan(A,b)
% Function to demonstrate the Gauss-Jordan elimination method
% without pivoting
%
% A is nxn matrix of coefficients
% b is nx1 column vector of constants
% x is the solution (nx1 column) to x = A*b
%
% Syntax: x = gaussjordan(A,b)

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

% Initialize the result x
x = zeros(rA,1); % initialize x as a col

% Step 1: Form the combined matrix [A b]
a = [A b];
disp(' ')
disp('Combined Matrix [A|b]')
disp('-----------------------------')
disp(a)
disp(' ')

% Step 2: Forward elimination
disp('-----------------------------')
disp('Forward Elimination')
disp('-----------------------------')
disp(' ')
for k = 1:n
    disp(['Pivot Row ',num2str(k)])
    disp('-----------------------------')
    a(k,:) = a(k,:)/a(k,k);  % normalize the pivot row
    for i = k+1:n
        m = a(i,k)/a(k,k);
        for j = k:n+1            
            a(i,j)=a(i,j)-m*a(k,j); % eliminate elements in the rows below
        end        
    end
    for i = 1:k-1
        m = a(i,k)/a(k,k);
        for j = k:n+1            
            a(i,j)=a(i,j)-m*a(k,j); % eliminate elements in the rows above
        end       
    end
    disp(a)
    disp(' ')   
end

disp('-----------------------------')
disp('Obtain the Result')
disp('-----------------------------')
disp(' ')
x = a(:,n+1);   % obtain x directly as the right hand column
disp(x)
