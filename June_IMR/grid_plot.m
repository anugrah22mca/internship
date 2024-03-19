folder = dir("*.h5");
lat_grid = 5:0.5:20;
lon_grid = 70:0.5:85;

% Initialize grid_mat to store the mean values of IMR
grid_mat = NaN(length(lon_grid)-1, length(lat_grid)-1, length(folder));

for n = 1:length(folder)
    FILENAME = folder(n).name;
    Longitude = double(h5read(FILENAME,'/longitude'));
    Latitude = double(h5read(FILENAME,'/latitude'));
    IMR = h5read(FILENAME,'/IMR');
    
    % Ensure Longitude and Latitude are column vectors
    Longitude = Longitude(:);
    Latitude = Latitude(:);
    
    % Create a grid for IMR
    [Longitude_grid, Latitude_grid] = meshgrid(Longitude, Latitude);
    
    for k = 1:length(lon_grid)-1
        for j = 1:length(lat_grid)-1
            % Find indices of Longitude and Latitude within the grid cell
            indices = Longitude_grid >= lon_grid(k) & Longitude_grid < lon_grid(k+1) & ...
                      Latitude_grid >= lat_grid(j) & Latitude_grid < lat_grid(j+1);
            
            % Extract IMR values within the grid cell
            IMR_subset = IMR(indices);
            
            % Check if any valid data points exist
            if ~isempty(IMR_subset)
                % Calculate the mean IMR within the grid cell
                grid_mat(k,j,n) = mean(IMR_subset, 'omitnan');
            end
        end
    end
end

grid_mat_transposed = permute(grid_mat, [2, 1, 3]);

% Plot the transposed grid_mat
figure;
pcolor(lon_grid(2:end), lat_grid(2:end), grid_mat_transposed(:,:,1)); % Assuming you want to plot the first dataset
shading interp;
xlabel('Longitude');
ylabel('Latitude');
title('IMR Data');