% Pad Z with NaN values to match the size of X and Y
Z_padded = NaN(size(X));
Z_padded(1:size(Z, 1), 1:size(Z, 2)) = Z;

% Define contour levels (optional)
contour_levels = [0:5:100];  % Adjust as needed

% Create the plot with contour lines
figure;
contourf(X, Y, Z_padded, contour_levels, 'LineColor', 'k');
colorbar;
hold on;

% Plot only the border lines of land areas
geoshow('landareas.shp', 'EdgeColor', 'k', 'LineWidth', 1.5);

% Adjust the axes labels
xlabel('Longitude');
ylabel('Latitude');
title('Contours with Map Overlay (Border Lines Only)');
