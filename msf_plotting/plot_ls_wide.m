%% plot_ls_wide.m
%  Matthew Ireland, 2nd July MMXV
%  Script used to produce the wide leap second plot, from an
%  expanded log file.
%  All times in script refer to UTC (MSF is transmitting UTC+1).

%% Clean workspace
%clear
%close all
%figure;

%% Constants
prevDayRaise = 1.5;   % amount by which to raise data from previous day


%% Import data
formatSpec = '%f%f%[^\n\r]';
delimiter = ',';

% Previous day
filename = 'prev.csv';
fh = fopen(filename,'r');
data_prev = textscan(fh, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
time_prev = data_prev{:, 1};
samples_prev = data_prev{:, 2};
fclose(fh);

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

% the carrier of both signals is currently inverted, so that
% the bit values are the 'right way round'
% Invert them so they are the same as the carrier
samples_prev = 1 - samples_prev; 
samples_leap = 1 - samples_leap;

samples_prev = samples_prev*0.7; 
samples_leap  = samples_leap*0.7;

% join individual minute signals
lsDay   = samples_leap+0.25;
prevDay = samples_prev+prevDayRaise;
prevDay = padarray(prevDay,length(lsDay)-length(prevDay),prevDayRaise,'post');


%% Plot data
plot(time, lsDay, 'b');
hold on
plot(time, prevDay, 'r');
hold off

%% Annotate and format plot
axis([-8 130 0 2.75])
set(gca,'Fontname','Myriad Pro Regular')
set(gca,'FontSize',14)
ax = gca;
ax.XTick = 0:10:max(time);
ax.YTick = [];
xlabel('Seconds after 23:58:00')
%title('MSF 2358-0000Z Leap Second 2015') 
