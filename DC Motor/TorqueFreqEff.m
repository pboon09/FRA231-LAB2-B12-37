g = 9.81;
angle = 6.76;
R = 0.11127;
V_in = 12;

angle_rad = deg2rad(angle);

frequencies = [10, 100, 1000, 10000, 100000, 1000000];

normalized_frequencies = linspace(1, 6, length(frequencies));

figure('Name', 'Torque vs Frequency andEfficiency', 'NumberTitle', 'off');
hold on; 
grid on;

colors = lines(length(frequencies));

for idx = 1:length(frequencies)
    NL = idx + 1;
    FL = idx + 8;
    Omega_NL = semilab2{NL}{4}.Values.Data(end);
    mean_kg = semilab2{FL}{4}.Values.Data(end) / 34.0;
    Current_NL = semilab2{NL}{1}.Values.Data(end) * -1;
    Current_ST = semilab2{FL}{1}.Values.Data(end);
    
    Force = (mean_kg * g) / cos(angle_rad);
    Torque_Stall = Force * R;
    Torque_Load = linspace(0, max(Torque_Stall), 100);

    i_L = (Current_ST - Current_NL) / Torque_Stall * Torque_Load + Current_NL;
    P_L = - (Omega_NL / Torque_Stall) * Torque_Load.^2 + Omega_NL * Torque_Load;
    efficiency_L = (P_L) ./ (V_in * i_L);

    Y = normalized_frequencies(idx) * ones(size(Torque_Load));
    plot3(Torque_Load, Y, efficiency_L, 'Color', colors(idx,:), 'LineWidth', 2);
end

xlabel('Torque (Nm)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Frequency (Hz)', 'FontSize', 12, 'FontWeight', 'bold');
zlabel('Efficiency (%)', 'FontSize', 12, 'FontWeight', 'bold');

title('Torque vs Frequency and Efficiency', 'FontSize', 14, 'FontWeight', 'bold');

legendLabels = arrayfun(@(f) sprintf('%d Hz', f), frequencies, 'UniformOutput', false);
legend(legendLabels, 'Location', 'best');

view(45, 60); % [azimuth, elevation] in degrees

yticks(normalized_frequencies);
yticklabels(arrayfun(@(f) sprintf('%d Hz', f), frequencies, 'UniformOutput', false));

hold off;

nCols = 3;
nRows = 2;

figure('Name', 'Torque vs Frequency and Efficiency', 'NumberTitle', 'off');
hold on; 
grid on;

colors = lines(length(frequencies));

for idx = 1:length(frequencies)
    NL = idx + 1;
    FL = idx + 8;
    Omega_NL = semilab2{NL}{4}.Values.Data(end);
    mean_kg = semilab2{FL}{4}.Values.Data(end) / 34.0;
    Current_NL = semilab2{NL}{1}.Values.Data(end) * -1;
    Current_ST = semilab2{FL}{1}.Values.Data(end);
    
    Force = (mean_kg * g) / cos(angle_rad);
    Torque_Stall = Force * R;
    Torque_Load = linspace(0, max(Torque_Stall), 100);

    i_L = (Current_ST - Current_NL) / Torque_Stall * Torque_Load + Current_NL;
    P_L = - (Omega_NL / Torque_Stall) * Torque_Load.^2 + Omega_NL * Torque_Load;
    efficiency_L = (P_L) ./ (V_in * i_L);

    row = ceil(idx / nCols);
    col = mod(idx - 1, nCols) + 1;
    
    subplot(nRows, nCols, idx);
    
    plot(Torque_Load, efficiency_L, 'Color', colors(idx,:), 'LineWidth', 2);
    
    xlabel('Torque (Nm)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Efficiency (%)', 'FontSize', 12, 'FontWeight', 'bold');
    title(sprintf('Frequency: %d Hz', frequencies(idx)), 'FontSize', 12, 'FontWeight', 'bold');
    
    grid on;
end

sgtitle('Torque vs Frequency and Efficiency', 'FontSize', 14, 'FontWeight', 'bold');  % Super title for the whole figure

hold off;
