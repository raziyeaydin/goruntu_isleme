a=imread('x.png');
b=imread('y.png');

size(a) % k l m  a'nın boyutu
size(b) % p r s  b'nin boyutu

new_a = imresize(a,[p, r]);

size(new_a) % p r m new_a'nın boyutu
