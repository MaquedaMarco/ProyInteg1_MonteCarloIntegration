function MonteCarlo_GUI
    % Create GUI figure
    fig = uifigure('Name', 'Integración Aproximada por Monte Carlo', ...
        'Position', [100, 100, 500, 400]);

    % Function input
    uilabel(fig, 'Position', [20, 340, 200, 22], 'Text', 'Función a evaluar en x:');
    funcInput = uieditfield(fig, 'text', 'Position', [20, 315, 450, 22]);

    % Range input
    uilabel(fig, 'Position', [20, 280, 200, 22], 'Text', 'Rango [a b]:');
    rangeInput = uieditfield(fig, 'text', 'Position', [20, 255, 450, 22]);

    % Número de Iteraciones (formerly Range 2)
    uilabel(fig, 'Position', [20, 220, 200, 22], 'Text', 'Número de Iteraciones:');
    range2Input = uieditfield(fig, 'text', 'Position', [20, 195, 450, 22]);

    % Output label
    resultLabel = uilabel(fig, 'Position', [20, 130, 450, 40], ...
        'Text', 'El Resultado aparecera aquí.', ...
        'FontSize', 14, 'FontWeight', 'bold', 'WordWrap', 'on');

    % Compute button
    uibutton(fig, 'Text', 'Ejecutar.', ...
        'Position', [200, 70, 100, 30], ...
        'ButtonPushedFcn', @(btn,event) computeArea());

    % ---- Callback Function ----
    function computeArea()
        try
            % Convert string to anonymous function
            expr = funcInput.Value;
            funcStr = ['@(x) ', expr];
            f = str2func(funcStr);

            % Parse range [a b]
            r = str2num(rangeInput.Value); %#ok<ST2NM>

            % Parse iteration count from "Número de Iteraciones"
            iterVal = str2double(range2Input.Value);
            if isnan(iterVal) || iterVal <= 0 || mod(iterVal, 1) ~= 0
                error('Número de Iteraciones debe ser un número entero positivo.');
            end
            it = round(iterVal);

            % Compute area
            area = MonteCarlo_Integration_Aproximation(f, r, it);

            % Display result
            resultLabel.Text = ['Área estimada: ', num2str(area)];
        catch ME
            resultLabel.Text = ['Error: ', ME.message];
        end
    end
end