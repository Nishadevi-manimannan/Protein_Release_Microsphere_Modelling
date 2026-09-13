clc;
clear;
close all;

%% =========================================================
% RELEASE RATE ANALYSIS OF LYsozyme FROM MICROSPHERES
% ==========================================================

%% Experimental data

time = [1.08 2.96 6.85 13.96 20.95 27.66 ...
    34.92 41.90 48.89 55.74 62.87 69.86];

release = [21.70 22.40 24.49 30.73 32.43 34.94 ...
    36.71 39.85 41.28 41.67 42.07 42.80];


%% Calculate release rate

delta_release = diff(release);
delta_time = diff(time);

release_rate = delta_release ./ delta_time;

% Midpoint time for each interval
time_mid = (time(1:end-1) + time(2:end)) / 2;


%% Display release-rate table

Rate_Table = table( ...
    time_mid', ...
    release_rate', ...
    'VariableNames', ...
    {'Time_midpoint_days','Release_Rate_percent_per_day'});

disp(' ');
disp('==============================================');
disp(' RELEASE RATE ANALYSIS');
disp('==============================================');

disp(Rate_Table);


%% Plot release rate

figure('Name','Release Rate Analysis');

plot(time_mid, release_rate, 'ko-', ...
    'MarkerFaceColor','k', ...
    'LineWidth',1.5, ...
    'MarkerSize',6);

xlabel('Time (days)');
ylabel('Release Rate (%/day)');

title('Lysozyme Release Rate vs. Time');

grid on;
box on;


%% Save results

writetable(Rate_Table,...
    'Lysozyme_Release_Rate.xlsx');

% Save figure as PNG
exportgraphics(gcf,...
    'Lysozyme_Release_Rate.png',...
    'Resolution',300);


disp(' ');
disp('Release-rate table saved.');
disp('Release-rate figure saved as PNG.');