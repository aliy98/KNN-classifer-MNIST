function [X,T] = loadMNIST(which,classes)
% load MNIST image data and class labels
% loadMNIST(which)
%     if which = 0 loads training data, otherwise loads test data
% X = loadMNIST(which)
%     loads just the images for unsupervised learning
% [X, T] = loadMNIST(which)
%     loads images and class labels
% [X, T] = loadMNIST(which,classes)
%     loads data for just the classes specified in vector "classes"
%     (N.B. zero is class 10)
%
% EXAMPLES
%
% X = loadMNIST(0,[1,2,3])
%     loads training images for classes 1, 2 and 3, without class labels
% [X,T] = loadMNIST(1,1:9)
%     loads test images for classes from 1 to 9 with class labels

if nargin<1
  fprintf('Read the instructions\n');
  return
end
if which
  X = loadMNISTImages('t10k-images.idx3-ubyte')';
  T = loadMNISTLabels('t10k-labels.idx1-ubyte');
else
  X = loadMNISTImages('train-images.idx3-ubyte')';
  T = loadMNISTLabels('train-labels.idx1-ubyte');
end
T(T==0)=10;

if nargin>1 && ~isempty(classes) && max(classes(:))<=10 && min(classes(:))>=1
  classes=classes(:)';
  select = false(size(X,1),1);
  for c=classes
    select = select|T==c;
  end
  X = X(select,:);
  T = T(select);
end
end

function images = loadMNISTImages(filename)
%loadMNISTImages returns a 28x28x[number of MNIST images] matrix containing
%the raw MNIST images

fp = fopen(filename, 'rb');
assert(fp ~= -1, ['Could not open ', filename, '']);

magic = fread(fp, 1, 'int32', 0, 'ieee-be');
assert(magic == 2051, ['Bad magic number in ', filename, '']);

numImages = fread(fp, 1, 'int32', 0, 'ieee-be');
numRows = fread(fp, 1, 'int32', 0, 'ieee-be');
numCols = fread(fp, 1, 'int32', 0, 'ieee-be');

images = fread(fp, inf, 'unsigned char');
images = reshape(images, numCols, numRows, numImages);
images = permute(images,[2 1 3]);

fclose(fp);

% Reshape to #pixels x #examples
images = reshape(images, size(images, 1) * size(images, 2), size(images, 3));
% Convert to double and rescale to [0,1]
images = double(images) / 255;

end


function labels = loadMNISTLabels(filename)
%loadMNISTLabels returns a [number of MNIST images]x1 matrix containing
%the labels for the MNIST images

fp = fopen(filename, 'rb');
assert(fp ~= -1, ['Could not open ', filename, '']);

magic = fread(fp, 1, 'int32', 0, 'ieee-be');
assert(magic == 2049, ['Bad magic number in ', filename, '']);

numLabels = fread(fp, 1, 'int32', 0, 'ieee-be');

labels = fread(fp, inf, 'unsigned char');

assert(size(labels,1) == numLabels, 'Mismatch in label count');

fclose(fp);

end
