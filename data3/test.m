folder=dir("*.h5");
grid_imc1 = NaN(length(lat_grid), length(lon_grid));

for n = 1:length(folder)
    file_name1 = folder(n).name;
    latitude = h5read(file_name1, '/Latitude');
    longitude = h5read(file_name1, '/Longitude');
    IMC = h5read(file_name1, '/IMC');

    kerala_lat_indices = find(latitude >= lat_grid(1) & latitude <= lat_grid(2));
    kerala_lon_indices = find(longitude >= lon_grid(1) & longitude <= lon_grid(2));
    res = [kerala_lat_indices; kerala_lon_indices];
    
    for j = 1:length(lat_grid)
        for k = 1:length(lon_grid)
            grid_imc1(j, k) = mean(IMC(res));
        end
    end
end


figure;
surf(lon_mesh, lat_mesh, grid_imc1);
xlabel('Longitude');
ylabel('Latitude');
zlabel('IMC');
title('IMC Data');
    
view(3);
