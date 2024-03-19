% Pad Z with NaN values to match the size of X and Y
[X, Y] = meshgrid(lon_grid, lat_grid);
slice_index = 4;  % Choose the slice index
Z = squeeze(grid_mat(:,:,slice_index));
Z_padded = NaN(size(X));
Z_padded(1:size(Z, 1), 1:size(Z, 2)) = Z;

% Create the plot with pcolor and shading interp
figure;
pcolor(X, Y, Z_padded);
shading interp;
colorbar;
hold on;

% Plot the land areas with transparency
land = shaperead('landareas.shp', 'UseGeo', true);
coast.lat = [land.Lat];
coast.long = [land.Lon];
geoshow(coast.lat, coast.long, 'Color', 'k','linewidth',1.5);

% Replace yellow areas with transparency in the analysis grid
yellow_threshold = 0.8; % Adjust threshold if needed
Z_transparent = Z;
yellow_indices = Z >= yellow_threshold;
Z_transparent(yellow_indices) = NaN;

% Overlay the modified analysis grid
pcolor(X, Y, Z_transparent);
shading interp;
alpha(~yellow_indices);
colorbar;

% Adjust the axes labels
xlabel('Longitude');
ylabel('Latitude');
title('Contours with Transparent Land Areas and Yellow Avoidance');
