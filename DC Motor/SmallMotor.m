time_connected = small{1}{3}.Values.Time;
time_not_connected = small{2}{3}.Values.Time;

current_connected = small{1}{3}.Values.Data;
current_not_connected = small{2}{3}.Values.Data;

rms_connected = rms(current_connected);
rms_not_connected = rms(current_not_connected);

figure('Name', 'Dynamic Torque Motor Load vs Current', 'NumberTitle', 'off');
hold on;
grid on;

plot(time_connected, rms_connected * ones(size(time_connected)), '-r', 'LineWidth', 2);
plot(time_not_connected, rms_not_connected * ones(size(time_not_connected)), '-b', 'LineWidth', 2);

xlabel('Time (s)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Current (A)', 'FontSize', 12, 'FontWeight', 'bold');
title('Motor Load vs Current', 'FontSize', 14, 'FontWeight', 'bold');

legend({'Motor Load - Connect to Motor Drive', 'Motor Load - Not Connect to Motor Drive'}, 'Location', 'best');

ylim([2.85 2.89]);

hold off;
    