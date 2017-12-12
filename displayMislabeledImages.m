function [] = displayMislabeledImages(test, predicted_labels, max)
% This function displayed the mislabeled images. The amount showed is based
% on the max variable.

m = numel(test.Files);
predicted = table2cell(table(predicted_labels));
actual = table2cell( table(test.Labels));

square_root = ceil(sqrt(max));
counter = 0;

figure;
for i = 1:m
    if(predicted{i} ~= actual{i})
        counter = counter + 1; 
        image = imread(test.Files{i});
        subplot(square_root, square_root, counter), imshow(image);  
        disp(test.Files{i});
    end
    if(counter == max)
        break;
    end
end    
end

