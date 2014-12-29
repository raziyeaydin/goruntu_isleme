img = imread('C:\Users\CENG\Desktop\rsm.png');
img = im2bw(double(img));
msr = measure(img,[],'size',[],Inf,0,0);
leng = length(msr);
kucuk = 0;
buyuk = 0;
bitisik = 0;
for i=1:leng
    if msr.size(i) < 500
        kucuk = kucuk + 1;
    elseif msr.size(i) < 1500
        buyuk = buyuk + 1;
    else
        bitisik = bitisik + 1;
        buyuk = buyuk + round(msr.size(i)/1300);  
    end
    
end
fprintf('\n%d adet kucuk\n',kucuk);
fprintf('%d adet buyuk\n',buyuk);
fprintf('%d adet bitisik\n',bitisik);
