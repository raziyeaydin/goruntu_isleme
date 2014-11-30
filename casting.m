rgb=imread('peppers.png');
imshow(rgb)

gray=rgb2gray(rgb);  
figure,imshow(gray)

bw=im2bw(rgb,0.2);
figure,imshow(bw)
