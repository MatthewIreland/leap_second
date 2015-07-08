s1_fractions = s1_set ./ s1_total;
s2_fractions = s2_set ./ s2_total;
pool_fractions = pool_set ./ pool_total;

s1_datenum=zeros(length(s1_day),1);
for i=1:length(s1_day)
    month=6;
    day=s1_day(i);
    hour=s1_hr(i);
    if (hour==0)
      hour=23;
      day=day-1;
    else
        hour=hour-1;
    end
    if (day>30)
       day = day-30;
       month = 7;
    end
   s1_datenum(i)=datenum(2015,month,day,hour,s1_min(i),00);
end

s2_datenum=zeros(length(s2_day),1);
for i=1:length(s2_day)
    month=6;
    day=s2_day(i);
    hour=s2_hr(i);
    if (hour==0)
      hour=23;
      day=day-1;
    else
        hour=hour-1;
    end
    if (day>30)
       day = day-30;
       month = 7;
    end
   s2_datenum(i)=datenum(2015,month,day,hour,s2_min(i),00);
end

pool_datenum=zeros(length(pool_day),1);
for i=1:length(pool_day)
    month=6;
    day=pool_day(i);
    if (day>30)
       day = day-30;
       month = 7;
    end
   pool_datenum(i)=datenum(2015,month,day,pool_hr(i),pool_min(i),00);
end

plot(s1_datenum,s1_fractions,'b','LineWidth',1.18);
hold on
plot(s2_datenum,s2_fractions,'r','LineWidth',1.18);
plot(pool_datenum,pool_fractions,'k','LineWidth',1.18);
hold off

%xlim([736143.35 736147.65])
xlim([736143.3 736147.69])
ylim([-0.035 1.1])

set(gca,'FontSize',9)

xlabel('Time (UTC)','FontSize',14)
ylabel('Fraction of NTP servers with LI field set','FontSize',14)

%labels = datestr(s1_datenum, 'HH:MM dd/mm');
%labels = datestr(s1_datenum, 'dd/mm HH:MM');
labels = datestr(s1_datenum, 'HH:MM');
set(gca, 'XTick', s1_datenum(13:16:length(s1_datenum)));
set(gca, 'XTickLabel', labels(13:16:length(s1_datenum),:));

set(gca,'Fontname','Myriad Pro Regular')                                                                          

l = legend('Public stratum 1 servers', 'Public stratum 2 servers', 'Pool servers');
set(l,'FontSize',15)
set(l,'Position',[0.72 0.74 0.15 0.01])

ax = gca;
ax.YGrid = 'on';

set(gcf, 'Position', [0 0 1700 550])
set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 100 32.35])
