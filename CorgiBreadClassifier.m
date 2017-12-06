root_folder = Constants.STEPHS_DIRECTORY; 
categories = {'corgi_data','bread_data'};
original_imgs = imageDatastore(fullfile(root_folder, categories),'LabelSource', ...
    'foldernames', 'IncludeSubfolders', true, 'FileExtensions', '.jpg');
imgs = preprocessImages(original_imgs);
[train, test] = splitEachLabel(imgs, Constants.TRAINING_SIZE, 'randomize'); 
options = trainingOptions('sgdm', 'MaxEpochs', 1, 'InitialLearnRate', ...
    .001);
layers = [imageInputLayer([Constants.IMG_SIZE Constants.IMG_SIZE 3])
          convolution2dLayer([5,5],1)
          batchNormalizationLayer
          reluLayer
          
          maxPooling2dLayer(2,'Stride',2)

          convolution2dLayer(3,15,'Padding',1)
          batchNormalizationLayer
          reluLayer
    
          fullyConnectedLayer(2)
          softmaxLayer
          classificationLayer];
net = trainNetwork(train, layers, options);
test_output = classify(net, test);
accuracy = sum(test_output == test.Labels)/length(test_output); 

% m = numel(test.Files);
% predictedT = table(test_output);
% actualT = table(test.Labels);
% predicted = table2cell(predictedT);
% actual = table2cell(actualT);
% 
% counter = 1;
% for i = 1:m
%     if(predicted{i} ~= actual{i})
%         
%         disp(test.Files{i});
% %         subplot(10, 10, counter), imshow(testImg);
%         disp("Wrong at index #");
%         disp(i);
%         counter = counter + 1;
%     end
%      
%  end
