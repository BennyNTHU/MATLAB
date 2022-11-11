clear;clc;close;

nMAX = 50;
n = 1;
m = []
tic
while n < nMAX
   if isprime(n)
       m = [m n];
   end
   n = n+1;
end
fprintf('不大於%d的質數如下:\n', nMAX)
fprintf('%3d', m)
fprintf('\n\n程式執行時間為: \n')
toc
