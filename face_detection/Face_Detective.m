function Face_Detective()
 
    path = '..database\images\';
    png_image = dir(strcat(path, '*.png'));
    N = size(png_image, 1);
 
    for i=1:N,
        img = imread(strcat(path, png_image(i).name));
        I(:,:,i) = rgb2gray(img);
 
        if false,
            imshow(img)
            pause(.5)
        end
    end
 
    [imgW, imgH] = size(img);
 
    for i=1:N,
        img = I(:,:,i);
        Gamma(:, i) = double(img(:));
    end
 
    Psi = mean(Gamma, 2);
    Phi = double(Gamma) - double(repmat(Psi, 1, N));
    A = Phi;
    L = A'*A; 
    [V D] = eig(L); 
    L_eig_vec = [];
 
    for i = 1 : size(V,2)
        if( D(i,i)>1 )
            L_eig_vec = [L_eig_vec V(:,i)];
        end
    end
 
    Eigenfaces = A * L_eig_vec;
    Eigenfaces = normalizeEF(Eigenfaces);
    K = 5;
    Eigenfaces = Eigenfaces(:, 1:K);
 
    for i=1:N
        img = I(:,:,i);
        imgGamma = img(:);
        imgPhi = double(imgGamma) - double(Psi);
        w = Eigenfaces' * imgPhi;
        tmp = w' * Eigenfaces'; 
        tmp = tmp * max(Psi) / max(tmp);
        recImgGamma = tmp' + Psi;
        recImg = (reshape(recImgGamma', 200, 180));
        
        figure;
        subplot(1,2,1); imagesc(img);    colormap(gray);  title('Orjinal Resim');
        subplot(1,2,2); imagesc(recImg); colormap(gray);  title('Benzer Resim');
 
        pause(0.3);
    end
end
 
function neigenFaces = normalizeEF(Eigenfaces)
    nf = sum(Eigenfaces .^2);
 
    [irow icol] = size(Eigenfaces);
    for i=1:icol
        neigenFaces(:, i) = Eigenfaces(:, i) / nf(i);
    end
 end