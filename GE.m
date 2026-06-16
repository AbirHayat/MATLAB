function X = GE(A,b)
[rA,cA]=size(A);
[rB,cB]=size(b);
if rA~=cA
    disp('Error: A is not Square Matrix')
    return
else
    n=rA;
end
if cB~=1
    disp('Error: b is not Column vector')
    return
end
if cA~=rB
    disp('Dimensions of A and b are not coompitable')
end
dA = det(A)
if dA == 0
   disp('A has not any Unique Solution')
   return 
end
X = zeros(n,1);
a= [A,b];
disp('Display The augmented matrix')
disp(a)
%forward Elimination
disp('--------------------------------------------')
disp("Forward Elimination")
disp('--------------------------------------------')
for k=1:n-1
    disp('--------------------------------------------')
    disp(['Pivot row',num2str(k)])

    for i = k+1:n
        m = a(i,k)/a(k,k);
        for j = k:n+1
            a(i,j)=a(i,j)-m*a(k,j);
        end

    end
disp(a)
disp(' ')
end
%Backward Substitution
disp('--------------------------------------------')
disp('Backward Substituion')
disp('--------------------------------------------')
for i=n:-1:1
    sum=0;
    for j = i+1:n
        sum = sum+a(i,j)*X(j);
    end
    X(i)=(a(i,n+1)-sum)/a(i,i);
end
disp(X)
disp(' ')
end