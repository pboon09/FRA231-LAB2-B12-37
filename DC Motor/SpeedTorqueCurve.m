g = 9.81;
angle = 6.76;
R = 0.11127;

angle_rad = deg2rad(angle);

Omega_List = [];
Torque_List = [];

for i = 8:13
    Omega = mean(semilab1{i}{5}.Values.Data);
    Omega_List = [Omega_List, Omega];
end

for i = 2:7
    kg = mean(semilab1{i}{4}.Values.Data);
    Force = (kg * g) / cos(angle_rad);
    Torque = Force * R;
    Torque_List = [Torque_List, Torque];
end

disp('Omega Data');
disp(Omega_List);

disp('Torque Data');
disp(Torque_List);

figure;
hold on;

for i = 1:length(Omega_List)
    Torque_Load = linspace(0, Torque_List(i), 100);
    omega_L = - (Omega_List(i) / Torque_List(i)) * Torque_Load + Omega_List(i);
    plot(Torque_Load, omega_L, 'LineWidth', 2, 'MarkerSize', 8, 'DisplayName', ['Input Voltage ' num2str((7 - i)*2)]);
end

xlabel('Torque (N-m)');
ylabel('Omega (rad/s)');
title('Omega vs Torque for DC Motor (6 Test Cases)');
legend('show');
grid on;

hold off;
