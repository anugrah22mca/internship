folder = dir("*.h5");

lat_grid = 0:0.5:40;
lon_grid = 50:0.5:100;

grid_imc1 = NaN(length(lon_grid)-1, length(lat_grid)-1); % Adjusted grid size

for n = 1:length(folder)
    file_name1 = folder(n).name;
    latitude = h5read(file_name1, '/Latitude');
    longitude = h5read(file_name1, '/Longitude');
    IMC = h5read(file_name1, '/IMC');
    
    for j = 1:length(lon_grid)-1
        for k = 1:length(lat_grid)-1
            kerala_lon_indices = find(longitude >= lon_grid(j) & longitude <= lon_grid(j+1));
            kerala_lat_indices = find(latitude >= lat_grid(k) & latitude <= lat_grid(k+1));
            res = intersect(kerala_lon_indices, kerala_lat_indices); % Use intersect to get common indices
            grid_imc1(j, k) = mean(IMC(res));
        end
    end
end

% Plotting using pcolor
figure;
pcolor(lon_grid, lat_grid, grid_imc1);
shading interp;
xlabel('Longitude');
ylabel('Latitude');
title('IMC Data');
