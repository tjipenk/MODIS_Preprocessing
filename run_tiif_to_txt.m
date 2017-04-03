part = '/home/alvin/TIFF/';
list = dir([part,'*.tif']);
i = size(list,1);
for n = 1:i
    raster_to_xyz([part,list(n).name],'wavelet','txt')
end
for n = 1:i
    raster_to_xyz([part,list(n).name],'lowpass','txt')
end
