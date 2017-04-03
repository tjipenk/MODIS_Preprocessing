part_tif = '/home/alvin/TIFF/';
list_tif = dir([part_tif,'*.tif']);

part_txt = '/home/alvin/TIFF/result/';
%list_txt = dir([part_txt,'.*']);

i = size(list_tif,1);
for n = 1:i
    list_txt = dir([part_txt,list_tif(n).name,'*.membership']);
    for m = 1:size(list_txt,1);
        xyz_to_raster([part_txt,list_txt(m).name],[part_tif,list_tif(n).name],'txt')
    end
end

