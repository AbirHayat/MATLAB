% =========================================================================
% INTERACTIVE LEAST SQUARES CURVE FITTING PROGRAM
% Handles: Linear, Parabolic, and Exponential Fits via User Selection
% =========================================================================

clear all
close all
clc

% -------------------------------------------------------------------------
% STEP 1: USER INPUT DATA
% -------------------------------------------------------------------------
fprintf('====================================================================\n');
fprintf('                    LEAST SQUARES MODEL COUPLER                     \n');
fprintf('====================================================================\n');

% Example data vectors (uncomment or edit as needed for your problems)
x = [10 12 15 23 20];
y = [14 17 23 25 21];

fprintf('Current Dataset:\n');
fprintf('x = [%s]\n', num2str(x));
fprintf('y = [%s]\n\n', num2str(y));

n = length(x);

% -------------------------------------------------------------------------
% STEP 2: INTERACTIVE MENU SELECTION
% -------------------------------------------------------------------------
fprintf('Select the type of equation you want to fit:\n');
disp(' 1) Straight Line  [ y = a*x + b ]');
disp(' 2) Parabola       [ y = a1 + a2*x + a3*x^2 ]');
disp(' 3) Exponential    [ y = a * e^(b*x) ]');
choice = input('\nEnter selection number (1-3): ');

% Set up fine grid plotting points based on your current data boundaries
xplot = linspace(min(x)-2, max(x)+2, 500);
ymodel = zeros(1, n);
yplot = zeros(1, 500);

fprintf('\n====================================================================\n');
fprintf('                           FIT RESULTS                              \n');
fprintf('====================================================================\n');

switch choice
    
    % ---------------------------------------------------------------------
    % CASE 1: STRAIGHT LINE (y = ax + b)
    % ---------------------------------------------------------------------
    case 1
        % Compute summation terms
        sx = sum(x);     sy = sum(y);
        sxx = sum(x.^2); sxy = sum(x.*y);
        
        % Solve normal equations using matrix inverse algebra
        A_mat = [sxx, sx; sx, n];
        B_mat = [sxy; sy];
        coeffs = A_mat \ B_mat;
        
        a = coeffs(1); % Slope
        b = coeffs(2); % Intercept
        
        % Model evaluations
        ymodel = a.*x + b;
        yplot  = a.*xplot + b;
        
        % Print algebraic function
        fprintf('Fitted Straight Line Equation:\n');
        fprintf('y = %.4f * x + (%.4f)\n', a, b);
        
    % ---------------------------------------------------------------------
    % CASE 2: PARABOLA (y = a1 + a2*x + a3*x^2)
    % ---------------------------------------------------------------------
    case 2
        m = 3; % 3 coefficients for quadratic matrix
        A_mat = zeros(m);
        B_mat = zeros(m, 1);
        
        % Local polynomial base definition function: [1; x; x^2]
        f_poly = @(val) [1; val; val^2];
        
        % Setup generalized linear system matrix
        for i = 1:m
            for j = 1:m
                sumf = 0; sumy = 0;
                for k = 1:n
                    fvals = f_poly(x(k));
                    sumf = sumf + fvals(i)*fvals(j);
                    sumy = sumy + y(k)*fvals(i);
                end
                A_mat(i,j) = sumf;
                B_mat(i) = sumy;
            end
        end
        
        % Calculate coefficients matrix
        a_coeff = A_mat \ B_mat;
        
        % Compute model and plot trajectories
        for k = 1:n
            fvals = f_poly(x(k));
            ymodel(k) = sum(a_coeff .* fvals);
        end
        for k = 1:500
            fvals = f_poly(xplot(k));
            yplot(k) = sum(a_coeff .* fvals);
        end
        
        % Print algebraic function
        fprintf('Fitted Parabolic Equation:\n');
        fprintf('y = (%.4f)*x^2 + (%.4f)*x + %.4f \n', a_coeff(3), a_coeff(2), a_coeff(1));

    % ---------------------------------------------------------------------
    % CASE 3: EXPONENTIAL MODEL (y = a * e^(b*x))
    % ---------------------------------------------------------------------
    case 3
        % Linearize data by converting: Y = ln(y)
        % Normal form becomes: Y = ln(a) + b*x -> Y = B + A*x
        Y_log = log(y);
        
        sx = sum(x);     sY = sum(Y_log);
        sxx = sum(x.^2); sxY = sum(x.*Y_log);
        
        A_mat = [sxx, sx; sx, n];
        B_mat = [sxY; sY];
        coeffs = A_mat \ B_mat;
        
        b_param = coeffs(1);          % Power parameter (b)
        a_param = exp(coeffs(2));     % Real constant parameter (a = e^B)
        
        % Model evaluations
        ymodel = a_param .* exp(b_param .* x);
        yplot  = a_param .* exp(b_param .* xplot);
        
        % Print algebraic function
        fprintf('Fitted Exponential Equation:\n');
        fprintf('y = %.4f * exp(%.4f * x)\n', a_param, b_param);
        
    otherwise
        error('Invalid selection! Please run again and select numbers 1, 2, or 3.');
end

% -------------------------------------------------------------------------
% STEP 3: CALCULATE FITMETRIC (R^2 Coefficient)
% -------------------------------------------------------------------------
sr = sum((y - ymodel).^2);
st = sum((y - (1/n).*sum(y)).^2);
R2 = 1 - (sr / st);

fprintf('Goodness of Fit (R^2) = %.5f\n', R2);
fprintf('====================================================================\n');

% -------------------------------------------------------------------------
% STEP 4: PLOT THE CHOSEN CURVE MODEL
% -------------------------------------------------------------------------
figure
hold on
plot(xplot, yplot, 'LineWidth', 2.5, 'Color', [0.4660 0.6740 0.1880])
plot(x, y, 'ok', 'MarkerSize', 8, 'MarkerFaceColor', [0 0 0])

grid on
xlabel('x Data Array')
ylabel('y Data Array')

% Adjust view window automatically to fit data ranges safely
xlim([min(x)-3, max(x)+3])
ylim([min(y)-5, max(y)+5])

titles = {'Linear Least Squares Fit', 'Parabolic Least Squares Fit', 'Exponential Least Squares Fit'};
title(titles{choice})
legend('Regression Curve', 'Raw Textbook Coordinates', 'Location', 'best')