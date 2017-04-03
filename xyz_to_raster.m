%% raster to grid xyz yearly 23 data
function xyz_to_raster(input_file ,raster_file, output)

%raster_file = '/mnt/RAM_disk/Sawah_2015.tif';
%input_file = '/mnt/RAM_disk/Sawah_2015.tif_lowpass.txt.membership';
[raster, R] = geotiffread(raster_file);
[x,y,z] = size(raster);


%mask = data;
%pola = data{n};
ukuran_block=[25 25];

%normalisasi data sehingga mendapat NaN
fun_normalisasi=@(block_struct)map_reduce(block_struct.data);
datanorm=blockproc(raster,ukuran_block,fun_normalisasi,'useparallel',true);
datanorm=reshape(single(datanorm),[x*y 1]);
datanorm=~isnan(datanorm(:,1));

%raster = reshape(raster,[x*y z]);
%img(1:x*y*z/23,1) = int16(0);
%for i = 1:z/23
%    img((i)*x*y,1)=1;
%    img(1+(i-1)*x*y:(i)*x*y,2:23+1) = raster(:,1+(i-1)*23:23*i);
%end
%[cell, band] = size(img);

%clear raster;

%nccreate([raster_file,'.nc'],'x','y','band', 'data');
switch output 
    case 'txt'
        input = dlmread(input_file);
    case 'nc'
        input = ncread(input_file,'DATA');
    otherwise
        disp('Check parameter');
end

%[ncell, band] = size(input);
%img(1:x*y,1) = int16(0);
i = z/23;
%c = dlmread('sawah_allyears.txt-16.cluster_centres');
%id= dlmread('sawah_allyears.txt-16.membership');
%[a,b] = size(id);
[a,b] = size(input);

idx = a/i;
hasil(1:idx,1) = 1:idx;
for n = 1:i
    hasil(1:idx,n+1) = input(1+(n-1)*idx:idx*n,2);
end

%%create maps tiff
[o,p] = size(hasil);
img=peta_utama(hasil,datanorm);
img=reshape(img,[x y p]);

geotiffwrite([input_file,'_result.tif'],img(:,:,2:end),R);
end
