

% funcao para decodificar resultados obtidos pela arquitetura de hardware
% da multiplicacao matricial 2x2 com N amostras
% Estima o MSE usando Matlab como estimador estatistico

function [] = deco_prova(N, EW, FW)
    % Check number of inputs.
    if nargin > 3
        error('myfuns:somefun2:TooManyInputs', ...
            'requires at most 0 optional inputs');
    elseif nargin < 1
        N = 9; % numero de vetores de teste aleatorios
        EW = 8; % tamanho do expoente 
        FW = 18; % tamanho da mantissa 
    elseif nargin < 2
        EW = 8; % tamanho do expoente 
        FW = 18; % tamanho da mantissa
    end

    result_hw_dist = zeros(N, 3);
    result_sw_dist = zeros(N, 3);
    
    binXFusao = textread('binXFusao.txt', '%s');
    binXUl = textread('binXUl.txt', '%s');
    binXIr = textread('binXIr.txt', '%s');
    floatYUl = textread('floatYUl.txt', '%f');
    floatYIr = textread('floatYIr.txt', '%f');
    initCovK = textread('floatInitCovK.txt', '%f');
    initCovZ = textread('floatInitCovZ.txt', '%f');
    
    covK = initCovK;
    
    for i=1:N-1
        result_hw_dist(i, 1) =  bin2float(cell2mat(binXUl(i)),EW,FW);
        result_hw_dist(i, 2) =  bin2float(cell2mat(binXIr(i)),EW,FW);
        result_hw_dist(i, 3) =  bin2float(cell2mat(binXFusao(i)),EW,FW);
        
        yUl = floatYUl(i);
        yIr = floatYIr(i);
        
        swXUl = 1.3*yUl + 2;
        swXIr = 0.0012*yIr*yIr - 0.89*yIr + 127;
        
        Gk_1 = covK / (covK + initCovZ);
        covK = covK - Gk_1*covK;
        swXFusao = swXUl + Gk_1 * (swXIr - swXUl);
        
        result_sw_dist(i, 1) = swXUl;
        result_sw_dist(i, 2) = swXIr;
        result_sw_dist(i, 3) = swXFusao;
        
        erro(i) = sum((result_hw_dist(i,:) - result_sw_dist(i,:)).^2);
    end
    disp('Hardware')
    result_hw_dist(1:5,:)
    disp('MatLab')
    result_sw_dist(1:5,:)
    MSE = sum(erro)/N
    plot(erro)
end

