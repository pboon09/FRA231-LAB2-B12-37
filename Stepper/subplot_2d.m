accel = 1000;
accel_index = 5;

reso = [1, 2, 3, 4, 5, 6];
normalized_accel = linspace(1, 6, length(reso));
colors = lines(length(reso));

time = linspace(0, 120, 120000);

figure('Name', 'Speed vs Frequency for each Resolution', 'NumberTitle', 'off');
hold on; 
grid on;

i = accel_index;

step_labels = {'Full Step', 'Half Step', 'Micro Step 1/4', 'Micro Step 1/8', 'Micro Step 1/16', 'Micro Step 1/32'};  % Step resolution labels

for idx = 1:length(reso)  
    subplot(2, 3, idx);
    
    speed = data{i}{6}.Values.Data;
    
    Y = normalized_accel(idx) * ones(size(time));  
    
    freq = accel * time;  
    
    if length(speed) < length(freq)
        speed = [speed(:); zeros(length(freq) - length(speed), 1)];
    elseif length(speed) > length(freq)
        speed = speed(1:length(freq));
    end
    
    plot(freq, speed, 'Color', colors(idx,:), 'LineWidth', 2);  % Plot in 2D
    
    xlabel('Frequency (Hz)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Speed (rad/s)', 'FontSize', 12, 'FontWeight', 'bold');
    title(step_labels{idx}, 'FontSize', 12, 'FontWeight', 'bold');
    
    i = (idx * 5) + accel_index;
    
    grid on;
end

sgtitle(sprintf('Speed vs Frequency for each Resolution (y = %dx)', accel), 'FontSize', 14, 'FontWeight', 'bold');

hold off;
