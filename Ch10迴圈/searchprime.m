clear;clc;close;

nMAX = 90000;
n = 0;
fprintf('���j��%d����Ʀp�U:\n', nMAX)
tic
while 1
    n = n+1;
    if n < nMAX
        if isprime(n)
            fprintf('%3d', n)
        end
    else
        break
    end
end
fprintf('\n\n�{������ɶ���: \n')
toc
