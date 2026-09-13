clc;
clear;
close all;

%% =========================================================
% CREATE PROJECT DATASET
% Protein Release from Microspheres
% ==========================================================

%% Experimental data

time = [1.08 2.96 6.85 13.96 20.95 27.66 ...
        34.92 41.90 48.89 55.74 62.87 69.86];

release = [21.70 22.40 24.49 30.73 32.43 34.94 ...
           36.71 39.85 41.28 41.67 42.07 42.80];


%% =========================================================
% Calculate Higuchi prediction
% ==========================================================

sqrt_time = sqrt(time);

pH = polyfit(sqrt_time,release,1);

higuchi_prediction = polyval(pH,sqrt_time);


%% =========================================================
% Calculate prediction error
% ==========================================================

prediction_error = release - higuchi_prediction;

absolute_error = abs(prediction_error);


%% =========================================================
% Create structured dataset
% ==========================================================

Data = table( ...
    time', ...
    release', ...
    sqrt_time', ...
    higuchi_prediction', ...
    prediction_error', ...
    absolute_error', ...
    'VariableNames', { ...
    'Time_days', ...
    'Experimental_Release_percent', ...
    'Sqrt_Time', ...
    'Higuchi_Predicted_percent', ...
    'Prediction_Error_percent', ...
    'Absolute_Error_percent'});


%% =========================================================
% Display dataset
% ==========================================================

disp(' ');
disp('==============================================');
disp(' PROJECT DATASET');
disp('==============================================');

disp(Data);


%% =========================================================
% Save CSV
% ==========================================================

writetable(Data,'protein_release_dataset.csv');


%% =========================================================
% Save Excel version
% ==========================================================

writetable(Data,'protein_release_dataset.xlsx');


%% =========================================================
% Plot experimental vs predicted release
% ==========================================================

figure('Name','Experimental vs Predicted Release');

plot(time,release,'ko',...
    'MarkerFaceColor','k',...
    'MarkerSize',7);

hold on;

plot(time,higuchi_prediction,...
    'LineWidth',2);

xlabel('Time (days)');
ylabel('Cumulative Lysozyme Release (%)');

title('Experimental vs Higuchi-Predicted Release');

legend('Experimental Data',...
       'Higuchi Prediction',...
       'Location','southeast');

grid on;
box on;


%% =========================================================
% Save figure
% ==========================================================

exportgraphics(gcf,...
    'Experimental_vs_Higuchi_Prediction.png',...
    'Resolution',300);


disp(' ');
disp('==============================================');
disp(' DATASET CREATED SUCCESSFULLY');
disp('==============================================');

disp('CSV file: protein_release_dataset.csv');
disp('Excel file: protein_release_dataset.xlsx');
disp('Figure: Experimental_vs_Higuchi_Prediction.png');