resimOrjinal = imread('bw_sekil.png');
% resmi yükledik


subplot(2,2,1);
imshow(resimOrjinal);
title('Orjinal Resim');
% orjinal resmi 4'e böldüğümüz alanın 1 numaralı kısmına yerleştirdik(figure'de)


resimsiyah=(resimOrjinal(:,:,1)/3)+(resimOrjinal(:,:,2)/3)+(resimOrjinal(:,:,3)/3);
% renk dizilerinin 1/3 oranıyla gri renk elde edildi


resimrenkkodu=sum(sum(resimsiyah));
resimrenkkodu=resimrenkkodu/(max(size(resimsiyah))* min(size(resimsiyah)));
resimrenkkodu=round(resimrenkkodu);
% resmin renk kodu hesaplandı


resimsiyah=resimsiyah<50;
% Gri olan Resimde belli bir eşik değerin altında kalan (50) renkleri logical olarak bir veya sıfır diye kodladık


resimsiyah=[resimsiyah.*1];
% Logical olan dizi tipi üzerinde işlem yapmak yerine diziyi normal double dizi tipine dönüşümünü sağlandı.


etiket=2;
% etiket 2 den başlamasının sebebi 0 ve 1 değerleri zaten dizide mevcut bunlar haricindeki en küçük sayı 2 dir.


while(find(resimsiyah==1))
% resimde 1 değerine sahip piksel bulunduğu müddetçe döngü işlemlere devam edecek.


[birx,biry] = find(resimsiyah==1,1);
% ilk bulduğu 1 pikselinin x ve y değerleri alınacak.


ekle=etiket;
% bu eşitlemenin sebebi komşularından biri daha önce etiketlenmiş mi yoksa sadece 1 veya 0 mı diye kontrol etmek


if ~(resimsiyah(birx-1,biry)==1 || resimsiyah(birx-1,biry)==0)
ekle=resimsiyah(birx-1,biry);
end
% ust (burada önem sırasına göre komşuları dizdim bu elemanın hemen üstündeki piksel daha önceden etiketlenmiş mi diye bakılıyor.)


if ~(resimsiyah(birx-1,biry-1)==1 || resimsiyah(birx-1,biry-1)==0)
ekle=resimsiyah(birx-1,biry-1);
end
% sol ust ( az önceki uste kıyasla daha önemli olan komşunun etiketi diye varmı bakılıyor.)


if ~(resimsiyah(birx,biry-1)==1 || resimsiyah(birx,biry-1)==0)
ekle=resimsiyah(birx,biry-1);
end
% sol (sol ust komşuluğa göre daha önemli olan sol taraftaki piksel etiketi varmı kontrolu yapılıyor.)


if ~(resimsiyah(birx+1,biry-1)==1 || resimsiyah(birx+1,biry-1)==0)
ekle=resimsiyah(birx+1,biry-1);
end
%sol alt ( En önemli komşu piksel etiketi var mı diye bakılıyor eğer varsa diğer iflere girse bile bu değeri alıcaktır.)


if ekle~=etiket
resimsiyah(birx,biry)=ekle;
else
resimsiyah(birx,biry)=ekle;
etiket=etiket+1;
end
end
% tüm 4 lü komşulara bakıldı fakat ilk başta eşitlediğimiz ekle ve etiket değeri aynı mı diye bakılıcak. Çünkü komşuluklardan birine
% bile girmişse o zaman aynı olmazlar dolayısıyla resimde bu sahip olduğu etiketi almalıdır.

% yukarıdaki döngüde aynı nesne birçok etikete sahip olabilir. bu durumu
% düzeltmek için etiketler arası uzaklık kontrolu yapılıyor. Böylece
% program aynı nesneye farklı iki etiket vermiş ise bunu uzaklık denklemi
% ile fark edip düzeltiyor. Böylece her nesne farklı bir etiket ile
% belirtilicek.

etiket=etiket-1;
while etiket>2
[a1,b1]=find(resimsiyah==etiket,1);
[a2,b2]=find(resimsiyah==etiket-1,1);
if sqrt((a1-a2).^2 + (b1-b2).^2)   <=20
resimsiyah(resimsiyah==etiket)=etiket-1;
end
etiket=etiket-1;
end

disp('*** 1 ***');
nesneetiketleri=unique(resimsiyah);
fprintf('Özellikleri Bulunan Toplam Nesne Sayısı= %d\n',length(nesneetiketleri)-1);
% bulunan nesne sayıları yazdırılır


disp('*** 2 ***');
fprintf('Resmin Ortalama Renk Kodu= %d\n',resimrenkkodu);
% bulunan nesnelerin renk kodları ekrana yazdırılır


disp('*** 3 ***');
subplot(2,2,2);
imshow(resimsiyah);
hold on
title('Nesnelerin Alanları');
tur=0;
for i = 2:length(nesneetiketleri)
tur=tur+1;
[alanx,alany]=find(resimsiyah== nesneetiketleri(i));
plot(alany,alanx,'g.')
fprintf('%d.Nesnenin Alanı= %d\n',tur,length(alanx));
end
% tüm nesnelerin alanları ekrana yazdırılır


disp('*** 4 ***');
subplot(2,2,3);
imshow(resimsiyah);
hold on
title('Nesnelerin Ağırlık Merkezleri');
tur=0;
for i = 2:length(nesneetiketleri)
tur=tur+1;
[alanx,alany]=find(resimsiyah== nesneetiketleri(i));
alanxmean=round(mean(alanx));
alanymean=round(mean(alany));
plot(alanymean,alanxmean,'r.','MarkerSize',5)
fprintf('%d.Nesnenin Ağırlık Merkezi: X=%d ,Y=%d\n',tur,alanymean,alanxmean);
end
% bu alanda tüm nesnelerin ağırlık merkezleri bulundu.


disp('*** 5 ***');
subplot(2,2,4);
imshow(resimsiyah);
title('Nesnelerin Çevreleri');
hold on
kenar=[];
tur=0;
for i = 2:length(nesneetiketleri)
kenar=[];
tur=tur+1;
while(find(resimsiyah== nesneetiketleri(i)))
[plotx,ploty] = find(resimsiyah== nesneetiketleri(i),1);
% bu alanda tüm nesnelerin çevreleri bulundu.


%ust kenarları bul
if  (resimsiyah(plotx-1,ploty)==0)
kenar=[kenar;plotx,ploty];


% sol kenarları bul
elseif (resimsiyah(plotx,ploty-1)==0)
kenar=[kenar;plotx,ploty];


%sağ kenarları
elseif (resimsiyah(plotx,ploty+1)==0)
kenar=[kenar;plotx,ploty];


%alt kenarları bul
elseif (resimsiyah(plotx+1,ploty)==0)
kenar=[kenar;plotx,ploty];
end


resimsiyah(plotx,ploty)=nesneetiketleri(i)-1;
end


plot(kenar(:,2),  kenar(:,1), 'b.','MarkerSize',5)
fprintf('%d.Nesnenin Çevresi= %d\n',tur,max(size(kenar)));
end
disp('*********');


clear a1 a2 alanx alanxmean alany alanymean b1 b2 birx biry ekle etiket i kenar plotx ploty tur resimrenkkodu nesneetiketleri resimOrjinal resimsiyah;
disp('Nesnelerin Özellikleri Grafik Üzerinde Çizilmiştir.');


%http://www.bulentsiyah.com/siyah-beyaz-resim-uzerindeki-nesnelerin-ozelliklerini-bulma-hazir-olmayan-metotlarla-matlab/
