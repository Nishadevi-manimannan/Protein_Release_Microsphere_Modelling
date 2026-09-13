clc;
clear;
close all;

%% Experimental drug/protein release data
time = [1.08 2.96 6.85 13.96 20.95 27.66 ...
        34.92 41.90 48.89 55.74 62.87 69.86];

release = [21.70 22.40 24.49 30.73 32.43 34.94 ...
           36.71 39.85 41.28 41.67 42.07 42.80];

%% Create 3D figure
figure('Color','w');
hold on;
axis equal;
grid on;
view(35,25);

xlabel('X');
ylabel('Y');
zlabel('Z');

title('3D Data-Driven Drug Release from PLGA Microsphere');

%% Create PLGA microsphere
[X,Y,Z] = sphere(50);

R = 2.5;

surf(R*X,R*Y,R*Z, ...
    'FaceAlpha',0.18, ...
    'EdgeColor','none');

%% Create protein particles
rng(10);

N = 80;

theta = 2*pi*rand(N,1);
phi = acos(2*rand(N,1)-1);
r = R*0.75*rand(N,1);

x = r.*sin(phi).*cos(theta);
y = r.*sin(phi).*sin(theta);
z = r.*cos(phi);

%% Plot protein particles inside microsphere
scatter3(x,y,z,35,'filled');

%% Create release particles outside
Nrelease = 40;

theta2 = 2*pi*rand(Nrelease,1);
phi2 = acos(2*rand(Nrelease,1)-1);

% Particles initially near microsphere surface
r2 = R + 0.15 + 1.2*rand(Nrelease,1);

xr = r2.*sin(phi2).*cos(theta2);
yr = r2.*sin(phi2).*sin(theta2);
zr = r2.*cos(phi2);

releasedParticles = scatter3(xr,yr,zr,35,'filled');

%% Initial release state
currentRelease = release(1);

numberVisible = round(Nrelease * currentRelease/100);

set(releasedParticles, ...
    'XData',xr(1:numberVisible), ...
    'YData',yr(1:numberVisible), ...
    'ZData',zr(1:numberVisible));

%% Display information
text(0,0,3.1, ...
    sprintf('Time = %.1f days',time(1)), ...
    'HorizontalAlignment','center');

text(0,0,-3.1, ...
    sprintf('Release = %.1f %%',release(1)), ...
    'HorizontalAlignment','center');

%% Animation
for k = 1:length(time)

    currentRelease = release(k);

    numberVisible = round(Nrelease * currentRelease/100);

    set(releasedParticles, ...
        'XData',xr(1:numberVisible), ...
        'YData',yr(1:numberVisible), ...
        'ZData',zr(1:numberVisible));

    title(sprintf( ...
        'PLGA Microsphere Drug Release | %.1f days | %.1f%% released', ...
        time(k),release(k)));

    drawnow;

    pause(0.6);
end

hold off;