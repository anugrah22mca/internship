
% Directory containing the HDF5 files
directory = 'C:\Users\anugr\Downloads\internship-mat\data3\';
% Get all .h5 files in the directory

files = dir(fullfile(directory, '*.h5'));

% Initialize variables to store aggregated data
all_latitude = [];
all_longitude = [];
all_mean_IMC = [];

% Loop through each file
for i = 1:numel(files)
    % Get the file path
    file_path = fullfile(directory, files(i).name);
    
    % Read latitude, longitude, and IMC data from the HDF5 file
    latitude = h5read(file_path, '/Latitude');
    longitude = h5read(file_path, '/Longitude');
    IMC = h5read(file_path, '/IMC');
    
    % Replace fill values with NaN
   IMC(IMC == -999.000000) = NaN;
    
    % Calculate the mean IMC for this dataset
    mean_IMC = mean(IMC, 'omitnan');
    
    % Store the mean IMC and corresponding latitude and longitude
    all_mean_IMC = [all_mean_IMC; mean_IMC];
    all_latitude = [all_latitude; mean(latitude(:))];
    all_longitude = [all_longitude; mean(longitude(:))];
end

% Plot the mean IMC data
figure;
scatter3(all_longitude, all_latitude, all_mean_IMC);
xlabel('Longitude');
ylabel('Latitude');
zlabel('Mean IMC');
title('Mean IMC Data from All Files');