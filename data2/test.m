folder=dir("*.h5");


grid_imc1 = NaN(length(lat_grid), length(lon_grid));

for n = 1:length(folder)
    file_name1 = folder(n).name;
    latitude = h5read(file_name1, '/latitude');
    longitude = h5read(file_name1, '/longitude');
    IMC = h5read(file_name1, '/IMR');

    kerala_lat_indices = find(latitude >= lat_grid(1) & latitude <= lat_grid(end));
    kerala_lon_indices = find(longitude >= lon_grid(1) & longitude <= lon_grid(end));
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
zlabel('IMR');
title('IMR Data');

view(3);
