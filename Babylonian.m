function x = Babylonian(S, es, x,max_iter)
    % Find the square root of a number S using the Babylonian method
    if S < 0
        error('Cannot compute the square root of a negative number using this method.');
    elseif S == 0
        x = 0;
        return;
    end
    
    % Initial guess
    %x = 1; 
    fprintf('Iter\tApproximate Value\tAbsolute Error\n');
    fprintf('----\t-----------------\t--------------\n');
    
    for iter = 1:max_iter
        x_old = x;
        x = 0.5 * (x_old + S / x_old);
        err = abs((x)-x_old)/x;
        
        fprintf('%d\t\t%f\t\t%e\n', iter, x, err);
        
        if err < es
            fprintf('Convergence achieved after %d iterations.\n', iter);
            return;
        end
    end
    warning('Maximum iterations reached without full convergence to tolerance.');%Babylonian(23.47,0.001,1,20)
end