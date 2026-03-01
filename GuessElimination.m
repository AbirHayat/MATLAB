% Example Input
A = [0, 2, 1; 3, -1, 2; 1, -1, 1];
b = [4; 1; -1];

[n, ~] = size(A);
Aug = [A, b]; % Step 1: Form the augmented matrix

for j = 1:n
    % --- Step 1 & 2: Locate leftmost non-zero and interchange rows ---
    [maxVal, pivot_row] = max(abs(Aug(j:n, j)));
    pivot_row = pivot_row + j - 1;
    
    if maxVal == 0
        continue; % Skip if the entire column is zero
    end
    
    % Swap current row with pivot row
    Aug([j, pivot_row], :) = Aug([pivot_row, j], :);
    
    % --- Step 3: Introduce a leading 1 ---
    % Divide the row by the pivot element 'b'
    pivot_element = Aug(j, j);
    Aug(j, :) = Aug(j, :) / pivot_element;
    
    % --- Step 4: Add multiples to create zeros below the leading 1 ---
    for i = j+1:n
        factor = Aug(i, j);
        Aug(i, :) = Aug(i, :) - factor * Aug(j, :);
    end
    
    % --- Step 5: "Cover" the row and repeat (handled by the 'j' loop) ---
end

% Back substitution to find solution vector x
x = zeros(n, 1);
for i = n:-1:1
    x(i) = Aug(i, end) - Aug(i, i+1:n) * x(i+1:n);
end

disp('Row-Echelon Form:');
disp(Aug);
disp('Solution x:');
disp(x);