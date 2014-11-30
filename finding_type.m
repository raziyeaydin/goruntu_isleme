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

[Bilgi Sayi]=bwlabel(fillResim);
%default 8,isteğe bağlı 4 connected ile 1 sayılarını 1,2.. şeklinde etiket atayarak 
%resimdeki nesne sayısını bulur.

%sayı=etiket sayısı,bilgi=etiketlenmiş matris

prop=regionprops(Bilgi,'Area','Centroid'); %matrisin iki elemanı oluşturuldu

%prop belirlenen region’ların merkez koordinatlarını ve alan bilgilerini tutar

%Paraların boyutlarına göre 5 veya 10 cent olduğu resmi üzerine yazdırılır

total=0;
figure; imshow(imread('coins.png'));
hold on
for n=1:size(prop,1) 
%prop matrisinin 1.boyutunun eleman sayısını belirtir=10

cent=prop(n).Centroid;
X=cent(1);Y=cent(2); 
%paranın merkez koordinatları

if prop(n).Area>2000
text(X-10,Y,'5 C')
total=total+5;
else
total=total+10;
text(X-10,Y,'10 C')
end
end
hold on
title(['Toplam: ',num2str(total),'cent']) ;
