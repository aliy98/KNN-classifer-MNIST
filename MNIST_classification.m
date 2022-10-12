clc; clear all; close all;
%% load data
[X, t] = loadMNIST(1);
train_size = 50;
for x = 1:20
    i = randi(train_size);
    for k = [1 2 3 4 5 10 15 20 30 40 50]
        y = kNN_classifier(X(1:train_size,:), t, X(i,:),k);
        imshow(reshape(X(i, :), 28, 28));
        title(y);
        pause(1);
    end
end