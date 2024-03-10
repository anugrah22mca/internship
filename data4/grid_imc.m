
folder=dir("*.h5");
h5disp('3RIMG_01JUN2023_0145_L2B_IMC_V01R00.h5');
file_name='3RIMG_01JUN2023_0145_L2B_IMC_V01R00.h5';
info=h5info(file_name);
disp(info);
lat_grid=0:0.5:40;
lon_grid=50:0.5:100;

grid_imc1(1:101,1:81) = NaN;


for n=1:length(folder)
    file_name1=folder(n).name;
    latitude = h5read(file_name1, '/Latitude');
    longitude = h5read(file_name1, '/Longitude');
    IMC=h5read(file_name1,'/IMC');

    kerala_lat_indices = find(latitude >= lat_grid(1) & latitude <= lat_grid(2));
    kerala_lon_indices = find(longitude >= lon_grid(1) & longitude <= lon_grid(2));
    res=[kerala_lon_indices;kerala_lat_indices];
    %res=find(latitude >= lat_grid(n) & latitude <= lat_grid(n+1) & longitude >= lon_grid(n) & longitude <= lon_grid(n+1));

    for k=1:length(lon_grid)
        for j=1:length(lat_grid)
            grid_imc1(k,j)=mean(IMC(res));
        end
    end
    
end
%[lon_mesh, lat_mesh] = meshgrid(lon_grid, lat_grid);

figure;
%surf(lon_mesh, lat_mesh, grid_imc1);
%xlabel('Longitude');
%ylabel('Latitude');
%zlabel('IMC');
%title('IMC Data');
pcolor(lat_grid,lon_grid,grid_imc1);
shading interp
%worldmap([min(lat_grid) max(lat_grid)], [min(lon_grid) max(lon_grid)]);
geoshow(lat_mesh, lon_mesh, grid_imc1, 'DisplayType', 'surface');
%colorbar;

latitude1 = double(h5read(file_name, '/Latitude'));
longitude1 = double(h5read(file_name, '/Longitude'));
%res=[kerala_lon_indices;kerala_lat_indices];
%grid_imc1(1,1)=mean(IMC(res));  