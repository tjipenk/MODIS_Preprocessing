%% raster to grid xyz yearly 23 data
% Input parameter (raster_file, fil, output)
% raster_file *.tif (geotiff) multi band file
% fil --> filter (wavelet or lowpass) default = no filter
% output --> output format (*.txt or *.nc)
%%
function raster_to_xyz(raster_file, fil, output)
%raster_file = [part,list(1).name];
%raster_file = '/mnt/RAM_disk/EVI_Java_2010001_2016353.tif';
%raster_file = '/home/alvin/TIFF/jawa/EVI_Java_2010001_2016353.tif'
[raster, R] = geotiffread(raster_file);
[x,y,z] = size(raster);
raster = single(raster);
%mask = data;
%pola = data{n};
ukuran_block=[25 25];

%normalisasi data sehingga mendapat NaN
fun_normalisasi=@(block_struct)map_reduce(block_struct.data);
datanorm=blockproc(raster,ukuran_block,fun_normalisasi,'useparallel',true);
datanorm=reshape(single(datanorm),[x*y 1]);
%datanorm=~isnan(datanorm(:,1));

    switch fil
        case 'lowpass'
            fun_filter=@(block_struct)lowpass(block_struct.data);
            raster=blockproc(raster,ukuran_block,fun_filter,'useparallel',true);
            raster_file = [raster_file,'_lowpass',];
        case 'wavelet'
            fun_filter=@(block_struct)transformasi_coiflet1_lvl1(block_struct.data);
            raster=blockproc(raster,ukuran_block,fun_filter,'useparallel',true);
            raster_file = [raster_file,'_wavelet'];
        otherwise
            disp('No Filter');    

    end

raster = reshape(raster,[x*y z]);
raster = raster(~isnan(datanorm(:,1)),:);
[col,row] = size(raster);
img(1:col*row/23,1) = int16(0);

for i = 1:row/23
    img((i)*col,1)=1;
    img(1+(i-1)*col:(i)*col,2:23+1) = raster(:,1+(i-1)*23:23*i);
end

[cell, band] = size(img);
band = band-1;
clear raster;

%nccreate([raster_file,'.nc'],'x','y','band', 'data');
    switch output 
        case 'txt'
        fName = [raster_file,'.txt'];         %# A file name
        fid = fopen(fName,'w');            %# Open the file
        dlmwrite(fName,img,'-append',...  %# Print the matrix
                 'delimiter','\t',...
                 'newline','pc');

        fclose(fid);

        case 'nc'
        %create netCDF
         nccreate([raster_file,'.nc'],'Data',...
              'Dimensions',{'num_coordinates' band 'num_elements' cell},...
              'Format','netcdf4', 'Datatype', 'single');
         ncwrite([raster_file,'.nc'],'Data', single(img(:,2:end)'));
         %ncdisp([raster_file,'.nc']);
        otherwise
            disp('Check output parameter');
    end
end
