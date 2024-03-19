% Define the directory containing .h5 files
directory = 'C:\Users\anugr\Downloads\internship-mat\data4';

% Get a list of .h5 files in the directory
file_list = dir(fullfile(directory, '*.h5'));
num_files = numel(file_list);

% Preallocate arrays to store aggregated data
[X, Y] = meshgrid(lon_grid, lat_grid);
Z_total = zeros(size(X));  % Initialize total intensity grid
count = 0;  % Counter for the number of processed files

% Loop through each file
for file_idx = 1:num_files
    FILENAME = fullfile(directory, file_list(file_idx).name);
    
    % Read data from the HDF5 file
    IMC = h5read(FILENAME, '/IMC');
    
    % Exclude fill values (-999.000000)
    IMC_valid = IMC ~= -999.000000;
    IMC_filtered = IMC(IMC_valid);
    
    % Interpolate IMC to match the grid size of Z_total
    [IMC_interp_lon, IMC_interp_lat] = meshgrid(linspace(min(lon_grid), max(lon_grid), size(IMC, 2)), ...
                                                 linspace(min(lat_grid), max(lat_grid), size(IMC, 1)));
    IMC_interp = interp2(IMC_interp_lon, IMC_interp_lat, IMC, X, Y);
    
    % Exclude fill values (-999.000000) after interpolation
    IMC_valid_interp = IMC_interp ~= -999.000000;
    IMC_filtered_interp = IMC_interp(IMC_valid_interp);
    
    % Accumulate the filtered data into Z_total using logical indexing
    Z_total(IMC_valid_interp) = Z_total(IMC_valid_interp) + IMC_filtered_interp;
    
    count = count + 1;
end

% Normalize the aggregated data
Z_total_normalized = Z_total / count;

% Create the plot with contours
figure;
contourf(X, Y, Z_total_normalized);
colorbar;

% Plot the land areas with transparency
hold on;
land = shaperead('landareas.shp', 'UseGeoCoords', true);
geoshow(land, 'FaceColor', [0.5 0.7 0.5], 'EdgeColor', 'none', 'FaceAlpha', 0.5);

% Replace yellow areas with transparency in the analysis grid
yellow_threshold = 0.8; % Adjust threshold if needed
Z_transparent = Z_total_normalized;
yellow_indices = Z_total_normalized >= yellow_threshold;
Z_transparent(yellow_indices) = NaN;

% Overlay the modified analysis grid
contourf(X, Y, Z_transparent, 'AlphaData', ~yellow_indices, 'EdgeColor', 'none');

% Adjust the axes labels
xlabel('Longitude');
ylabel('Latitude');
title('Contours with Transparent Land Areas and Yellow Avoidance');
