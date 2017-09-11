%%%%%%%%%%%%%%%%%%%%%%%%% READ-ME %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Run FILTER ONE and TWO seperately
% Set hypper-parameter in FILTER TWO. Default values are set.
% Threshold for pseudo inverse filter set to 0.1
% Please put the image in working directory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Reading Image
im = im2double(imread('degraded.tif'));
%% FFt of the image
im_fft = fft2(im);
u_size = size(im,1);
v_size = size(im,2);
%% FILTER-ONE
h = fspecial('disk',3.5); % Better in range: 3 TO 45
hf = fft2(h,u_size,v_size); % hf_mag=abs(hf);
% Computaion of restored image
im_new = real(ifft2((abs(hf) > 0.1).*im_fft./hf));
figure;
subplot(1,2,1);
imshow(imread('degraded.tif'));
title('Degraded Image');
subplot(1,2,2);
imshow(im_new);
title('Restrored Image');
%% FILTER TWO
% K-Factor in turbulance modelling
k = 0.000015; % Better values: 0.000015
% u->row v->col
u = repmat((0:u_size-1)',1,v_size); v = repmat((0:v_size-1),u_size,1);
hf = exp(-k*((u.^2 + v.^2).^(5/6)));
im_new = real(ifft2((abs(hf) > 0.1).*im_fft./hf));
figure;
subplot(1,2,1);
imshow(imread('degraded.tif'));
title('Degraded Image');
subplot(1,2,2);
imshow(im_new);
title('Restrored Image');