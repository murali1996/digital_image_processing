Topics:
1.Edge preserving smoothing Filters
2.Image Restoration
3.Unitary Transform

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
1.Edge preserving smoothing Filters
Provided with a noisy picture of Lenna (Lenna_noise.jpg) and Image denoising is performed.

Code File: q3_Anisatropic
Anisotropic non-linear diffusion filter.

Code File: q3_NonLocalMeans
Non-local means filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

2.Image Restoration
Code File: q5
The aerial image degraded.tif has been degraded with atmospheric turbulence. The
goal is to restore this image using the Pseudo inverse filter and display the restored image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

3.Unitary Transform
Code File: q6_DCT
Divide the image sunflower.jpg to 8*8 blocks. Compute the DCT for each block.
Retain the top 25% of highest DCT coefficients (highest with respect to magnitude)
in each block and set the other coefficients to zero. Take the inverse DCT for
each of the blocks and subsequently display the reconstructed image. Compute the
reconstruction error.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
