omega = semilab2{1}{4}.Values.Data;
dutycycle = semilab2{1}{2}.Values.Data;

t = linspace(0, 20, length(dutycycle));

figure;

yyaxis left;
plot(t, dutycycle, '-b', 'LineWidth', 2);
ylabel('Duty Cycle (%)');

yyaxis right;
plot(t, omega, '-r', 'LineWidth', 2);
ylabel('Omega (rad/s)');

xlabel('Time (s)');
title('Duty Cycle and Omega over Time');

grid on;