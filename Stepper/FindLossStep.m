step_modes = {'1/32', '1/16', '1/8', '1/4', 'Half-Step', 'Full-Step'};
num_modes = length(step_modes);

figure('Name', 'Stepper Motor Speed vs Frequency for Different Modes', 'NumberTitle', 'off');
hold on;
grid on;

for idx = 1:num_modes
    subplot(2, 3, idx);     
    freq = step{idx}{6}.Values.Data;
    speed = step{idx}{5}.Values.Data;
    time = step{idx}{5}.Values.Time;

    speed(time < 0.1 & speed > 0) = 0;

    plot(freq, speed, 'LineWidth', 2);
    hold on;
    
    % Find the maximum speed for the current mode
    max_speed = max(speed);
    plot(xlim, [max_speed, max_speed], '--k', 'LineWidth', 2);  % Draw a line at max speed
    
    % Mark the loss of steps threshold
    high_freq_threshold = 100;
    high_freq_mask = freq > high_freq_threshold;
    high_freq = freq(high_freq_mask);
    high_speed = speed(high_freq_mask);

    freq_threshold = 0.95 * max(freq);
    focus_freq_mask = high_freq > freq_threshold;
    focus_freq = high_freq(focus_freq_mask);
    focus_speed = high_speed(focus_freq_mask);

    speed_diff = diff(focus_speed);
    [~, drop_index] = min(speed_diff);
    
    loss_step_freq = focus_freq(drop_index + 1);

    plot([loss_step_freq, loss_step_freq], ylim, '--r', 'LineWidth', 2);
    
    fprintf('%s Mode: Motor loses steps at %.2f Hz %.2f rad/s \n', step_modes{idx}, loss_step_freq, max_speed);
    
    xlabel('Frequency (Hz)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Speed (RPM or m/s)', 'FontSize', 12, 'FontWeight', 'bold');
    title(sprintf('%s Mode', step_modes{idx}), 'FontSize', 12, 'FontWeight', 'bold');
    
    grid on;
end

% Super title for the whole figure
sgtitle('Speed vs Frequency for Different Stepper Motor Modes', 'FontSize', 14, 'FontWeight', 'bold'); 
hold off;
