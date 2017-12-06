function [better_imgs] = preprocessImages(imgs)
%Summary of this function goes here
imgs.ReadFcn = @(loc)imresize(imread(loc),[Constants.IMG_SIZE, Constants.IMG_SIZE]); % resize images
N = numel(imgs.Files);
for i = 1:N
   try
       img = readimage(imgs,i);
%        fprintf('File #: %d\nSize %d-by-%d-by-%d\n', i, size(img,1), size(img,2), size(img,3));
       if(size(img,3) < 3)
            delete(imgs.Files{i}); % delete non rbg photos
            disp(i);
       end
   catch
        delete(imgs.Files{i}); % delete corrupt images
        disp(i);
   end
end
better_imgs = imgs;
end

