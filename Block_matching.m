function  pos_arr   =  Block_matching(im, par)
S         =   22;
f         =   par.win;
f2        =   f^2;

N         =   size(im,1)-f+1;
M         =   size(im,2)-f+1;
L         =   N*M;
X         =   zeros(f*f, L, 'single');

k    =  0;
for i  = 1:f
    for j  = 1:f
        k    =  k+1;
        blk  =  im(i:end-f+i,j:end-f+j);
        X(k,:) =  blk(:)';
    end
end

% Index image
I     =   (1:L);
I     =   reshape(I, N, M);

I2    =   zeros(N, M);
s     =   par.step;
I2(1:s:end, 1:s:end)   =  1;
[rdx, cdx]   =   find( I2 );
N1           =   length( rdx );
pos_arr      =   zeros(par.nblk, N1 );
X            =   X';

for  i  =  1 : N1
        
    row     =   rdx(i);
    col     =   cdx(i);
    off     =   (col-1)*N + row;
    off1    =   i;
                
    rmin    =   max( row-S, 1 );
    rmax    =   min( row+S, N );
    cmin    =   max( col-S, 1 );
    cmax    =   min( col+S, M );
         
    idx     =   I(rmin:rmax, cmin:cmax);
    idx     =   idx(:);
    B       =   X(idx, :);        
    v       =   X(off, :);
        
        
    dis     =   (B(:,1) - v(1)).^2;
    for k = 2:f2
        dis   =  dis + (B(:,k) - v(k)).^2;
    end
    dis   =  dis./f2;
    [val,ind]   =  sort(dis);        
    pos_arr(:,off1)  =  idx( ind(1:par.nblk) );        
end