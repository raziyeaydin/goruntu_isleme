function ae(T)
    
    gray_img = imread('cameraman.tif');
    m = size(gray_img,1);
    n = size(gray_img,2);
    
    epsilon = eps;

    pixel_sayisi = m*n ;
    esik_matrisi = mat2gray(gray_img > T) ; %e�ik de�erinden b�y�k olanlar� 1 yapt�k di�erleri 0.

    esikten_buyuk = sum(sum(esik_matrisi)) ; %1lerin toplam� 
    esikten_kucuk = pixel_sayisi - esikten_buyuk ; %piksel say�s�ndan 1lerin adedini ��kard�m 0 adedini buldum

    esiklenmis_buyuk_matris = gray_img.*uint8(esik_matrisi) ; %resmin orjinali ile e�iklenen matrisi �arparak e�ik de�erinden b�y�k olanlar� buldum.
    Mop = sum(sum(esiklenmis_buyuk_matris))/(esikten_buyuk) ; %e�ik de�erinden b�y�k olanlar�n ortalamas�

    ters_esik_matrisi = mat2gray(~esik_matrisi); %de�ilini ald�m
    esiklenmis_kucuk_matris = gray_img.*uint8(ters_esik_matrisi) ; %e�ik de�erinden k���k olanlar� bulduk ve �arpt�k.
    Map = sum(sum(esiklenmis_kucuk_matris))/(esikten_kucuk); % k���k olanlar�n ortalamas�n� bulduk


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