% Define the directory containing .h5 files
directory = 'C:\Users\anugr\Downloads\internship-mat\june_IMR_DLY';

% Get a list of .h5 files in the directory
file_list = dir(fullfile(directory, '*.h5'));
num_files = numel(file_list);

% Preallocate arrays to store mean IMR values and time
mean_IMR = zeros(num_files, 1);
time = 1:num_files;

% Iterate through each file
for n = 1:num_files
    FILENAME = fullfile(directory, file_list(n).name);
    IMR = h5read(FILENAME, '/IMR_DLY');

    % Exclude fill values (-999.000000) before calculating the mean
    valid_indices = IMR(:) ~= -999.000000;
    mean_IMR(n) = mean(IMR(valid_indices), 'omitnan');
end

% Plot the 2D plot
figure;
plot(time, mean_IMR, 'bo-', 'LineWidth', 2);
xlabel('Time');
ylabel('Mean IMR');
title('Mean IMR-DLY vs Time');
grid on;