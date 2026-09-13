clc;
clear;
close all;

%% Experimental release data
time = [1.08 2.96 6.85 13.96 20.95 27.66 ...
        34.92 41.90 48.89 55.74 62.87 69.86];

release = [21.70 22.40 24.49 30.73 32.43 34.94 ...
           36.71 39.85 41.28 41.67 42.07 42.80];

%% Create figure
fig = figure('Color','w','Position',[100 100 1000 650]);

%% Create PLGA microsphere
[X,Y,Z] = sphere(50);

R = 2.5;

surf(R*X,R*Y,R*Z, ...
    'FaceAlpha',0.18, ...
    'EdgeColor','none');

hold on;
axis equal;
grid on;

xlabel('X');
ylabel('Y');
zlabel('Z');

view(35,25);

%% Create protein particles inside the microsphere
rng(10);

N = 60;

theta = 2*pi*rand(N,1);
phi = acos(2*rand(N,1)-1);

r = R*0.75*rand(N,1);

x = r.*sin(phi).*cos(theta);
y = r.*sin(phi).*sin(theta);
z = r.*cos(phi);

insideParticles = scatter3(x,y,z,35,'filled');

%% Create particles that will be released
Nrelease = 20;

theta = 2*pi*rand(Nrelease,1);
phi = acos(2*rand(Nrelease,1)-1);

% Starting positions near microsphere surface
rStart = R*0.7;

xs = rStart.*sin(phi).*cos(theta);
ys = rStart.*sin(phi).*sin(theta);
zs = rStart.*cos(phi);

% Final positions outside microsphere
rEnd = R + 2.5;

xe = rEnd.*sin(phi).*cos(theta);
ye = rEnd.*sin(phi).*sin(theta);
ze = rEnd.*cos(phi);

releaseParticles = scatter3( ...
    xs,ys,zs,45,'filled');

%% Information text
info = annotation('textbox',[0.35 0.90 0.30 0.06], ...
    'String','', ...
    'EdgeColor','none', ...
    'HorizontalAlignment','center', ...
    'FontSize',14, ...
    'FontWeight','bold');

%% Animation

framesPerPoint = 15;

for k = 1:length(time)-1

    % Current release percentage
    currentRelease = release(k);

    % Fraction of particles released
    fraction = currentRelease/100;

    for j = 1:framesPerPoint

        progress = j/framesPerPoint;

        % Move particles gradually outward
        currentX = xs + (xe-xs)*progress;
        currentY = ys + (ye-ys)*progress;
        currentZ = zs + (ze-zs)*progress;

        % Number of particles visually released
        visibleNumber = max(1,round(Nrelease*fraction));

        set(releaseParticles, ...
            'XData',currentX(1:visibleNumber), ...
            'YData',currentY(1:visibleNumber), ...
            'ZData',currentZ(1:visibleNumber));

        % Update information
        info.String = sprintf( ...
            'Time = %.1f days     |     Cumulative Release = %.2f%%', ...
            time(k),release(k));

        title('Data-Driven Protein Release from PLGA Microsphere');

        drawnow;

        pause(0.08);
    end
end

%% Final state

info.String = sprintf( ...
    'Final observed release = %.2f%% at %.1f days', ...
    release(end),time(end));

title('PLGA Microsphere - Sustained Protein Release');

drawnow;