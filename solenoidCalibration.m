clear all; close all;

% args
<<<<<<< HEAD
file = 'D:\GitHub\solenoidCalibration\180801_solenoidCalibration_booth2.txt';
=======
file = 'D:\GitHub\solenoidCalibration\180117_solenoidCalibration_recBooth.txt';
>>>>>>> origin/master
order = 1;
targetVol = 2.5; %microliters

% load and fit data
header = csvread(file,[0]);
d = header(2:end,:);
header = header(1,1);
d(:,2) = (d(:,2)-header) * 1000 / 100;
p = polyfit(d(:,1),d(:,2),1);
x = 0:max(d(:,1));
yhat = polyval(p,x);

% compute valve time and n licks to reach 1mL
valveTime = (targetVol - p(2)) / p(1);
nLicks = 1000 / targetVol;

fprintf('Desired valve time for %02.2fuL per lick: %06.4fms\n',targetVol,valveTime);
fprintf('%d licks per 1mL\n',nLicks);

hold on
scatter(d(:,1),d(:,2));
plot(x,yhat);
xlabel('Valve Time (ms)');
ylabel('Volume (uL)');
hold off
