
%
% ==================== SETUP ==================== %
% root_folder = Constants.STEPHS_DIRECTORY; 
% [train, test, layers, options, imgs] = setupCNN(root_folder);   

% ==================== TRAIN ==================== %
net = trainNetwork(train, layers, options);

% =================== RESULTS =================== %
predicted_labels = classify(net, test);
accuracy = sum(predicted_labels == test.Labels)/length(predicted_labels);
 


% ========== CONTENT THAT IS DISPLAYED ========== %
% displayMislabeledImages(test, predicted_labels, Constants.NUM_OF_MISLABELED);
% disp('Accuracy of CNN:');
% disp(accuracy);
%}

%  displayMislabeledImages(test, predicted_labels, Constants.NUM_OF_MISLABELED);
% path = strcat(Constants.STEPHS_DIRECTORY, '/corgi/1.jpg');
% corgi = imread(path);
% act1 = activations(net,corgi,'classoutput','OutputAs','channels');
% sz = size(act1);
% 
% act1 = reshape(act1,[sz(1) sz(2) 1 sz(3)]);
% [maxValue,maxValueIndex] = max(max(max(act1)));
% act1chMax = act1(:,:,:,maxValueIndex);
% act1chMax = mat2gray(act1chMax);
% act1chMax = imresize(act1chMax,[sz(1) sz(2)]);
% corgi = imresize(corgi,[sz(1) sz(2)]);
% imshowpair(corgi,act1chMax,'montage')
% 

% img = deepDreamImage(net,'fc',1,'Verbose',true, 'NumIterations',300, 'PyramidLevels',4);

% w1 = net.Layers(2).Weights;
% w1 = mat2gray(w1);
% w1 = imresize(w1,5);
% figure;
% montage(w1);
% title('First convolutional layer weights');


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
