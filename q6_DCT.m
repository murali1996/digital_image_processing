%%%%%%%%%%%%%%%%%%%%%%%%% READ-ME %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Please put the image in working directory
% Reconstruction error is diplayed on the terminal.
% Please set the percentage- no of coefficients to be retained in 'retain' 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Reading the image 
im = imread('sunflower.jpg');
im = rgb2gray(im);
im = double(im);
%% Figure
subplot(2,2,1); 
imshow(uint8(im));
title('Original Image');
%% percentage-no of coeffecients to be retained
retain = [0.10 0.25 0.75];
for ret=[1 2 3]
    im_new = zeros(size(im));
    %% DCT
    i = 8;
    while(i<=size(im,1))
    j = 8;
    while(j<=size(im,2))
      temp = im(i-7:i,j-7:j) - 128;
      temp_dct = dct2(temp);
      %% Retaining top 25% frequencies
      % temp_dct(7:8,:) = 0; temp_dct(:,7:8) = 0;
      %% Retaining top 25% DCT coeffecients wrt magnitudes
      temp_dct_linear = reshape(temp_dct,[1 size(temp_dct,1)*size(temp_dct,2)]);
      [~, ind] = sort(abs(temp_dct_linear), 'descend');
      fromNum = min(round(retain(ret)*64),64);
      temp_dct_linear(ind(fromNum:end)) = 0 ;
      temp_dct = reshape(temp_dct_linear,size(temp_dct,1),size(temp_dct,2));
      %% reconstruction
      temp_new = idct2(temp_dct); temp_new = round(temp_new) +128;
      im_new(i-7:i,j-7:j) = temp_new;
      j = j+8;
    end
    i = i+8;
    end
    clear temp_dct_linear temp_dct temp_new temp i j ind;
    subplot(2,2,ret+1);  imshow(uint8(im_new)); 
    title(sprintf('Retained (highest) coeffecients: %0.2f',retain(ret)));
    %% Reconstruction Error
    err = sum(sum( (uint8(im)-uint8(im_new)).*(uint8(im)-uint8(im_new)) ));
    disp('reconstruction error: ');
    disp(sprintf('Retained (highest) coeffecients: %0.2f',retain(ret)));
    disp(err);
end