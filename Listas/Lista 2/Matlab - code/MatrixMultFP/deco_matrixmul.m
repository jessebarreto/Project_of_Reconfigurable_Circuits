

% funcao para decodificar resultados obtidos pela arquitetura de hardware
% da multiplicacao matricial 2x2 com N amostras
% Estima o MSE usando Matlab como estimador estatistico

function [] = deco_matrixmul(matrixSize, N, EW, FW)
    % Check number of inputs.
    if nargin > 6
        error('myfuns:somefun2:TooManyInputs', ...
            'requires at most 0 optional inputs');
    elseif nargin < 1
        N = 45; % numero de vetores de teste aleatorios
        EW = 8; % tamanho do expoente 
        FW = 18; % tamanho da mantissa 
        matrixSize = 2; % Matrix Size
    elseif nargin < 2
        N = 45; % numero de vetores de teste aleatorios
        EW = 8; % tamanho do expoente 
        FW = 18; % tamanho da mantissa
    end

    result_hw = zeros(N, matrixSize*matrixSize);
    result_sw = zeros(N, matrixSize*matrixSize);
    
    binsZ = [];
    floatsA = [];
    floatsB = [];
    
    for row = 1:matrixSize
        for col = 1:matrixSize
            fileNameBinZ = sprintf('binZ%d%d.txt', row, col);
            fileNameFloatA = sprintf('floatA%d%d.txt', row, col);
            fileNameFloatB = sprintf('floatB%d%d.txt', row, col);
            
            binZ = textread(fileNameBinZ, '%s');
            floatA = textread(fileNameFloatA, '%f');
            floatB = textread(fileNameFloatB, '%f');
            
            binsZ = [binsZ binZ];
            floatsA = [floatsA floatA];
            floatsB = [floatsB floatB];
        end
    end
    
    
    for i=1:N-1
        A = [];
        B = [];
        for j=1:matrixSize*matrixSize
            result_hw(i,j)=bin2float(cell2mat(binsZ(i, j)),EW,FW);
            A = [A floatsA(i, j)];
            B = [B floatsB(i, j)];
        end
        
        A = vec2mat(A, matrixSize);
        B = vec2mat(B, matrixSize);
        
        sw  = A*B;
        for row=1:matrixSize
            for col=1:matrixSize
                result_sw(i,(row-1) * matrixSize + col) = sw(row, col);
            end
        end
        
        erro(i) = sum((result_hw(i,:) - result_sw(i,:)).^2);
    end

    result_hw(1:5,:)
    result_sw(1:5,:)
    MSE = sum(erro)/N
    plot(erro)
end

