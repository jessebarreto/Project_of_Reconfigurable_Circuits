% funcao para decodificar resultados obtidos pela arquitetura de hardware
% do filtro Sobel para iamgem NxN 

clc
clear all
N=100*100; % numero de pixels da imagem de saida

img = imread('board.tif');
img = imresize((img),[100 100]);

[ row col p ] =size(img);
if p == 3
    img = rgb2gray(img);
end
figure; imshow(img)


out_img_bin=textread('resultados.txt', '%s');
out_img_str=cell2mat(out_img_bin);
% s1=bin2dec(out_img_str);
s2=bin2dec(out_img_bin);
sync_h=1;
sync_v=1;
hw_sobel=zeros(100,100);
for i=1:N
    if sync_h == 100
        sync_v = sync_v+1;
        sync_h = 1;
    else
        sync_h = sync_h+1;
    end
    dec = 0;
    for j = 1 : 11
        dec = dec + str2num(out_img_str(i,j)) * 2^(length(out_img_str(i,:)) - j);
    end
%     hw_sobel(i)=uint16(dec);
    hw_sobel(sync_v,sync_h)=uint16(dec);
%     hw_sobel(sync_v,sync_h)=uint16(bin2dec(out_img_bin(i,:)));
end
figure; 
imshow(hw_sobel)

