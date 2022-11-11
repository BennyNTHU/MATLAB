clc;clear;close;

x = linspace(0, 10);
y1 = 100 * exp(-x/2).*cos(2*x);
y2 = cos(x).*sin(2*x);
ax = plotyy(x,y1,x,y2); %繪製兩個不同y軸刻度的指令
xlabel('x')
ylabel(ax(1), 'y_1')    %設定左邊y軸
ylabel(ax(2), 'y_2')    %設定右邊y軸
title('plotyy繪圖展示')
legend('y_1','y_2') %圖例