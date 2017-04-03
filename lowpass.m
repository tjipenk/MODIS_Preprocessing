function imgS=lowpass(X)
    [x,y,z] = size(X);
    X = reshape(X,[x*y z]);
    X = repmat(X',3,1);
    %% lowpass from f 4 to 8 Fs=23
        h=fdesign.lowpass('N,Fc',8,4,23);
        d=design(h);
        
    z1=filter(d.Numerator,1,X);
    z1=filter(d.Numerator,1,flipud(z1));
    z1=flipud(z1);

    z1 = int32(z1(z+1:2*z,:)');
    %fltdatatxt(:,1) = int32(1:size(z2,1));
    %fltdatatxt(:,2:size(z2,2)+1) = z2;
    imgS = reshape(z1,[x y z]);
end