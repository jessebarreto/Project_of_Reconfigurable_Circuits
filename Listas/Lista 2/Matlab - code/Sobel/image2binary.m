function [] = image2bin(imageFile, imageWidth, imageHeight, pixelDepth, fileOut)
    % Image to text conversion
    % Read the image from the file
     %[filename, pathname] = uigetfile('*.bmp;*.tif;*.jpg;*.pgm','Pick an M-file');
    close all
    clc
    
    img = imread(imageFile);
    img = imresize((img),[imageWidth imageHeight]);

    [ row col p ] =size(img);
    if p == 3
        img = rgb2gray(img);
    end
    imshow(img)

    % noise add
    % rectImg = img(16:80,16:80);
    % rectImg = imnoise(rectImg,'salt & pepper', 0.02);
    % img(16:80,16:80) = rectImg;

    % Image Transpose
    imgTrans = img';
    
    % iD conversion
    img1D = imgTrans(:);
    % Decimal to Hex value conversion
    imgHex = dec2hex(img1D);
    imgBin = dec2bin(img1D,pixelDepth);
    % New txt file creation
    fid = fopen(fileOut, 'wt'); %board
    % value write to the txt file
    for i=1:size(img1D)
        fprintf(fid, '%s\n', imgBin(i,:));
    end
    % Close the txt file
    fclose(fid)
end