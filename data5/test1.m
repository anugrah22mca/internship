file_name="C:\Users\anugr\Downloads\internship-mat\data5\3RIMG_01JUN2023_0415_L2B_IMC_V01R00.h5";
lat_grid = 0:0.5:40;
lon_grid = 50:0.5:100;

grid_imc1(length(lat_grid),length(lon_grid))=NaN;


latitude = h5read(file_name, '/Latitude');
longitude = h5read(file_name, '/Longitude');
IMC = h5read(file_name, '/IMC');
kerala_lat_indices = find(latitude >= lat_grid(1) & latitude <= lat_grid(2));
kerala_lon_indices = find(longitude >= lon_grid(1) & longitude <= lon_grid(2));

res = [kerala_lat_indices; kerala_lon_indices];
for j = 1:length(lat_grid)
    for k = 1:length(lon_grid)
        grid_imc1(j, k) = mean(IMC(res));
    end
end