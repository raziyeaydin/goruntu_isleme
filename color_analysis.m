im = imread('1.png');
r = im(:,:, 1);
g = im(:,:, 2);
b = im(:,:, 3);
figure, imshow(im)
bwr = abs(double(r) - 210) <= 80;
bwg = abs(double(g) - 215) <= 80;
bwb = abs(double(b) - 35) <= 80;
bw = bwr .* bwg .* bwb;
figure,imshow(bw)
bw3 = cat(3, bw,bw,bw);
img = uint8(double(im) .* bw3);
figure,imshow(img)
