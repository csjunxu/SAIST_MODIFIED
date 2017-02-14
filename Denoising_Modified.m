clear;
Original_image_dir  =    'C:\Users\csjunxu\Desktop\PGPD_TIP\20images\';
fpath = fullfile(Original_image_dir, '*.png');
im_dir  = dir(fpath);
im_num = length(im_dir);
% addpath('Utilities');
nSig              =    50; 
Par = ParSet(nSig);

for lamada = 0.55:0.05:0.8
    Par.lamada = lamada;
    % record all the results in each iteration
    Par.PSNR = zeros(Par.Iter, im_num, 'single');
    Par.SSIM = zeros(Par.Iter, im_num, 'single');
    T512 = [];
    T256 = [];
    for i = 1:im_num
        Par.image = i;
        Par.nSig0 = nSig;
        Par.I =  double( imread(fullfile(Original_image_dir, im_dir(i).name)) );
        S = regexp(im_dir(i).name, '\.', 'split');
        randn('seed',0);
        Par.nim =   Par.I + Par.nSig0*randn(size(Par.I));
        %
        fprintf('%s :\n',im_dir(i).name);
        PSNR =   csnr( Par.nim, Par.I, 0, 0 );
        SSIM      =  cal_ssim( Par.nim, Par.I, 0, 0 );
        fprintf('The initial value of PSNR = %2.4f, SSIM = %2.4f \n', PSNR,SSIM);
        %
        time0 = clock;
        [im_out, ~, ~]    =   LASSC_Denoising( Par );
        if size(Par.I,1) == 512
            T512 = [T512 etime(clock,time0)];
            fprintf('Total elapsed time = %f s\n', (etime(clock,time0)) );
        elseif size(Par.I,1) ==256
            T256 = [T256 etime(clock,time0)];
            fprintf('Total elapsed time = %f s\n', (etime(clock,time0)) );
        end
        im_out(im_out>255)=255;
        im_out(im_out<0)=0;
        % calculate the PSNR
        Par.PSNR(Par.Iter, Par.image)  =   csnr( im_out, Par.I, 0, 0 );
        Par.SSIM(Par.Iter, Par.image)      =  cal_ssim( im_out, Par.I, 0, 0 );
        %             imname = sprintf('nSig%d_clsnum%d_delta%2.2f_lambda%2.2f_%s', nSig, cls_num, delta, lambda, im_dir(i).name);
        %             imwrite(im_out,imname);
        fprintf('%s : PSNR = %2.4f, SSIM = %2.4f \n',im_dir(i).name, Par.PSNR(Par.Iter, Par.image),Par.SSIM(Par.Iter, Par.image)     );
    end
    mPSNR=mean(Par.PSNR,2);
    [~, idx] = max(mPSNR);
    PSNR =Par.PSNR(idx,:);
    SSIM = Par.SSIM(idx,:);
    mSSIM=mean(SSIM,2);
    mT512 = mean(T512);
    sT512 = std(T512);
    mT256 = mean(T256);
    sT256 = std(T256);
    fprintf('The best PSNR result is at %d iteration. \n',idx);
    fprintf('The average PSNR = %2.4f, SSIM = %2.4f. \n', mPSNR(idx),mSSIM);
    name = sprintf(['LASSC_Sigma_1AG_nSig' num2str(nSig) '_lamada' num2str(lamada) '.mat']);
    save(name,'nSig','PSNR','SSIM','mPSNR','mSSIM','mT512','sT512','mT256','sT256');
end
