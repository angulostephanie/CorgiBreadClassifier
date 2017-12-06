root_folder = Constants.EMILYS_DIRECTORY; 
original_imgs = imageDatastore(fullfile(root_folder, Constants.CATEGORIES),'LabelSource', ...
    'foldernames', 'IncludeSubfolders', true, 'FileExtensions', '.jpg');
% imgs = preprocessImages(original_imgs);

% [train, test] = splitEachLabel(imgs, Constants.TRAINING_SIZE, 'randomize'); 
options = trainingOptions('sgdm', 'MaxEpochs', 3, 'InitialLearnRate', ...
    .0001);
layers = [imageInputLayer([Constants.IMG_SIZE Constants.IMG_SIZE 3])
          convolution2dLayer([5,5],10,'Padding',0,'Stride',4)
          batchNormalizationLayer
          reluLayer
          
          maxPooling2dLayer(3,'Stride',2,'Padding',0)

          convolution2dLayer([3,3],50,'Padding',2,'Stride',1)
          batchNormalizationLayer
          reluLayer
          
           maxPooling2dLayer(3,'Stride',2,'Padding',0)
 
           convolution2dLayer([3,3],100,'Padding',1,'Stride',1)
           batchNormalizationLayer
           reluLayer
           
           maxPooling2dLayer(3,'Stride',2,'Padding',0)

          fullyConnectedLayer(2)
          reluLayer
          dropoutLayer
          fullyConnectedLayer(2)
          softmaxLayer
          classificationLayer];
 net = trainNetwork(train, layers, options);
 test_output = classify(net, test);
 accuracy = sum(test_output == test.Labels)/length(test_output); 

% Get the network weights for the second convolutional layer
w1 = net.Layers(2).Weights;

% Scale and resize the weights for visualization
w1 = mat2gray(w1);
w1 = imresize(w1,5);

% Display a montage of network weights. There are 96 individual sets of
% weights in the first layer.
figure
montage(w1)
title('First convolutional layer weights')

layer = 'softmax';
channels = 1;
I = deepDreamImage(net,layer,channels,'Verbose',false);
figure
imshow(I)

m = numel(test.Files);
predictedT = table(test_output);
actualT = table(test.Labels);
predicted = table2cell(predictedT);
actual = table2cell(actualT);

counter = 1;
figure
for i = 1:m
    if(predicted{i} ~= actual{i})
        
        % disp(test.Files{i});
        testImg = readimage(test,i);
        subplot(10, 10, counter), imshow(testImg);
        % disp("Wrong at index #");
        % disp(i);
        counter = counter + 1;
    end
     
 end
