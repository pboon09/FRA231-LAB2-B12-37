km = 0.0342;
x_values = [];
y_values = [];

for i = 3:11
    small_motor_current = small{i}{3}.Values.Data;
    speed = small{i}{6}.Values.Data * -1;
    
    rms_small_motor = rms(small_motor_current);
    mean_speed = mean(speed);
    
    motor_difference = rms_small_motor * km;
    x_values = [x_values, motor_difference];
    y_values = [y_values, mean_speed];
    
    fprintf('For i = %d:\n', i);
    fprintf('RMS of small motor: %.4f\n', rms_small_motor * km);
    fprintf('Mean of speed: %.4f\n\n', mean_speed);
end

g = 9.81;
angle = 6.76;
R = 0.11127;
V_in = 12;

angle_rad = deg2rad(angle);

Omega_NL_Data = semilab1{8}{5}.Values.Data;
loadcell_kg_ST_Data = semilab1{2}{4}.Values.Data;

Omega_NL = mean(Omega_NL_Data);
mean_kg = mean(loadcell_kg_ST_Data);

Force = (mean_kg * g) / cos(angle_rad);
Torque_Stall = Force * R;

Torque_Load = linspace(0, max(Torque_Stall), 100);

omega_L = - (Omega_NL / Torque_Stall) * Torque_Load + Omega_NL;

figure;

plot(x_values, y_values, 'o-', 'LineWidth', 2, 'MarkerSize', 6, 'MarkerFaceColor', 'red');
hold on;

plot(Torque_Load, omega_L, 'b-', 'LineWidth', 2);

xlabel('Torque (N-m)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Omega (rad/s)', 'FontSize', 12, 'FontWeight', 'bold');
title('Motor Performance: Torque vs Omega', 'FontSize', 14, 'FontWeight', 'bold');

legend({'Real Case', 'Ideal Case'}, 'Location', 'Best', 'FontSize', 12, 'FontWeight', 'bold');

grid on;
xlim([min(x_values), max(Torque_Load)]);
ylim auto;

hold off;
