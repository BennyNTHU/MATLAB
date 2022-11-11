clear;clc;close;

nMAX = 90000;
n = 0;
fprintf('不大於%d的質數如下:\n', nMAX)
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
fprintf('\n\n程式執行時間為: \n')
toc
