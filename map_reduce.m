function O = map_reduce(I)
I=single(I);
[x y z] = size(I);
I = reshape(I,[x*y z]);

%fft analysis
    for i = 1:x*y;
        Isig = single(I(i,:)');
        if I(i,:) == zeros(1,z)
            O(i,1) = NaN;
        else
            O(i,1) = 1;
            %dmax = max(Isig);
            %dmin = min(Isig);
            %O(i,:) = ((2/(dmax-dmin))*(Isig-ones(size(Isig))*(dmin))-(ones(size(Isig))))';
        end
    end
 O = reshape(O,[x y 1]);
end

