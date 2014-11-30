resim = imread('coins.png');
bwResim=im2bw(resim);
%resim bw’a dönüştürülür

fillResim = imfill(bwResim,'holes'); 
%paraların içinde kalan siyah bölgeleri beyazlatır

figure; imshow(imread('coins.png'));
kenarlar= bwboundaries(fillResim); 
%paraların kenar bilgilerini alır,siyah beyaz geçiş noktalarını

text(10,10,strcat('\color{red}',num2str(length(kenarlar)),'\color{red} nesne bulundu'))
%length: çizilen daire sayısıdır
%text(x,y,'string'):x ve y koordinatlardır.string’te son resmin üzerine basılacak yazıdır

%– Kenarlar resmin üzerine çizilir–%

hold on; 
%ekrana yeni şeyler çizdirilecekken eski ekranın silinmesini sağlar

for k=1:length(kenarlar) 
%length satır-sütundan büyük olan sayıyı alır

boundary = kenarlar{k};
%noktaların x y koordinatlarını tutan 2 boyutlu matris

plot(boundary(:,2),boundary(:,1),'b','LineWidth',2);
end
