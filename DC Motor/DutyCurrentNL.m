current = semilab2{1}{1}.Values.Data;
dutycycle = semilab2{1}{2}.Values.Data;

t = linspace(0, 20, length(dutycycle));

figure;

yyaxis left;
plot(t, dutycycle, '-b', 'LineWidth', 2);
ylabel('Duty Cycle (%)');

yyaxis right;
plot(t, current*-1, '-r', 'LineWidth', 2);
ylabel('Current (A)');

xlabel('Time (s)');
title('Duty Cycle and Current No Load Condition');

grid on;