current = semilab2{8}{1}.Values.Data;
dutycycle = semilab2{8}{3}.Values.Data;

t = linspace(0, 20, length(dutycycle));

figure;

yyaxis left;
plot(t, dutycycle, '-b', 'LineWidth', 2);
ylabel('Duty Cycle (%)');

yyaxis right;
plot(t, current, '-r', 'LineWidth', 2);
ylabel('Current (A)');

xlabel('Time (s)');
title('Duty Cycle and Current Full Load Condition');

grid on;