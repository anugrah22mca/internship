folder = dir("*.h5");


lat_grid = 0:0.5:20;
lon_grid = 65:0.5:85;

grid_imc = NaN(length(lat_grid), length(lon_grid));



for n = 1:length(folder)

    latitude = h5read(file_name, '/Latitude');
    longitude = h5read(file_name, '/Longitude');
    IMC = h5read(file_name, '/IMC');
end



for j = 1:length(lat_grid)-1
    for k = 1:length(lon_grid)-1
        kerala_lat_indices = find(latitude >= lat_grid(j) & latitude <= lat_grid(j+1));
        kerala_lon_indices = find(longitude >= lon_grid(k) & longitude <= lon_grid(k+1));
        res = [kerala_lat_indices; kerala_lon_indices];
        grid_imc(j, k) = nanmean(IMC(res));
    end
end

figure;
pcolor(lon_grid, lat_grid, grid_imc); 
shading interp;
xlabel('Longitude');
ylabel('Latitude');
title('IMC Data');

function y = nanmean(x,dim)
% FORMAT: Y = NANMEAN(X,DIM)
% 
%    Average or mean value ignoring NaNs
%
%    This function enhances the functionality of NANMEAN as distributed in
%    the MATLAB Statistics Toolbox and is meant as a replacement (hence the
%    identical name).  
%
%    NANMEAN(X,DIM) calculates the mean along any dimension of the N-D
%    array X ignoring NaNs.  If DIM is omitted NANMEAN averages along the
%    first non-singleton dimension of X.
%
%    Similar replacements exist for NANSTD, NANMEDIAN, NANMIN, NANMAX, and
%    NANSUM which are all part of the NaN-suite.
%
%    See also MEAN

% -------------------------------------------------------------------------
%    author:      Jan Gläscher
%    affiliation: Neuroimage Nord, University of Hamburg, Germany
%    email:       glaescher@uke.uni-hamburg.de
%    
%    $Revision: 1.1 $ $Date: 2004/07/15 22:42:13 $

if isempty(x)
	y = NaN;
	return
end

if nargin < 2
	dim = min(find(size(x)~=1));
	if isempty(dim)
		dim = 1;
	end
end

% Replace NaNs with zeros.
nans = isnan(x);
x(isnan(x)) = 0; 

% denominator
count = size(x,dim) - sum(nans,dim);

% Protect against a  all NaNs in one dimension
i = find(count==0);
count(i) = ones(size(i));

y = sum(x,dim)./count;
y(i) = i + NaN;



% $Id: nanmean.m,v 1.1 2004/07/15 22:42:13 glaescher Exp glaescher $
end