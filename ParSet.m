function  [par]=ParSet(nSig)
par.nSig = nSig;
par.c1        =   2*sqrt(2);
par.w         =   0.1;
if nSig <= 15
    par.win       =   6;
    par.nblk      =   40;
    par.lamada    =   0.65;  % .63
elseif nSig <= 30
    par.win       =   7;
    par.nblk      =   60;
    par.lamada    =   0.65;
elseif nSig<=50
    par.win       =   8;
    par.nblk      =   90;
    par.lamada    =   0.67;
    par.Iter = 12;
else
    par.win       =   9;
    par.nblk      =   90;
    par.lamada    =   0.64;
end
par.step      =   floor((par.win)/2-1);