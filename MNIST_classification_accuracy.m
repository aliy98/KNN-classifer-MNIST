clc; clear all; close all;
%% load data
[X, t] = loadMNIST(1);
train_size = 50;
accuracy = 0;
q = 0;
for x = 1:20
    i = randi(train_size);
    for k = [1 2 3 4 5 10 15 20 30 40 50]
        x = kNN_classifier_accuracy(X(1:train_size,:), t, X(i,:),k);
        for j = 1:k
            if x(j) == t(i,:)
                accuracy = accuracy + 1;
            end
        end
        if histc(x, mode(x))==1
            y = x(1);
        else
            y = mode(x);
        end
        imshow(reshape(X(i, :), 28, 28));
        title(y);
        q = q+1;
        accuracy_array(q) = (accuracy/k)*100;
        accuracy_array
        accuracy = 0;
        pause(1);
    end
    k = [1 2 3 4 5 10 15 20 30 40 50]
    figure; plot(k,accuracy_array); title("k-NN classifier accuracy"); xlabel("k"); ylabel("accuray");
    pause(10);
    accuracy_array = 0;
end