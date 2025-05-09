function test_MonteCarlo_Integration()
% test_MonteCarlo_Integration
%
% Muestra en consola si cada test ha sido aprobado o fallado, junto con
% el valor esperado, el valor obtenido y el error absoluto.

    tol = 0.02;         % Tolerancia máxima permitida
    iter = 100000;      % Número de simulaciones por test

    % Conjunto de pruebas: {función, intervalo [a, b], valor esperado}
    tests = {
        @(x) x.^2,        [0, 1],      1/3;
        @(x) sin(x),      [0, pi],     2;
        @(x) exp(x),      [0, 1],      exp(1) - 1;
        @(x) x,           [0, 2],      2;
        @(x) x.^3,        [0, 1],      1/4;
        @(x) cos(x),      [0, pi/2],   1;
        @(x) 1./x,        [1, 2],      log(2);
        @(x) sqrt(x),     [0, 1],      2/3;
        @(x) ones(size(x)), [0, 1],    1;
    };

    fprintf('🔍 Iniciando pruebas unitarias para Monte Carlo Integration...\n\n');

    for i = 1:size(tests, 1)
        func = tests{i, 1};
        range = tests{i, 2};
        expected = tests{i, 3};

        try
            result = MonteCarlo_Integration_Aproximation(func, range, iter);
            abs_error = abs(result - expected);
            passed = abs_error < tol;

            fprintf('Test %2d: ', i);
            if passed
                fprintf('✅ Aprobado ');
            else
                fprintf('❌ Fallado   ');
            end
            fprintf('| Esperado = %.5f, Obtenido = %.5f, Error = %.5f\n', ...
                    expected, result, abs_error);
        catch ME
            fprintf('Test %2d: ❌ Error de ejecución: %s\n', i, ME.message);
        end
    end
end