function check_prime(n)
    % Checks if a given integer n is a prime number
    if n <= 1
        prime = false;
        fprintf('%d is not a prime number.\n', n);
        return;
    end
    
    prime = true;
    limit = floor(sqrt(n));
    
    for i = 2:limit
        if rem(n, i) == 0
            prime = false;
            break;
        end
    end
    
    if prime
        fprintf('%d is a prime number.\n', n);
    else
        fprintf('%d is a composite number.\n', n);
    end
end