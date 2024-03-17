% Define the directory containing .h5 files
directory = 'C:\Users\anugr\Downloads\internship-mat\data3';

% Get a list of .h5 files in the directory
file_list = dir(fullfile(directory, '*.h5'));
num_files = numel(file_list);

% Preallocate arrays to store mean IMC values, GMT time, and data density
mean_IMC = zeros(num_files, 1);
gmt_time = zeros(num_files, 1);
data_density = zeros(num_files, 1);

% Iterate through each file
for n = 1:num_files
    FILENAME = fullfile(directory, file_list(n).name);
    IMC = h5read(FILENAME, '/IMC');
    
    % Extract GMT time from the filename
    filename = file_list(n).name;
    split_filename = strsplit(filename, '_');
    gmt_str = split_filename{3}; % Extract the GMT string
    gmt_time(n) = str2double(gmt_str) / 100; % Convert to hours
    
    % Exclude fill values (-999.000000) before calculating the mean
    valid_indices = IMC(:) ~= -999.000000;
    mean_IMC(n) = mean(IMC(valid_indices), 'omitnan');
    
    % Calculate data density (number of valid data points)
    data_density(n) = sum(valid_indices);
end

% Define marker size based on data density
marker_size = 10 * sqrt(data_density / max(data_density)); % Adjust scaling factor as needed

% Plot the bubble plot
figure;
scatter(gmt_time, mean_IMC, marker_size, data_density, 'filled');
colorbar;
xlabel('GMT Time (Hours)');
ylabel('Mean IMC');
title('Mean IMC vs GMT Time (Bubble Plot)');
grid on;
