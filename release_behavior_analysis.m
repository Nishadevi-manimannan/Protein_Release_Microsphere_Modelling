clc;
clear;
close all;

%% =========================================================
% RELEASE BEHAVIOR ANALYSIS
% Lysozyme Release from Microspheres
% ==========================================================

%% Experimental data

time = [1.08 2.96 6.85 13.96 20.95 27.66 ...
        34.92 41.90 48.89 55.74 62.87 69.86];

release = [21.70 22.40 24.49 30.73 32.43 34.94 ...
           36.71 39.85 41.28 41.67 42.07 42.80];


%% =========================================================
% Calculate release increments
% ==========================================================

release_change = diff(release);


%% =========================================================
% Create smooth curve for visualization
% ==========================================================

time_smooth = linspace(min(time),max(time),300);

release_smooth = interp1(time,release,time_smooth,'pchip');


%% =========================================================
% Plot release behavior
% ==========================================================

figure('Name','Release Behavior Analysis');

plot(time_smooth,release_smooth,'k-',...
    'LineWidth',2);

hold on;

plot(time,release,'ko',...
    'MarkerFaceColor','k',...
    'MarkerSize',6);


xlabel('Time (days)');
ylabel('Cumulative Lysozyme Release (%)');

title('Release Behavior of Lysozyme from Microspheres');

grid on;
box on;


%% =========================================================
% Add important release regions
% ==========================================================

xline(3,'--','Initial Burst Region',...
    'LabelVerticalAlignment','middle');

xline(35,'--','Sustained Release Region',...
    'LabelVerticalAlignment','middle');

xline(55,'--','Plateau Region',...
    'LabelVerticalAlignment','middle');


%% =========================================================
% Display key observations
% ==========================================================

initial_release = release(1);

final_release = release(end);

additional_release = final_release-initial_release;

fprintf('\n==============================================\n');
fprintf(' RELEASE BEHAVIOR ANALYSIS\n');
fprintf('==============================================\n');

fprintf('\nInitial measured release = %.2f %%\n',...
    initial_release);

fprintf('Final measured release = %.2f %%\n',...
    final_release);

fprintf('Additional release after initial point = %.2f %%\n',...
    additional_release);

fprintf('\nThe release profile shows an initial burst\n');
fprintf('followed by slower sustained release and\n');
fprintf('a late-stage plateau.\n');


%% =========================================================
% Save figure
% ==========================================================

exportgraphics(gcf,...
    'Release_Behavior_Analysis.png',...
    'Resolution',300);


disp(' ');
disp('Release behavior figure saved successfully.');