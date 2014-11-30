img=imread('resim.png');
imgRotated=imrotate(img, 30, 'bil', 'crop');
%resim 30derece dondurulup orjinal boyutuna kirpilir
imshow(imgRotated)
