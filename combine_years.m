%combine txt file
d13 = int16(dlmread('Sawah_2013.tif.txt'));
d14 = int16(dlmread('Sawah_2014.tif.txt'));
d15 = int16(dlmread('Sawah_2015.tif.txt'));

data = vertcat(d13,d14,d15);

fName = ['comb_2013_2014_2015','.txt'];         %# A file name
        fid = fopen(fName,'w');            %# Open the file
        dlmwrite(fName,data,'-append',...  %# Print the matrix
                 'delimiter','\t',...
                 'newline','pc');

        fclose(fid);

%% data lowpass
        
d13 = int16(dlmread('Sawah_2013.tif_lowpass.txt'));
d14 = int16(dlmread('Sawah_2014.tif_lowpass.txt'));
d15 = int16(dlmread('Sawah_2015.tif_lowpass.txt'));

data = vertcat(d13,d14,d15);

fName = ['comb_2013_2014_2015_lowpass','.txt'];         %# A file name
        fid = fopen(fName,'w');            %# Open the file
        dlmwrite(fName,data,'-append',...  %# Print the matrix
                 'delimiter','\t',...
                 'newline','pc');

        fclose(fid);

%% data wavelet
d13 = int16(dlmread('Sawah_2013.tif_wavelet.txt'));
d14 = int16(dlmread('Sawah_2014.tif_wavelet.txt'));
d15 = int16(dlmread('Sawah_2015.tif_wavelet.txt'));

data = vertcat(d13,d14,d15);

fName = ['comb_2013_2014_2015_wavelet','.txt'];         %# A file name
        fid = fopen(fName,'w');            %# Open the file
        dlmwrite(fName,data,'-append',...  %# Print the matrix
                 'delimiter','\t',...
                 'newline','pc');

        fclose(fid);
        
        
%% data comparation
d13 = int16(dlmread('comb_2013_2014_2015.txt'));
d14 = int16(dlmread('comb_2013_2014_2015_lowpass.txt'));
d15 = int16(dlmread('comb_2013_2014_2015_wavelet.txt'));

data = vertcat(d13,d14,d15);

fName = ['compare_2013_2014_2015_all','.txt'];         %# A file name
        fid = fopen(fName,'w');            %# Open the file
        dlmwrite(fName,data,'-append',...  %# Print the matrix
                 'delimiter','\t',...
                 'newline','pc');

        fclose(fid);
        