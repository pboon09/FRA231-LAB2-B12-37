g = 9.81;
angle = 6.76;
R = 0.11127;
V_in = 12;

angle_rad = deg2rad(angle);

Omega_NL_Data = semilab1{8}{5}.Values.Data;
Current_NL_Data = semilab1{8}{1}.Values.Data;
loadcell_kg_ST_Data = semilab1{2}{4}.Values.Data;
Current_ST_Data = semilab1{2}{1}.Values.Data;

Omega_NL = mean(Omega_NL_Data);
mean_kg = mean(loadcell_kg_ST_Data);
Current_NL = sqrt(mean(Current_NL_Data.^2));
Current_ST = sqrt(mean(Current_ST_Data.^2));

Force = (mean_kg * g) / cos(angle_rad);
Torque_Stall = Force * R;

Torque_Load = linspace(0, max(Torque_Stall), 100);

omega_L = - (Omega_NL / Torque_Stall) * Torque_Load + Omega_NL;
i_L = (Current_ST - Current_NL) / Torque_Stall * Torque_Load + Current_NL;
P_L = - (Omega_NL / Torque_Stall) * Torque_Load.^2 + Omega_NL * Torque_Load;
efficiency_L = (P_L) ./ (V_in * i_L);

figure;

subplot(2,2,1);
plot(Torque_Load, omega_L, 'b-', 'LineWidth', 2);
xlabel('Torque (N-m)');
ylabel('Omega (rad/s)');
title('Omega vs Torque');
grid on;

subplot(2,2,2);
plot(Torque_Load, i_L, 'r-', 'LineWidth', 2);
xlabel('Torque (N-m)');
ylabel('Current (A)');
title('Current vs Torque');
grid on;

subplot(2,2,3);
plot(Torque_Load, P_L, 'g-', 'LineWidth', 2);
xlabel('Torque (N-m)');
ylabel('Power (W)');
title('Power vs Torque');
grid on;

subplot(2,2,4);
plot(Torque_Load, efficiency_L, 'm-', 'LineWidth', 2);
xlabel('Torque (N-m)');
ylabel('Efficiency');
title('Efficiency vs Torque');
grid on;

sgtitle('Motor Performance Characteristics');
