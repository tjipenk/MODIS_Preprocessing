%%Kmeans all data in dir
list = dir(['*.tif']);
i = size(list,1);

%% start parallel matlab --> matlabpool;
%start parallel job
%pool=matlabpool('local') %memanggil pekerja matlab 2011 matlabpool, 2012 or leater parpool

[data, r]=  geotiffread(list(1).name);

[x y z] = size(data);
mask = data;
ukuran_block=[25 25];

%normalisasi data sehingga mendapat NaN
fun_normalisasi=@(block_struct)normalisasi_data_block(block_struct.data);
datanorm=blockproc(mask,ukuran_block,fun_normalisasi,'useparallel',true);

%reshape data to each point
datanorm=reshape(single(datanorm),[x*y z]);

%select land data
datanorm=~isnan(datanorm(:,1));
datanorm=reshape(datanorm,[x*y 1]);

i = 15;
c = dlmread('sawah_allyears.txt-16.cluster_centres');
id= dlmread('sawah_allyears.txt-16.membership');

[a,b] = size(id);

idx = a/i;
hasil(1:idx,1) = 1:idx;
for n = 1:i
    hasil(1:idx,n+1) = id(1+(n-1)*idx:idx*n,2);
end
%%create maps tiff
[o,p] = size(hasil);
img=peta_utama(hasil,datanorm);
img=reshape(img,[x y p]);

geotiffwrite(strcat('peta_allyears_id.tif'),img(:,:,1),r);
geotiffwrite(strcat('peta_allyears.tif'),img(:,:,2:end),r);

%%create ascii txt
%% write data to txt
fName = ['hasil_sawah_allyears.txt'];         %# A file name
fid = fopen(fName,'w');            %# Open the file
dlmwrite(fName,hasil,'-append',...  %# Print the matrix
         'delimiter','\t',...
         'newline','pc');
    
fclose(fid);

plot(c(:,2:end)');axis([1 23 -3000 10000]);
