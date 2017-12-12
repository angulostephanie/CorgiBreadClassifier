% ==================== SETUP ==================== %
root_folder = Constants.PROF_LEONARDS_DIRECTORY; 
[train, test, layers, options] = setupCNN(root_folder);   

% ==================== TRAIN ==================== %
net = trainNetwork(train, layers, options);

% =================== RESULTS =================== %
predicted_labels = classify(net, test);
accuracy = sum(predicted_labels == test.Labels)/length(predicted_labels);
 
% ========== CONTENT THAT IS DISPLAYED ========== %
displayMislabeledImages(test, predicted_labels, Constants.NUM_OF_MISLABELED);
disp('Accuracy of CNN:');
disp(accuracy);
