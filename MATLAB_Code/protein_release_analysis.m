clc;
clear;
close all;

%% =========================================================
% PREDICTIVE MODELLING OF PROTEIN RELEASE FROM MICROSPHERES
% MATLAB Analysis
% ==========================================================

%% 1. EXPERIMENTAL DATA
% Digitized from the published lysozyme release profile

time = [1.08 2.96 6.85 13.96 20.95 27.66 ...
        34.92 41.90 48.89 55.74 62.87 69.86];

release = [21.70 22.40 24.49 30.73 32.43 34.94 ...
           36.71 39.85 41.28 41.67 42.07 42.80];

%% =========================================================
% 2. EXPERIMENTAL RELEASE PROFILE
% ==========================================================

figure('Name','Experimental Release Profile');

plot(time, release, 'ko-', ...
    'MarkerFaceColor','k', ...
    'LineWidth',1.5, ...
    'MarkerSize',6);

xlabel('Time (days)');
ylabel('Cumulative Lysozyme Release (%)');
title('In-vitro Lysozyme Release from Microspheres');

grid on;
box on;

%% =========================================================
% 3. ZERO-ORDER MODEL
% Q = k0*t + Q0
% ==========================================================

p_zero = polyfit(time, release, 1);

k0 = p_zero(1);
Q0_zero = p_zero(2);

release_zero = polyval(p_zero, time);

SSres_zero = sum((release - release_zero).^2);
SStot = sum((release - mean(release)).^2);

R2_zero = 1 - SSres_zero/SStot;
RMSE_zero = sqrt(mean((release - release_zero).^2));

%% =========================================================
% 4. FIRST-ORDER MODEL
% Q = 100 - (100-Q0)*exp(-k1*t)
% ==========================================================

remaining = 100 - release;

p_first = polyfit(time, log(remaining), 1);

k1 = -p_first(1);
Q0_first = 100 - exp(p_first(2));

release_first = ...
    100 - (100-Q0_first).*exp(-k1*time);

SSres_first = sum((release - release_first).^2);

R2_first = 1 - SSres_first/SStot;
RMSE_first = sqrt(mean((release - release_first).^2));

%% =========================================================
% 5. HIGUCHI MODEL
% Q = kH*sqrt(t) + intercept
% ==========================================================

sqrt_time = sqrt(time);

p_H = polyfit(sqrt_time, release, 1);

kH = p_H(1);
Q0_H = p_H(2);

release_H = polyval(p_H, sqrt_time);

SSres_H = sum((release - release_H).^2);

R2_H = 1 - SSres_H/SStot;
RMSE_H = sqrt(mean((release - release_H).^2));

%% =========================================================
% 6. KORSMEYER-PEPPAS MODEL
% Mt/Minf = k*t^n
% ==========================================================

M_inf = 100;

idx = release <= 0.60*M_inf;

t_KP = time(idx);
M_KP = release(idx);

X = log10(t_KP);
Y = log10(M_KP/M_inf);

p_KP = polyfit(X,Y,1);

n = p_KP(1);
k_KP = 10^p_KP(2);

Y_fit = polyval(p_KP,X);

SSres_KP = sum((Y-Y_fit).^2);
SStot_KP = sum((Y-mean(Y)).^2);

R2_KP = 1 - SSres_KP/SStot_KP;

%% =========================================================
% 7. MODEL COMPARISON GRAPH
% ==========================================================

figure('Name','Model Comparison');

plot(time, release_zero, 'r-', ...
    'LineWidth',2);
hold on;

plot(time, release_first, 'b-', ...
    'LineWidth',2);

plot(time, release_H, 'g-', ...
    'LineWidth',2);

plot(time, release, 'ko', ...
    'MarkerFaceColor','k', ...
    'MarkerSize',6);

xlabel('Time (days)');
ylabel('Cumulative Lysozyme Release (%)');

title('Comparison of Drug Release Models');

