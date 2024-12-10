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

P_L = - (Omega_NL / Torque_Stall) * Torque_Load.^2 + Omega_NL * Torque_Load;
i_L = (Current_ST - Current_NL) / Torque_Stall * Torque_Load + Current_NL;
efficiency_L = (P_L) ./ (V_in * i_L);

[Efficiency_Max, idx_max] = max(efficiency_L);
Torque_Rated = Torque_Load(idx_max);

Omega_Rated = - (Omega_NL / Torque_Stall) * Torque_Rated + Omega_NL;
I_Rated = (Current_ST - Current_NL) / Torque_Stall * Torque_Rated + Current_NL;

P_Max = (Omega_NL * Torque_Stall) / 4;

fprintf('No Load Speed (Omega_NL): %.4f rad/s\n', Omega_NL);
fprintf('No Load Current (I_NL): %.4f A\n', Current_NL);
fprintf('Rated Speed (Omega_Rated): %.4f rad/s\n', Omega_Rated);
fprintf('Rated Torque (Torque_Rated): %.4f N-m\n', Torque_Rated);
fprintf('Rated Current (I_Rated): %.4f A\n', I_Rated);
fprintf('Stall Torque (Torque_Stall): %.4f N-m\n', Torque_Stall);
fprintf('Stall Current (I_Stall): %.4f A\n', Current_ST);
fprintf('Max Power (P_Max): %.4f W\n', P_Max);
fprintf('Max Efficiency (Efficiency_Max): %.4f %%\n', Efficiency_Max * 100);
