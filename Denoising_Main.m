clc;
clear;
% addpath('Utilities');
Noise_levels      =    [5, 10,  15, 20, 25, 30, 50, 100];

idx               =    7;
nSig              =    Noise_levels( idx );

Ori_image         =    'Original_images\House.tif';
I                 =    double( imread(Ori_image) );
De_I              =    Image_Denoising( nSig, idx, I );

imwrite( De_I./255, 'Results\LASSC_House.tif' );




 