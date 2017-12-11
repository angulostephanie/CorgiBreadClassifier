function [better_imgs] = preprocessImages(imgs)
% This function resizes images based on the IMG_SIZE constant and deletes
% corrupt and nonrbg images.

imgs.ReadFcn = @(loc)imresize(imread(loc),[Constants.IMG_SIZE, Constants.IMG_SIZE]); 
N = numel(imgs.Files);

for i = 1:N
   try
       img = readimage(imgs,i);
       if(size(img,3) < 3)
            delete(imgs.Files{i}); 
            disp(i);
       end
   catch
        delete(imgs.Files{i});
        disp(i);
   end
end

better_imgs = imgs;
end

