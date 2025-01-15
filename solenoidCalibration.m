delete(instrfindall); clear all; close all;
% args
fn = '011425_solenoidCalibration_booth14_L';
output = 'C:\Users\labuser\Documents\GitHub\solenoidCalibration\Data';
file = fullfile(output,[fn '.txt']);
order = 1;
targetVol = 5; %microliters

% load and fit data
header = csvread(file,[0]);
d = header(2:end,:);
header = header(1,1);
d(:,2) = (d(:,2)-header) * 1000 / 100; % run this if weights arent zeroed
%d(:,2) = (d(:,2)) * 1000 / 100; % run this if weights are zeroed
p = polyfit(d(:,1),d(:,2),order);
x = 0:max(d(:,1));
yhat = polyval(p,x);

% compute valve time and n licks to reach 1mL
valveTime = (targetVol - p(2)) / p(1);
nLicks = 1000 / targetVol;

fprintf('\n\nBooth - %s\n',fn);
fprintf('Desired valve time for %02.2fuL per lick: %06.4fms\n',targetVol,valveTime);
fprintf('%d licks per 1mL\n',nLicks);

hold on
scatter(d(:,1),d(:,2));
xlim([0,max(d(:,1))])
ylim([0,max(d(:,2))])
plot(x,yhat);
xlabel('Valve Time (ms)');
ylabel('Volume (uL)');
hold off

print(fullfile(output,[fn '_plot']),'-dpng','-r300');