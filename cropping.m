img=imread('image.png');
size(img) % MxNx3 rgb ise
crp=imcrop(img,[x y m n]);
% x, x noktasindaki baslangic noktasi
% y, y noktasindaki baslangic noktasi
% m=M-1
% n=N-1
crp=im2double(crp);
figure,imshow(crp)
