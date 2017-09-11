%%%%%%%%%%% READ-ME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Choose variance for the gaussian mask. Default values are set.
% Set the hyper parameters kappa(K).
% Please put the image in working directory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Reading the image 
im = imread('lenna.noise.jpg'); 
im = double(im);  %im = imresize(im,.75); %figure; imshow(uint8(im));
%% Gaussian Mask of size 7*7
% gMask = (1/170)*[1 1 2 2 2 1 1;1 3 4 5 4 3 1;2 4 7 8 7 4 2;2 5 8 10 8 5 2;2 4 7 8 7 4 2;1 3 4 5 4 3 1;1 1 2 2 2 1 1];
gMask = fspecial('gaussian', 7, 2); % keep this sigma lower
kappa = 40; % Keep this bit higher(Leart upon experimentation)
%% Implementation of NON-LOCAL MEANS
im_new = zeros(size(im));
for i=1+3+2:size(im,1)-3-2
for j=1+3+2:size(im,2)-3-2
    disp([i j]);
    patch = im(i-3:i+3,j-3:j+3); % 7*7 patch
    wMat = zeros(5,5); % 5*5 patch
    for l = -2:2
    for m = -2:2
        newPatch = im(i-3+l:i+3+l,j-3+m:j+3+m);
        temp = (newPatch - patch).*(newPatch - patch);
        temp = temp.*gMask;
        wMat(l+3,m+3) = exp(- sum(sum(temp))/kappa^2 ); 
    end
    end
    wMat = wMat./(sum(sum(wMat)));
    im_new(i,j) = sum(sum(im(i-2:i+2,j-2:j+2).*wMat));
end
end
clear i j l m wMat patch newPatch temp; 
%% Results display
figure; 
subplot(1,2,1);
imshow(uint8(im));
title('Original Image');
subplot(1,2,2);
imshow(uint8(im_new));
title('Denoised Image');