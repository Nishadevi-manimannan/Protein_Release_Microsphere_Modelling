clc;
clear;
close all;

%% =========================================================
% MODEL PERFORMANCE VISUALIZATION
% Protein Release from Microspheres
% ==========================================================

%% Model results obtained from the analysis

Model = categorical({'Zero-order','First-order','Higuchi'});

R2 = [0.9175 0.9382 0.9822];

RMSE = [2.1715 1.8792 1.0071];


%% =========================================================
% 1. R-SQUARED COMPARISON
% ==========================================================

figure('Name','R-squared Model Comparison');

bar(Model,R2);

ylabel('R^2');
xlabel('Release Model');

title('Model Goodness-of-Fit Comparison');

ylim([0 1]);

grid on;
box on;


% Add numerical values above bars

for i = 1:length(R2)
    text(i,R2(i)+0.02,...
        sprintf('%.4f',R2(i)),...
        'HorizontalAlignment','center',...
        'FontWeight','bold');
end


%% =========================================================
% 2. RMSE COMPARISON
% ==========================================================

figure('Name','RMSE Model Comparison');

bar(Model,RMSE);

ylabel('RMSE (%)');
xlabel('Release Model');

title('Model Prediction Error Comparison');

grid on;
box on;


% Add numerical values above bars

for i = 1:length(RMSE)
    text(i,RMSE(i)+0.05,...
        sprintf('%.4f',RMSE(i)),...
        'HorizontalAlignment','center',...
        'FontWeight','bold');
end


%% =========================================================
% 3. SAVE RESULTS
% ==========================================================

Performance_Table = table( ...
    Model', ...
    R2', ...
    RMSE', ...
    'VariableNames', ...
    {'Model','R_squared','RMSE_percent'});

writetable(Performance_Table,...
    'Model_Performance.xlsx');


%% =========================================================
% 4. SAVE FIGURES
% ==========================================================

figures = findobj('Type','figure');

for i = 1:length(figures)

    figure(figures(i));

    if i == 1
        exportgraphics(figures(i),...
            'R_squared_Comparison.png',...
            'Resolution',300);
    else
        exportgraphics(figures(i),...
            'RMSE_Comparison.png',...
            'Resolution',300);
    end

end


%% =========================================================
% FINAL MESSAGE
% ==========================================================

disp(' ');
disp('==============================================');
disp(' MODEL PERFORMANCE ANALYSIS COMPLETED');
disp('==============================================');

disp(Performance_Table);

disp(' ');
disp('Files created:');
disp('1. Model_Performance.xlsx');
disp('2. R_squared_Comparison.png');
disp('3. RMSE_Comparison.png');