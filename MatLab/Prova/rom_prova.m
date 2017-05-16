    % Esta funcao cria N vetores de teste em ponto flutuante 
    % para a Prova
    % A faixa de valores esta entre [-100.0, 100.0]
function [] = rom_prova(N, EW, FW)
    
    % Check number of inputs.
    if nargin > 3
        error('myfuns:somefun2:TooManyInputs', ...
            'requires at most 0 optional inputs');
    elseif nargin < 1
        N = 100; % numero de vetores de teste aleatorios
        EW = 8; % tamanho do expoente 
        FW = 18; % tamanho da mantissa 
    elseif nargin < 2
        EW = 8; % tamanho do expoente 
        FW = 18; % tamanho da mantissa
    end

    beginRange = 0.01; %V
    endRange = 3.3; %V
    
    floatYUl = fopen('floatYUl.txt', 'w'); 
    floatYIr = fopen('floatYIr.txt', 'w');
    floatInitCovK = fopen('floatInitCovK.txt', 'w');
    floatInitCovZ = fopen('floatInitCovZ.txt', 'w');
    
    binYUl = fopen('binYUl.txt', 'w'); 
    binYIr = fopen('binYIr.txt', 'w');
    
    rand('twister',170067033);
    
    binInitCovK = fopen('binInitCovK.txt', 'w');
    binInitCovZ = fopen('binInitCovZ.txt', 'w');
    initCovK = (.5 - 0)*(rand());
    initCovZ = (1 - .5)*(rand()) + .5;
    
    initCovKBin = float2bin(EW, FW, initCovK);
    initCovZBin = float2bin(EW, FW, initCovZ);
    
    fprintf(floatInitCovK, '%f\n', initCovK);
    fprintf(floatInitCovZ, '%f\n', initCovZ);
    
    fprintf(binInitCovK, '%s\n', initCovKBin);
    fprintf(binInitCovZ, '%s\n', initCovZBin);
    
    for i=1:N
      yUl = (endRange - beginRange)*(rand()) + beginRange;
      yIr = (endRange - beginRange)*(rand()) + beginRange;

      yUlBin = float2bin(EW, FW, yUl);
      yIrBin = float2bin(EW, FW, yIr);

      fprintf(floatYUl, '%f\n', yUl);
      fprintf(floatYIr, '%f\n', yIr);

      fprintf(binYUl, '%s\n', yUlBin);
      fprintf(binYIr, '%s\n', yIrBin);
    end

    fclose(floatYUl);
    fclose(floatYIr);

    fclose(binYUl);
    fclose(binYIr);
    
    fclose(floatInitCovK);
    fclose(floatInitCovZ);
    
    fclose(binInitCovK);
    fclose(binInitCovZ);
end