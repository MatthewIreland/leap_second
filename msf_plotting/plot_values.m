samples=1-samples;  % signal is double-inverted
plot(time,samples)
axis([0 max(time) 0 1.2])
ax = gca;
ax.XTick = 0:1:max(time);
