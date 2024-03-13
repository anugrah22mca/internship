% Define latitude and longitude grids
lat_grid = 0:0.5:40;
lon_grid = 50:0.5:100;

% Initialize grid for storing processed data
grid_imc1 = NaN(length(lat_grid), length(lon_grid));

% Get list of HDF5 files in the current directory
folder = dir("*.h5");

% Iterate through each HDF5 file
for n = 1:length(folder)
    % Read data from the current HDF5 file
    file_name1 = folder(n).name;
    latitude = h5read(file_name1, '/Latitude');
    longitude = h5read(file_name1, '/Longitude');
    IMC = h5read(file_name1, '/IMC');

    % Process data for each grid cell
    for j = 1:length(lat_grid)-1
        for k = 1:length(lon_grid)-1
            % Find indices of latitude and longitude values within current grid cell
            lat_indices = find(latitude >= lat_grid(j) & latitude <= lat_grid(j+1));
            lon_indices = find(longitude >= lon_grid(k) & longitude <= lon_grid(k+1));
            cell_indices = intersect(lat_indices, lon_indices);
            
            % Calculate mean GPI value for current grid cell
            if ~isempty(cell_indices)
                grid_imc1(j, k) = mean(IMC(cell_indices), 'omitnan');
            else
                grid_imc1(j, k) = NaN;
            end
        end
    end
end

% Plotting the processed data
figure;
pcolor(lon_grid, lat_grid, grid_imc1); 
shading interp;
xlabel('Longitude');
ylabel('Latitude');
title('IMC Data');
colorbar; % Add color bar to the plot
