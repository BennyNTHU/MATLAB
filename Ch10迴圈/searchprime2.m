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
fprintf('���j��%d����Ʀp�U:\n', nMAX)
fprintf('%3d', m)
fprintf('\n\n�{������ɶ���: \n')
toc
