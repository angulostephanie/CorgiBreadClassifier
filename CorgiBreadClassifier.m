root_folder = Constants.STEPHS_DIRECTORY; 
original_imgs = imageDatastore(fullfile(root_folder, Constants.CATEGORIES),'LabelSource', ...
    'foldernames', 'IncludeSubfolders', true, 'FileExtensions', '.jpg');
imgs = preprocessImages(original_imgs);

[train, test] = splitEachLabel(imgs, Constants.TRAINING_SIZE, 'randomize'); 
options = trainingOptions('sgdm', 'MaxEpochs', 1, 'ExecutionEnvironment', ...
    'parallel','InitialLearnRate', .001);
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
predicted_labels = classify(net, test);
accuracy = sum(predicted_labels == test.Labels)/length(predicted_labels); 

m = numel(test.Files);
predicted = table2cell(table(predicted_labels));
actual = table2cell( table(test.Labels));


counter = 1;
for i = 1:m
    if(predicted{i} ~= actual{i})
        
        disp(test.Files{i});
%         subplot(10, 10, counter), imshow(testImg);
        disp("Wrong at index #");
        disp(i);
        counter = counter + 1;
    end
     
 end


% classification_layer = 11;
% trainingFeature = activations(net, train, classification_layer);

% testFeatures = activations(net, test, classification_layer);
% logical_actual = test.Labels == "corgi";
% logical_predicted = predicted_labels == "corgi";
% dummy_actual = dummyvar(double(logical_actual)+1);
% dummy_predicted = dummyvar(double(logical_predicted)+1);
% plotconfusion(dummy_actual, dummy_predicted);


% confusion_matrix = confusionmat(test.Labels, predicted_labels);
% confusion_matrix = confusion_matrix./sum(confusion_matrix,2);
% mean(diag(confusion_matrix));
