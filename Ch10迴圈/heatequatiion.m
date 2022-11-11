clear;close;clc;

x = linspace(0,1,101);
t = linspace(0,1,101);
i = 0;
j = 0;
k = 0;
n = 0;
T = zeros(101);

for i = 1:101
    for j = 1:101
        for n = 1:10000
            T(i,j) = T(i,j) + sin(n*pi/2)*sin(n*pi*x(j))*exp(-n^2*pi^2*t(i))/n^2;
        end
        T(i,j) = T(i,j)*8/pi^2;
    end
    
    if rem(i, 10) == 0
        figure(1)
        title('Solution of heat equation in 2D')
        plot(x,T(i,:));
        xlabel('x')
        ylabel('T')
        hold on
    end
end
hold off

figure(2)
title('Solution of heat equation in 3D')
meshc(x,t,T);
xlabel('x')
ylabel('t')
zlabel('T')
