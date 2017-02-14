function  im  =   Image_Denoising( nSig, idx, I )
K             =   [6,  9,  10, 11, 11, 11, 12, 14];
par.K         =   K(idx);
if nSig<=15
    par.win       =   6;
    par.nblk      =   40;
    par.c1        =   2.8*sqrt(2);   % 1.7
    par.lamada    =   0.65;  % .63
    par.w         =   0.28;  % .28
elseif nSig <= 30
    par.win       =   7;
    par.nblk      =   60;
    par.c1        =   2.9*sqrt(2);   % 2.6
    par.lamada    =   0.65;
    par.w         =   0.23;
elseif nSig<=50
    par.win       =   8;
    par.nblk      =   75;
    par.c1        =   3.0*sqrt(2);   % 2.6
    par.lamada    =   0.67;
    par.w         =   0.23;    
else
    par.win       =   9;
    par.nblk      =   90;
    par.c1        =   3.1*sqrt(2);   % 1.6
    par.lamada    =   0.64;
    par.w         =   0.23;    
end
par.step          =   min(6, par.win-1);
time0             =   clock;
rand('seed',0);
par.I             =   I;
par.nim           =   par.I + nSig*randn(size(I));
par.nSig          =   nSig;
    
[im, PSNR, SSIM]    =   LASSC_Denoising( par );

disp( sprintf('Denoised image: PSNR = %3.2f  SSIM = %f\n', PSNR, SSIM) );
disp(sprintf('Total elapsed time = %f min\n', (etime(clock,time0)/60) ));
return;



