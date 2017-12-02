disp('Hi');
StephDir = '/Users/stephanieangulo/Desktop/cs-stuff/fall-2017/machine-learning/final_project/data';
EmilyDir = 'D:\CodeStuff\MATLAB\Machine_Learning\DoggoProject\data';
rootFolder = EmilyDir;
categories = {'corgi_data','bread_data'};
imgs = imageDatastore(fullfile(rootFolder, categories),'LabelSource', ...
    'foldernames', 'IncludeSubfolders', true, 'FileExtensions', '.jpg', ...
    'ReadFcn', @(filename)readAndPreprocessImage(filename));
% imgs.ReadFcn = @(filename)readAndPreprocessImage(filename);
[train, test] = splitEachLabel(imgs, 50, 'randomize');

options = trainingOptions('sgdm', 'MaxEpochs', 3, 'InitialLearnRate', ...
    .001);

layers = [imageInputLayer([28 28 3])
          fullyConnectedLayer(2)
          softmaxLayer
          classificationLayer];

net = trainNetwork(train, layers, options);
test_output = classify(net, test);
accuracy = sum(test_output == testing.Labels)/length(test_output); 

function Iout = readAndPreprocessImage(filename)

try
    I = imread(filename);
    % Some images may be grayscale. Replicate the image 3 times to
% create an RGB image.
    if ismatrix(I)
        I = cat(3,I,I,I);
    end
% Resize the image as required for the CNN.
    Iout = imresize(I, [28 28]);
%imwrite(Iout, filename);
catch
    disp('nah');
    disp(filename);
    Iout = null;
end

end
