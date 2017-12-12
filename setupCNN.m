function [train, test, layers, options, imgs] = setupCNN(root_folder)
% This function setups a convolutional neural network and return the
% training/testing sets, net layers, and net options. PlEASE NOTE: we've
% found errors between different computers when trying to perform parallel
% processing. If problems exist on your device, just remove it from the
% options var (on line 15).

original_imgs = imageDatastore(fullfile(root_folder, ... 
    Constants.CATEGORIES), 'LabelSource','foldernames', ...
    'IncludeSubfolders', true, 'FileExtensions', '.jpg');
imgs = preprocessImages(original_imgs);

[train, test] = splitEachLabel(imgs, Constants.TRAINING_SIZE, 'randomize'); 
options = trainingOptions('sgdm', 'MaxEpochs', 15,'shuffle', ...
    'every-epoch','InitialLearnRate', .00001, 'ExecutionEnvironment', 'parallel');

layers = [imageInputLayer([Constants.IMG_SIZE Constants.IMG_SIZE 3])
          
          convolution2dLayer([15,15], Constants.NUM_OF_FILTERS_1, 'Padding',0,'Stride',4)
          batchNormalizationLayer
          reluLayer
          
          maxPooling2dLayer(3,'Stride',2,'Padding',0)
          
          convolution2dLayer([10,10], Constants.NUM_OF_FILTERS_2, 'Padding',0,'Stride',4)
          batchNormalizationLayer
          reluLayer
          
          maxPooling2dLayer(3,'Stride',2,'Padding',0)
          
          convolution2dLayer([5,5], Constants.NUM_OF_FILTERS_3, 'Padding',0,'Stride',4)
          batchNormalizationLayer
          reluLayer
          
          maxPooling2dLayer(3,'Stride',2,'Padding',0)

          convolution2dLayer([3,3],Constants.NUM_OF_FILTERS_4,'Padding',2,'Stride',1)
          batchNormalizationLayer
          reluLayer
          
          maxPooling2dLayer(3,'Stride',2,'Padding',0)
 
          convolution2dLayer([2,2],Constants.NUM_OF_FILTERS_5,'Padding',1,'Stride',1)
          batchNormalizationLayer
          reluLayer
           
          maxPooling2dLayer(3,'Stride',2,'Padding',0)
          fullyConnectedLayer(2)
          softmaxLayer
          classificationLayer];
end

