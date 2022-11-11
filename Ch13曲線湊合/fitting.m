clear;clc;close;

x = [2 5 7 1 4];
y = [1 2 4 0.6 6.7];
p = polyfit(x,y,4);
J = sum((polyval(p,x)-y).^2)

xp = linspace(0,6,100);
yp = polyval(p,xp);
plot(x, y, '*', xp, yp)
xlabel('x')
ylabel('y')
title('曲線湊合實況')
legend('數據', '湊合曲線')
