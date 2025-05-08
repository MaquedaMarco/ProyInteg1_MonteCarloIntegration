function area = MonteCarlo_Integration_Aproximation(func, range, iter)
    % Monte Carlo Integration Approximation Function
    %
    % Inputs:
    %   func:  anonymous function.
    %   range: 1x2 vector [a, b] with a < b.
    %   iter:  number of iterations.
    %
    % Output:
    %   area:  float number of the estimated area under the curve
    %          calculated using the Monte Carlo method.

    % ---- Parameter Integrity Check ----

    % Check if 'func' is an anonymous function.
    if ~isa(func, 'function_handle')
        error('The first input must be a function handle, e.g., @(x) x.^2');
    end

    % Check if 'range' is a 1x2 vector of real numbers in ascending order.
    if ~isvector(range) || length(range) ~= 2 || ~isreal(range)
        error('Range must be a vector of two real numbers: [a, b]');
    end
    a = range(1);
    b = range(2);
    if a >= b
        error('Range must be in ascending order: a < b');
    end

    % Check if 'iter' is a natural number.
    if ~isnumeric(iter) || ~isscalar(iter) || iter <= 0 || mod(iter, 1) ~= 0
        error('Iteration count must be a natural number');
    end

    % ---- Monte Carlo Approximation ----

    % Generate 'iter' random x values between a and b
    x = a + (b - a) * rand(1, iter);

    % Estimate max y-value of func in [a, b]
    sampleX = linspace(a, b, 1000);
    yVals = arrayfun(func, sampleX);
    ymax = max(yVals);

    % Generate 'iter' random y values between 0 and ymax
    y = ymax * rand(1, iter);

    % Count how many (x, y) points are below the curve
    underCurve = y < func(x);

    % Area of the bounding rectangle
    rectangleArea = (b - a) * ymax;

    % Monte Carlo area estimation
    area = rectangleArea * sum(underCurve) / iter;
end