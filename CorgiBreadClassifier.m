root_folder = Constants.STEPHS_DIRECTORY; 
categories = {'corgi_data','bread_data'};
imgs = imageDatastore(fullfile(root_folder, categories),'LabelSource', ...
    'foldernames', 'IncludeSubfolders', true, 'FileExtensions', '.jpg');
imgs.ReadFcn = @(loc)imresize(imread(loc),[Constants.IMG_SIZE, Constants.IMG_SIZE]); % resize images
[train, test] = splitEachLabel(imgs, Constants.TRAINING_SIZE, 'randomize'); 
options = trainingOptions('sgdm', 'MaxEpochs', 3, 'InitialLearnRate', ...
    .001);
layers = [imageInputLayer([Constants.IMG_SIZE Constants.IMG_SIZE 3])
          fullyConnectedLayer(2)
          softmaxLayer
          classificationLayer];
net = trainNetwork(train, layers, options);
test_output = classify(net, test);
accuracy = sum(test_output == testing.Labels)/length(test_output); 
