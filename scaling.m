img = imread('resim.png');

imRescaled=imresize(img, 0.75, 'bil');
imshow(imRescaled)

imRescaled2=imresize(img, [100, 150], 'bil');
figure,imshow(imRescaled2)
