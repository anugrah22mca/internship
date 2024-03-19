% Define the directory containing .h5 files
directory = 'C:\Users\anugr\Downloads\internship-mat\june_5_IMR';

% Get a list of .h5 files in the directory
file_list = dir(fullfile(directory, '*.h5'));
num_files = numel(file_list);

% Preallocate arrays to store mean IMR values and GMT time
mean_IMR = zeros(num_files, 1);
gmt_time = zeros(num_files, 1);

% Iterate through each file
for n = 1:num_files
    FILENAME = fullfile(directory, file_list(n).name);
    IMR = h5read(FILENAME, '/IMR');
    
    % Extract GMT time from the filename
    filename = file_list(n).name;
    split_filename = strsplit(filename, '_');
    gmt_str = split_filename{3}; % Extract the GMT string
    gmt_time(n) = str2double(gmt_str) / 100; % Convert to hours
    
    % Exclude fill values (-999.000000) before calculating the mean
    valid_indices = IMR(:) ~= -999.000000;
    mean_IMR(n) = mean(IMR(valid_indices), 'omitnan');
end

% Plot the scatter plot
figure;
plot(gmt_time, mean_IMR, 'bo-', 'LineWidth', 2);
xlabel('GMT Time (Hours)');
ylabel('Mean IMR');
title('Mean IMR vs GMT Time');
grid on;


