MATRIXSIZE = 3;

A = sym('A%d%d', [MATRIXSIZE MATRIXSIZE]);
A = reshape(A, 1, MATRIXSIZE*MATRIXSIZE);
B = sym('B%d%d', [MATRIXSIZE MATRIXSIZE]);
B = reshape(B, 1, MATRIXSIZE*MATRIXSIZE);

C = sym('C%d', [1 MATRIXSIZE*MATRIXSIZE*(MATRIXSIZE+1)]);

for k = 1:MATRIXSIZE
    for i = 1:MATRIXSIZE
        for j = 1:MATRIXSIZE
            C(((k-1)*MATRIXSIZE + (i-1))*MATRIXSIZE + j) = A((i-1)*MATRIXSIZE + k) * B((k-1)*MATRIXSIZE + j);
        end
    end
end

Z = sym('Z%d%d', [MATRIXSIZE MATRIXSIZE]);
Z = reshape(Z, 1, MATRIXSIZE*MATRIXSIZE);
for k = 1:MATRIXSIZE
    for i = 1:MATRIXSIZE
        for j = 1:MATRIXSIZE
            
            
%             if (k == 1)
%                 Z((i-1)*MATRIXSIZE + j) = 0 + C(((k-1)*MATRIXSIZE + (i-1))*MATRIXSIZE + j)
%             else
%                 Z((i-1)*MATRIXSIZE + j) = Z((i-1)*MATRIXSIZE + j) + C(((k-1)*MATRIXSIZE + (i-1))*MATRIXSIZE + j);
%             end
%             Z((i-1)*MATRIXSIZE + j) = C(((k-1)*MATRIXSIZE + (i-1))*MATRIXSIZE + j) + C(((k)*MATRIXSIZE + (i-1))*MATRIXSIZE + j);
        end
    end
end

disp(Z)




