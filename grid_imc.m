
folder=dir("*.h5");
h5disp('3RIMG_01JUN2023_0145_L2B_IMC_V01R00.h5');
file_name='3RIMG_01JUN2023_0145_L2B_IMC_V01R00.h5';
info=h5info(file_name);
disp(info);
lat_grid=0:0.5:40;
lon_grid=50:0.5:100;

for n=1:length(folder)
    file_name1=folder(n).name;
    latitude = h5read(file_name1, '/Latitude');
    longitude = h5read(file_name1, '/Longitude');
    IMC=h5read(file_name1,'/IMC');
end
kerala_lat_indices = find(latitude >= lat_grid(1) & latitude <= lat_grid(2));
kerala_lon_indices = find(longitude >= lon_grid(1) & longitude <= lon_grid(2));