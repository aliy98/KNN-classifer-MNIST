function diff_array = diff_function(A,B)
    diff = 0;
    diff_array = zeros(size(A,1),1);
    for i = 1:size(A,1)
        for j = 1:size(A,2)
            if A(i,j)*B(j)==1
                diff = diff + 1;
            end
        end
        diff_array(i) = diff;
        diff = 0;
    end
    diff_array = size(A,2)*ones(size(A,1),1) - diff_array;
end