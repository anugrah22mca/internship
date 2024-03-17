% Define the directory containing .h5 files
directory = 'C:\Users\anugr\Downloads\internship-mat\data3';

% Get a list of .h5 files in the directory
file_list = dir(fullfile(directory, '*.h5'));
num_files = numel(file_list);

% Preallocate arrays to store mean IMC values and time
mean_IMC = zeros(num_files, 1);
%time = 1:num_files;

% Iterate through each file
for n = 1:num_files
    FILENAME = fullfile(directory, file_list(n).name);
    IMC = h5read(FILENAME, '/IMC');
    time=h5read(FILENAME,'/time');

    % Calculate the mean IMC for the current file
    mean_IMC(n) = mean(IMC(:), 'omitnan');
end

% Plot the 2D plot
figure;
plot(time, mean_IMC, 'bo-', 'LineWidth', 2);
xlabel('Time');
ylabel('Mean IMC');
title('Mean IMC vs Time');
grid on;

