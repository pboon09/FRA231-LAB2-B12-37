torque_setpoints = [0.2, 0.4, 0.6, 0.8, 1.0];

num_modes = 3;

figure('Name', 'Dynamic Torque Motor', 'NumberTitle', 'off');
hold on;
grid on;

for mode_idx = 1:num_modes
    subplot(1, 3, mode_idx);
    
    if mode_idx == 1
        idx_range = 11:15;
        title_text = 'Dynamic Torque Motor No Load';
    elseif mode_idx == 2
        idx_range = 1:5;
        title_text = 'Dynamic Torque Motor Load - Not Connect to Motor Drive';
    else
        idx_range = 6:10;
        title_text = 'Dynamic Torque Motor Load - Connect to Motor Drive';
    end
    
    torque = torque_setpoints;
    rms_currents = zeros(1, length(torque));

    for i = 1:length(idx_range)
        current_data = big{idx_range(i)}{4}.Values.Data;
        
        rms_currents(i) = rms(current_data);
    end

    plot(torque, rms_currents, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
    hold on;

    for i = 1:length(torque)
        text(torque(i), rms_currents(i) + 0.01, sprintf('%.2f A', rms_currents(i)), ...
            'FontSize', 10, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    end

    xlabel('Torque Setpoint (Nm)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Current (A)', 'FontSize', 12, 'FontWeight', 'bold');
    title(title_text, 'FontSize', 12, 'FontWeight', 'bold');
    
    ylim([0 5]);
    
    grid on;
end

sgtitle('Dynamic Torque Motor', 'FontSize', 14, 'FontWeight', 'bold');
