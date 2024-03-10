folder = dir("*.h5");
file_name = '3RIMG_01JUN2023_0145_L2B_IMC_V01R00.h5';
info = h5info(file_name);
lat_grid = 0:0.5:40;
lon_grid = 50:0.5:100;

grid_imc1 = NaN(length(lat_grid), length(lon_grid)); % Initialize grid

for n = 1:length(folder)
    file_name1 = folder(n).name;
    latitude = h5read(file_name1, '/Latitude');
    longitude = h5read(file_name1, '/Longitude');
    IMC = h5read(file_name1, '/IMC');

    kerala_lat_indices = find(latitude >= lat_grid(1) & latitude <= lat_grid(end));
    kerala_lon_indices = find(longitude >= lon_grid(1) & longitude <= lon_grid(end));
    res = [kerala_lat_indices; kerala_lon_indices];
    
    for j = 1:length(lat_grid)
        for k = 1:length(lon_grid)
            grid_imc1(j, k) = mean(IMC(res));
        end
    end
end

% Plotting using pcolor
figure;
pcolor(lon_grid, lat_grid, grid_imc1); % No need to transpose grid_imc1
shading interp;
xlabel('Longitude');
ylabel('Latitude');
title('IMC Data');