legend('Zero-order', ...
       'First-order', ...
       'Higuchi', ...
       'Experimental Data', ...
       'Location','southeast');

grid on;
box on;

%% =========================================================
% 8. SMOOTH HIGUCHI PREDICTION
% ==========================================================

time_pred = linspace(1,70,200);

release_pred_H = polyval(p_H,sqrt(time_pred));

figure('Name','Higuchi Prediction');

plot(time_pred,release_pred_H,'g-', ...
    'LineWidth',2);

hold on;

plot(time,release,'ko', ...
    'MarkerFaceColor','k', ...
    'MarkerSize',6);

xlabel('Time (days)');
ylabel('Cumulative Lysozyme Release (%)');

title('Higuchi Model: Experimental vs Predicted Release');

legend('Higuchi Prediction', ...
       'Experimental Data', ...
       'Location','southeast');

grid on;
box on;

%% =========================================================
% 9. FUTURE RELEASE PREDICTIONS
% ==========================================================

future_time = [10 20 30 40 50 60 70];

future_release = polyval(p_H,sqrt(future_time));

Prediction_Table = table( ...
    future_time', ...
    future_release', ...
    'VariableNames', ...
    {'Time_days','Predicted_Release_percent'});

%% =========================================================
% 10. MODEL PERFORMANCE TABLE
% ==========================================================

Model = ["Zero-order";
         "First-order";
         "Higuchi"];

R_squared = [R2_zero;
             R2_first;
             R2_H];

RMSE = [RMSE_zero;
        RMSE_first;
        RMSE_H];

Results = table(Model,R_squared,RMSE);

%% =========================================================
% 11. MODEL PERFORMANCE VISUALIZATION
% ==========================================================

figure('Name','Model Performance');

bar(R_squared);

xticklabels(Model);

ylabel('R^2');
xlabel('Release Model');

title('Goodness-of-Fit Comparison');

ylim([0 1]);

grid on;
box on;

%% =========================================================
% 12. RMSE COMPARISON
% ==========================================================

figure('Name','RMSE Comparison');

bar(RMSE);

xticklabels(Model);

ylabel('RMSE (%)');
xlabel('Release Model');

title('Prediction Error Comparison');

grid on;
box on;

%% =========================================================
% 13. DISPLAY RESULTS
% ==========================================================

disp(' ');
disp('==============================================');
disp(' PROTEIN RELEASE MODEL ANALYSIS');
disp('==============================================');

disp(' ');
disp('MODEL COMPARISON:');
disp(Results);

disp(' ');
disp('HIGUCHI FUTURE PREDICTIONS:');
disp(Prediction_Table);

disp(' ');
disp('MODEL PARAMETERS:');

fprintf('\nZero-order rate constant = %.4f %%/day\n',k0);
fprintf('Zero-order R^2 = %.4f\n',R2_zero);
fprintf('Zero-order RMSE = %.4f %%\n',RMSE_zero);

fprintf('\nFirst-order rate constant = %.4f /day\n',k1);
fprintf('First-order R^2 = %.4f\n',R2_first);
fprintf('First-order RMSE = %.4f %%\n',RMSE_first);

fprintf('\nHiguchi release constant = %.4f %%/sqrt(day)\n',kH);
fprintf('Higuchi R^2 = %.4f\n',R2_H);
fprintf('Higuchi RMSE = %.4f %%\n',RMSE_H);

fprintf('\nKorsmeyer-Peppas exponent n = %.4f\n',n);
fprintf('Korsmeyer-Peppas constant k = %.4f\n',k_KP);
fprintf('Korsmeyer-Peppas R^2 = %.4f\n',R2_KP);

%% =========================================================
% 14. SAVE RESULTS
% ==========================================================

writetable(Results,...
    'Drug_Release_Model_Comparison.xlsx');

writetable(Prediction_Table,...
    'Higuchi_Future_Predictions.xlsx');

disp(' ');
disp('==============================================');
disp(' Analysis completed successfully.');
disp(' Result files have been created.');
disp('==============================================');