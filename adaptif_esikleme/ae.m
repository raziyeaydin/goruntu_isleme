function ae(T)
    
    gray_img = imread('cameraman.tif');
    m = size(gray_img,1);
    n = size(gray_img,2);
    
    epsilon = eps;

    pixel_sayisi = m*n ;
    esik_matrisi = mat2gray(gray_img > T) ; %eþik deðerinden büyük olanlarý 1 yaptýk diðerleri 0.

    esikten_buyuk = sum(sum(esik_matrisi)) ; %1lerin toplamý 
    esikten_kucuk = pixel_sayisi - esikten_buyuk ; %piksel sayýsýndan 1lerin adedini çýkardým 0 adedini buldum

    esiklenmis_buyuk_matris = gray_img.*uint8(esik_matrisi) ; %resmin orjinali ile eþiklenen matrisi çarparak eþik deðerinden büyük olanlarý buldum.
    Mop = sum(sum(esiklenmis_buyuk_matris))/(esikten_buyuk) ; %eþik deðerinden büyük olanlarýn ortalamasý

    ters_esik_matrisi = mat2gray(~esik_matrisi); %deðilini aldým
    esiklenmis_kucuk_matris = gray_img.*uint8(ters_esik_matrisi) ; %eþik deðerinden küçük olanlarý bulduk ve çarptýk.
    Map = sum(sum(esiklenmis_kucuk_matris))/(esikten_kucuk); % küçük olanlarýn ortalamasýný bulduk


    Teski = T;
    Tyeni = (Map + Mop)/2;
    
     if abs(Teski-Tyeni) > epsilon
        T = Tyeni;
        fprintf('yeni T: %d\n',T);
        ae(T)
     else
        fprintf('gecerli T: %d\n',T);
     end
     
     resim = gray_img>T ;
     rsm = mat2gray(resim);
     subplot(1,2,1),imshow(gray_img);
     subplot(1,2,2),imshow(rsm);    
end