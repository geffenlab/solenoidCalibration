clear all; close all;

% args
file = 'C:\Users\labuser\Documents\170613_solenoidCalibration_booth1.txt';
order = 1;
targetVol = 2.5; %microliters

% load and fit data
d = csvread(file,1);
d(:,2) = d(:,2) * 1000 / 100;
p = polyfit(d(:,1),d(:,2),1);
x = 0:50;
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
