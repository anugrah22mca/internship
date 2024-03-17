% Pad Z with NaN values to match the size of X and Y
[X, Y] = meshgrid(lon_grid, lat_grid);
slice_index = 1;  % Choose the slice index
Z = squeeze(grid_mat(:,:,slice_index));
Z_padded = NaN(size(X));
Z_padded(1:size(Z, 1), 1:size(Z, 2)) = Z;

% Create the plot with contours
figure;
contourf(X, Y, Z_padded);
colorbar;
hold on;

% Plot the land areas with transparency
land = shaperead('landareas.shp', 'UseGeoCoords', true);
geoshow(land, 'FaceColor', [0.5 0.7 0.5], 'EdgeColor', 'black', 'FaceAlpha', 0.5);
%geoshow('landareas.shp', 'DisplayType', 'line', 'LineWidth', 1.5, 'LineStyle', '-', 'EdgeColor', 'black');

% Replace yellow areas with transparency in the analysis grid
yellow_threshold = 0.8; % Adjust threshold if needed
Z_transparent = Z;
yellow_indices = Z >= yellow_threshold;
Z_transparent(yellow_indices) = NaN;

% Overlay the modified analysis grid
contourf(X, Y, Z_transparent, 'AlphaData', ~yellow_indices, 'EdgeColor', 'none');

% Adjust the axes labels
xlabel('Longitude');
ylabel('Latitude');
title('Contours with Transparent Land Areas and Yellow Avoidance');
