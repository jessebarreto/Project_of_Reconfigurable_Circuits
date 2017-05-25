    % Esta funcao cria N vetores de teste em ponto flutuante 
    % para as matrices A y B de 2x2
    % A faixa de valores esta entre [-100.0, 100.0]
function [] = rom_matrixmul(matrixSize, beginRange, endRange, N, EW, FW)
    
    % Check number of inputs.
    if nargin > 6
        error('myfuns:somefun2:TooManyInputs', ...
            'requires at most 0 optional inputs');
    elseif nargin < 1
        beginRange = -100;
        endRange =  100;
        N = 100; % numero de vetores de teste aleatorios
        EW = 8; % tamanho do expoente 
        FW = 18; % tamanho da mantissa 
        matrixSize = 2; % Matrix Size
    elseif nargin < 2
        beginRange = -100;
        endRange =  100;
        N = 100; % numero de vetores de teste aleatorios
        EW = 8; % tamanho do expoente 
        FW = 18; % tamanho da mantissa
    end

    fileNamesFloatsA = [];
    fileNamesFloatsB = [];
    floatsA = [];
    floatsB = [];

    fileNamesBinsA = [];
    fileNamesBinsB = [];
    binsA = [];
    binsB = [];
    
    rand('twister',06111991);
    for row = 1:matrixSize
       for col = 1:matrixSize
          fileNameA = sprintf('floatA%d%d.txt', row, col);
          fileNamesFloatsA = [fileNamesFloatsA fileNameA];
          fileNameB = sprintf('floatB%d%d.txt', row, col);
          fileNamesFloatsB = [fileNamesFloatsB fileNameB];
          
          floatA = fopen(fileNameA,'w');
          floatsA = [floatsA floatA];
          floatB = fopen(fileNameB,'w');
          floatsB = [floatsB floatB];
          
          fileNameBinA = sprintf('binA%d%d.txt', row, col);
          fileNamesBinsA = [fileNamesBinsA fileNameBinA];
          fileNameBinB = sprintf('binB%d%d.txt', row, col);
          fileNamesBinsB = [fileNamesBinsB fileNameBinB];
          
          binA = fopen(fileNameBinA,'w');
          binsA = [binsA binA];
          binB = fopen(fileNameBinB,'w');
          binsB = [binsB binB];
          
          for i=1:N
              a = (endRange - beginRange)*(rand()-0.5);
              b = (endRange - beginRange)*(rand()-0.5);
              
              aBin = float2bin(EW, FW, a);
              bBin = float2bin(EW, FW, b);
              
              fprintf(floatA, '%f\n', a);
              fprintf(floatB, '%f\n', b);
              
              fprintf(binA, '%s\n', aBin);
              fprintf(binB, '%s\n', bBin);
          end
          
          fclose(floatA);
          fclose(floatB);
          
          fclose(binA);
          fclose(binB);
       end
    end
end