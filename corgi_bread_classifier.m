disp('Hi');
StephDir = '/Users/stephanieangulo/Desktop/cs-stuff/fall-2017/machine-learning/final_project/data';
EmilyDir = 'D:\CodeStuff\MATLAB\Machine_Learning\DoggoProject\data';
rootFolder = StephDir;
categories = {'corgi_data','bread_data'};
imgs = imageDatastore(fullfile(rootFolder, categories),'LabelSource', ...
    'foldernames', 'IncludeSubfolders', true, 'FileExtensions', '.jpg');
 imgs.ReadFcn = @(loc)imresize(imread(loc),[200,200]); % resize images

N = numel(imgs.Files);
imageSize = nan(N,2);
for i = 1137:N
    try
   img = readimage(imgs,i);
%    fprintf('File #: %d\nSize %d-by-%d-by-%d\n', i, size(img,1), size(img,2), size(img,3));
    catch
        delete(imgs.Files{i}); % delete corrupt images
        disp(i);
    end
end
[train, test] = splitEachLabel(imgs, 50, 'randomize'); 

options = trainingOptions('sgdm', 'MaxEpochs', 3, 'InitialLearnRate', ...
    .001);

layers = [imageInputLayer([200 200 3])
          fullyConnectedLayer(2)
          softmaxLayer
          classificationLayer];

net = trainNetwork(train, layers, options);
test_output = classify(net, test);
accuracy = sum(test_output == testing.Labels)/length(test_output); 

% function Iout = readAndPreprocessImage(filename)
% try
%     I = imread(filename);
%     % Some images may be grayscale. Replicate the image 3 times to
% % create an RGB image.
%     if ismatrix(I)
%         I = cat(3,I,I,I);
%     end
% % Resize the image as required for the CNN.
%     Iout = imresize(I, [28 28]);
% %imwrite(Iout, filename);
% catch
%     disp('nah');
%     disp(filename);
%     Iout = null;
% end
% end
