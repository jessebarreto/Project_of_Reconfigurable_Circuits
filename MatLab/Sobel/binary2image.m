% funcao para decodificar resultados obtidos pela arquitetura de hardware
% do filtro Sobel para iamgem NxN. A imagem de saída fica sem as bordas
% superior e inferior, porem as bordas laterais continuam na imagem.

function [] = binary2image(imageFile, fileIn, imageWidth, imageHeight, pixelDepth)

clc
close all
%clear all

ImSize=imageWidth*imageHeight; % numero de pixels da imagem de saida

img = imread(imageFile); % board.tif
img = imresize((img),[imageWidth imageHeight]);

[ row col p ] =size(img);
if p == 3
    img = rgb2gray(img);
end
figure; imshow(img)

out_img_bin=textread(fileIn, '%s');
out_img_str=cell2mat(out_img_bin);
% s1=bin2dec(out_img_str);
s2=bin2dec(out_img_bin);
sync_h=0;
sync_v=1;
hw_sobel=255*ones(imageWidth, imageHeight);
for i=1:size(out_img_bin)
    if sync_h == imageWidth
        sync_v = sync_v+1;
        sync_h = 1;
    else
        sync_h = sync_h+1;
    end
    
    %hw_sobel(sync_v,sync_h)=bin2dec(out_img_str(i,:));
    %dec = dec + str2num(out_img_str(i,j)) * 2^(length(out_img_str(i,:)) - j);
    if out_img_str(i,1)=='1'
        s = strcat('11111',out_img_str(i,:));

    else
        s = strcat('00000',out_img_str(i,:));
    end
    dec = typecast(uint16(bin2dec(s)),'int16');
    if dec < 0
        hw_sobel(sync_v,sync_h)=0;
%     elseif dec>255
%         hw_sobel(sync_v,sync_h)=255;
    else
        hw_sobel(sync_v,sync_h)=dec; %uint8(dec);
    end
end
figure; 
imshow(hw_sobel)

