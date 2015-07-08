%% plot_ls_wide.m
%  Matthew Ireland, 2nd July MMXV
%  Script used to produce the wide leap second plot, from an
%  expanded log file.
%  All times in script refer to UTC (MSF is transmitting UTC+1).

%% Clean workspace
%clear
%close all
%figure;


%% Import data
formatSpec = '%f%f%[^\n\r]';
delimiter = ',';

% leap second day
filename = 'leap.csv';
fh = fopen(filename,'r');
data_leap = textscan(fh, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
time_leap = data_leap{:, 1};
samples_leap = data_leap{:, 2};
fclose(fh);

clearvars data_6_29_2359 data_6_30_0000 data_6_30_2359 data_7_1_0000 delimiter fh filename formatSpec


%% Prepare data for plotting
time=(0:0.005:500).';     % 5ms increments
time=time(1:length(samples_leap));
time = time-60;

% the carrier of both signals is currently inverted, so that
% the bit values are the 'right way round'
% Invert them so they are the same as the carrier

samples_leap = 1 - samples_leap;


% join individual minute signals
lsDay   = samples_leap*0.7+0.11;
lsDay(1:0.333*length(lsDay)-55) = NaN;


%% Plot data
plot(time, lsDay, 'k');

%% Annotate and format plot
axis([-5 135 0 0.92])
set(gca,'Fontname','Myriad Pro Regular')
set(gca,'FontSize',8)
ax = gca;
ax.XTick = [0,20,40,61,81,101,121];
ax.YTick = [];
xlabel('Seconds after 23:59:00Z')
%title('MSF 2358-0000Z Leap Second 2015') 

hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',0.1)

set(gcf, 'Position', [0 0 1200 325])
set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 20 5.427])
