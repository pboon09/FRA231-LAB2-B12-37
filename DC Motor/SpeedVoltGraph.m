voltages = [12, 10, 8, 6, 4, 2];

Omega_List = [];

for i = 8:13
    Omega = mean(semilab1{i}{5}.Values.Data);
    Omega_List = [Omega_List, Omega];
end

figure;
plot(voltages, Omega_List, '-o', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('Voltage (V)');
ylabel('Omega (rad/s)');
title('Speed (Omega) vs Voltage');
grid on;
