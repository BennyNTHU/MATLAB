clear; clc; close all;
tau = 1;
t = linspace(0, 20);

zeta = 0.1;
y1 = 1-1/sqrt(1-zeta^2)*exp(-zeta*t/tau).*sin(sqrt(1-zeta^2)*t/tau+...
    atan(sqrt(1-zeta^2)/zeta));
plot(t,y1,'-.r')
hold on %疊圖

zeta = 0.5
y2 = 1-1/sqrt(1-zeta^2)*exp(-zeta*t/tau).*sin(sqrt(1-zeta^2)*t/tau+...
    atan(sqrt(1-zeta^2)/zeta));
plot(t, y2, '-g')
hold off %取消疊圖

%設定標題
title('不同zeta值之響應比較圖')
xlabel('t');
ylable('應答輸出y')
gtext('\zeta = 0.1')    %在滑鼠指定位置列印指定文字
text(9,1,'\zeta = 0.5')    %在(9,1)列印指定文字
