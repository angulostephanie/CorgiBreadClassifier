disp('Hi');
StephDir = '/Users/stephanieangulo/Desktop/cs-stuff/fall-2017/machine-learning/final_project/data';
EmilyDir = 'D:\CodeStuff\MATLAB\Machine_Learning\DoggoProject\data';
rootFolder = EmilyDir;
categories = {'corgi_data','bread_data'};
imgs = imageDatastore(fullfile(rootFolder, categories),'LabelSource', ...
    'foldernames', 'IncludeSubfolders', true, 'FileExtensions', '.jpg');
% imgs.ReadFcn = @(filename)readAndPreprocessImage(filename);
 imgs.ReadFcn = @(loc)imresize(imread(loc),[200,200]); % resize images

N = numel(imgs.Files);
imageSize = nan(N,2);
for i = 1:N
    try
   img = readimage(imgs,i);
   imageSize(i,1) = size(img,1);
   imageSize(i,2) = size(img,2);
   %fprintf('File #: %d\nSize %d-by-%d-by-%d\n', i, size(img,1), size(img,2), size(img,3));
    catch
        delete(imgs.Files{i}); % delete corrupt images
        disp(i);
    end
end
[train, test] = splitEachLabel(imgs, 50, 'randomize'); 
