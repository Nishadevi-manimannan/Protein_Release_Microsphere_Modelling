clc;
clear;
close all;

%% =========================================================
% PREDICTION ERROR ANALYSIS
% Protein Release from Microspheres
% ==========================================================

%% Experimental data

time = [1.08 2.96 6.85 13.96 20.95 27.66 ...
        34.92 41.90 48.89 55.74 62.87 69.86];

release = [21.70 22.40 24.49 30.73 32.43 34.94 ...
           36.71 39.85 41.28 41.67 42.07 42.80];


%% =========================================================
% Higuchi model
% ==========================================================

pH = polyfit(sqrt(time),release,1);

predicted = polyval(pH,sqrt(time));


%% =========================================================
% Calculate errors
% ==========================================================

error = release - predicted;

absolute_error = abs(error);

percentage_error = (absolute_error ./ release) * 100;

MAE = mean(absolute_error);

RMSE = sqrt(mean(error.^2));

MAPE = mean(percentage_error);


%% =========================================================
% Create error table
% ==========================================================

Error_Table = table( ...
    time', ...
    release', ...
    predicted', ...
    error', ...
    absolute_error', ...
    percentage_error', ...
    'VariableNames',{ ...
    'Time_days', ...
    'Experimental_Release_percent', ...
    'Predicted_Release_percent', ...
    'Error_percent', ...
    'Absolute_Error_percent', ...
    'Percentage_Error'});


%% =========================================================
% Display results
% ==========================================================

disp(' ');
disp('==============================================');
disp(' HIGUCHI PREDICTION ERROR ANALYSIS');
disp('==============================================');

disp(Error_Table);

fprintf('\nMean Absolute Error (MAE) = %.4f %%\n',MAE);
fprintf('Root Mean Square Error (RMSE) = %.4f %%\n',RMSE);
fprintf('Mean Absolute Percentage Error (MAPE) = %.2f %%\n',MAPE);


%% =========================================================
% Plot prediction error
% ==========================================================

figure('Name','Prediction Error');

plot(time,error,'ko-',...
    'MarkerFaceColor','k',...
    'LineWidth',1.5,...
    'MarkerSize',6);

yline(0,'--');

xlabel('Time (days)');
ylabel('Prediction Error (%)');

title('Higuchi Model Prediction Error');

grid on;
box on;


%% =========================================================
% Save figure
% ==========================================================

exportgraphics(gcf,...
    'Higuchi_Prediction_Error.png',...
    'Resolution',300);


%% =========================================================
% Save error table
% ==========================================================

writetable(Error_Table,...
    'Higuchi_Prediction_Error.xlsx');


%% =========================================================
% Save summary metrics
% ==========================================================

Error_Summary = table( ...
    MAE,...
    RMSE,...
    MAPE,...
    'VariableNames',{ ...
    'MAE_percent',...
    'RMSE_percent',...
    'MAPE_percent'});

writetable(Error_Summary,...
    'Prediction_Error_Summary.xlsx');


disp(' ');
disp('Files created successfully:');
disp('1. Higuchi_Prediction_Error.png');
disp('2. Higuchi_Prediction_Error.xlsx');
disp('3. Prediction_Error_Summary.xlsx');