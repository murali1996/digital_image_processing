%%%%%%%%%%%%%%%%%%%%%%%%% READ-ME %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Choose function 1 or function 2 as defined below. Default func 2.
% Set the hyper parameters kappa(K), lambda, dx and dy.
% No of iteration set to 10 by default.
% Please put the image in working directory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Reading the image 
im = imread('lenna.noise.jpg'); % imshow(im);
im = double(im);
%% C-Funtion in the Filter
% func=1: c = exp(-(delta_I/kappa)^2);
% func=2: c = 1/(1+(delta_I/kappa)^2);
func = 2;
%% Hyper-parameters 
iter = 10;
kappa = 40;
lambda = 1/10;
dx = 1; dy = 1;
%% Zero padding
im_pad = zeros(size(im,1)+2,size(im,2)+2);
im_pad(2:size(im_pad,1)-1,2:size(im_pad,2)-1) = im; 
% figure; imshow(uint8(im_pad));
%% Iterations
neighbours = 4;
for iterations=1:iter
disp(iterations);
im_new = zeros(size(im_pad)); % Initialize new diffused image
for i=1+dy:size(im_pad,1)-dy
for j=1+dx:size(im_pad,2)-dx
    if(neighbours==4)
    east = im_pad(i,j+dx) - im_pad(i,j); west = im_pad(i,j) - im_pad(i,j-dx);
    north = im_pad(i-dy,j) - im_pad(i,j); south = im_pad(i,j) - im_pad(i+dy,j);
    end
    if(func==1)
    c_east = exp(-(east/kappa)^2); c_west = exp(-(west/kappa)^2);
    c_north = exp(-(north/kappa)^2); c_south = exp(-(south/kappa)^2);
    im_new(i,j) = lambda*((1/dx^2)*c_east*east - (1/dx^2)*c_west*west...
                        + (1/dy^2)*c_north*north - (1/dy^2)*c_south*south);
    elseif(func==2)
    c_east = 1/(1+(east/kappa)^2); c_west = 1/(1+(west/kappa)^2);
    c_north = 1/(1+(north/kappa)^2); c_south = 1/(1+(south/kappa)^2);
    im_new(i,j) = lambda*((1/dx^2)*c_east*east - (1/dx^2)*c_west*west...
                        + (1/dy^2)*c_north*north - (1/dy^2)*c_south*south);
    end
end
end 
clear east west north south c_east c_west c_north c_south;
im_pad = im_pad + im_new;
% figure; imshow(uint8(im_pad));
end
im_final = im_pad(2:size(im_pad,1)-1,2:size(im_pad,2)-1);
%% Results display
figure; 
%title('Anisotropic non-linear difusion filter');
subplot(1,2,1);
imshow(uint8(im));
title('Original Image');
subplot(1,2,2);
imshow(uint8(im_final));
title('Image with reduced noise');
