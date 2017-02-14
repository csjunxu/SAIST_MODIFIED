% =========================================================================
% LASSC for image denoising, Version 1.0
% Copyright(c) 2013 Weisheng Dong, Guangming Shi, and Xin Li
% All Rights Reserved.
% 
% Author: Weisheng Dong, Xidian University, Xi'an, China
% Email: wsdong@mail.xidian.edu.cn
% =========================================================================
%
% Permission to use, copy, or modify this software and its documentation
% for educational and research purposes only and without fee is here
% granted, provided that this copyright notice and the original authors'
% names appear on all copies and supporting documentation. This program
% shall not be used, rewritten, or adapted as the basis of a commercial
% software or hardware product without first obtaining permission of the
% authors. The authors make no representations about the suitability of
% this software for any purpose. It is provided "as is" without express
% or implied warranty.
%----------------------------------------------------------------------
%
% This is an implementation of the algorithm for image denoising
% 
% Please cite the following paper if you use this code:
%
% Weisheng Dong, Guangming Shi, and Xin Li,"Nonlocal  
% Image Restoration with Bilateral Variance Estimation: A low-rank approach", 
% IEEE Trans. on Image Processing, vol. 22, no. 2, pp. 700-711, Feb. 2013.
% =========================================================================

function  X  =  Im2Patch( im, par )
f       =   par.win;
N       =   size(im,1)-f+1;
M       =   size(im,2)-f+1;
L       =   N*M;
X       =   zeros(f*f, L, 'single');
k       =   0;
for i  = 1:f
    for j  = 1:f
        k    =  k+1;
        blk  =  im(i:end-f+i,j:end-f+j);
        X(k,:) =  blk(:)';
    end
end