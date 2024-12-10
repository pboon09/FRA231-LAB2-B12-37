dutycycle = semilab2{2}{3}.Values.Data;

frequencies = [10, 100, 1000, 10000, 100000, 1000000];

normalized_frequencies = linspace(1, 6, length(frequencies));

figure('Name', 'Duty Cycle vs Frequency and Full Load Condition', 'NumberTitle', 'off');
hold on; 
grid on;

colors = lines(length(frequencies));

for idx = 1:length(frequencies)
    i = idx + 8;
    current = semilab2{i}{1}.Values.Data;
    Y = normalized_frequencies(idx) * ones(size(dutycycle));
    plot3(dutycycle, Y, current, 'Color', colors(idx,:), 'LineWidth', 2);
end

xlabel('Duty Cycle (%)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Frequency (Hz)', 'FontSize', 12, 'FontWeight', 'bold');
zlabel('Current (A)', 'FontSize', 12, 'FontWeight', 'bold');

title('Duty Cycle vs Frequency and Current Full Load Condition', 'FontSize', 14, 'FontWeight', 'bold');

legendLabels = arrayfun(@(f) sprintf('%d Hz', f), frequencies, 'UniformOutput', false);
legend(legendLabels, 'Location', 'best');

view(45, 60); % [azimuth, elevation] in degrees

yticks(normalized_frequencies);
yticklabels(arrayfun(@(f) sprintf('%d Hz', f), frequencies, 'UniformOutput', false));

hold off;

nCols = 3;
nRows = 2;

figure('Name', 'Duty Cycle vs Frequency and Full Load Condition', 'NumberTitle', 'off');
hold on; 
grid on;

colors = lines(length(frequencies));
for idx = 1:length(frequencies)
    i = idx + 8;
    current = semilab2{i}{1}.Values.Data;
    
    row = ceil(idx / nCols);
    col = mod(idx - 1, nCols) + 1;
    
    subplot(nRows, nCols, idx);
    
    plot(dutycycle, current, 'Color', colors(idx,:), 'LineWidth', 2);
    
    xlabel('Duty Cycle (%)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Current (A)', 'FontSize', 12, 'FontWeight', 'bold');
    title(sprintf('Frequency: %d Hz', frequencies(idx)), 'FontSize', 12, 'FontWeight', 'bold');
    
    grid on;
end

sgtitle('Duty Cycle vs Frequency and Current Full Load Condition', 'FontSize', 14, 'FontWeight', 'bold');  % Super title for the whole figure

hold off;
