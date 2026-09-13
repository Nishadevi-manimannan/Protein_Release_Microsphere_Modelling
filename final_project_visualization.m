clc;
clear;
close all;

%% =========================================================
% FINAL PROJECT VISUALIZATION
% Predictive Modelling of Protein Release from Microspheres
% ==========================================================

%% Experimental data

time = [1.08 2.96 6.85 13.96 20.95 27.66 ...
        34.92 41.90 48.89 55.74 62.87 69.86];

release = [21.70 22.40 24.49 30.73 32.43 34.94 ...
           36.71 39.85 41.28 41.67 42.07 42.80];


%% =========================================================
% HIGUCHI MODEL
% ==========================================================

sqrt_time = sqrt(time);

pH = polyfit(sqrt_time,release,1);

kH = pH(1);
intercept_H = pH(2);

release_H = polyval(pH,sqrt_time);


%% Calculate R2 and RMSE

SSres = sum((release-release_H).^2);
SStot = sum((release-mean(release)).^2);

R2_H = 1-SSres/SStot;

RMSE_H = sqrt(mean((release-release_H).^2));


%% =========================================================
% SMOOTH HIGUCHI PREDICTION
% ==========================================================

time_pred = linspace(1,70,300);

release_pred = polyval(pH,sqrt(time_pred));


%% =========================================================
% FINAL FIGURE
% ==========================================================

figure('Name','Final Project Visualization',...
       'Position',[100 100 1000 650]);

% Experimental data
plot(time,release,'ko',...
    'MarkerFaceColor','k',...
    'MarkerSize',7);

hold on;

% Higuchi prediction
plot(time_pred,release_pred,...
    'LineWidth',2);

xlabel('Time (days)');
ylabel('Cumulative Lysozyme Release (%)');

title({'Predictive Modelling of Lysozyme Release from Microspheres',...
       'Experimental Data and Higuchi Model'});

legend('Experimental Data',...
       'Higuchi Prediction',...
       'Location','southeast');

grid on;
box on;


%% =========================================================
% ADD MODEL INFORMATION
% ==========================================================

text(5,38,...
    sprintf(['Higuchi Model\n' ...
             'k_H = %.4f %%/sqrt(day)\n' ...
             'R^2 = %.4f\n' ...
             'RMSE = %.4f %%'],...
             kH,R2_H,RMSE_H),...
    'FontSize',11,...
    'BackgroundColor','white');


%% =========================================================
% SAVE HIGH-QUALITY IMAGE
% ==========================================================

exportgraphics(gcf,...
    'Final_Project_Visualization.png',...
    'Resolution',300);


%% =========================================================
% SAVE SUMMARY
% ==========================================================

Summary = table( ...
    kH,...
    intercept_H,...
    R2_H,...
    RMSE_H,...
    'VariableNames',{ ...
    'Higuchi_Release_Constant',...
    'Intercept',...
    'R_squared',...
    'RMSE_percent'});

writetable(Summary,...
    'Final_Model_Summary.xlsx');


%% =========================================================
% DISPLAY RESULTS
% ==========================================================

disp(' ');
disp('==============================================');
disp(' FINAL PROJECT MODEL');
disp('==============================================');

fprintf('\nHiguchi release constant = %.4f %%/sqrt(day)\n',kH);
fprintf('Intercept = %.4f %%\n',intercept_H);
fprintf('R-squared = %.4f\n',R2_H);
fprintf('RMSE = %.4f %%\n',RMSE_H);

disp(' ');
disp('Final visualization saved as:');
disp('Final_Project_Visualization.png');

disp(' ');
disp('Final model summary saved as:');
disp('Final_Model_Summary.xlsx');