function t = kNN_classifier(X, t, X_q, k)
    diff = diff_function(X, X_q);
    %bubble sort
    for step = 1:size(X,1)-1
        for i = 1:size(X,1)-step-1
            if diff(i) > diff(i+1)
                temp = diff(i);
                diff(i) = diff(i+1);
                diff(i+1) = temp;
                temp = t(i);
                t(i) = t(i+1);
                t(i+1) = temp;
            end
        end
    end
    t = t(1:k);
    t'
    if histc(t, mode(t))==1
        y = t(1);
    else
        y = mode(t);
    end
end



