clear; clc; close all;
tau = 1;
t = linspace(0, 20);

zeta = 0.1;
y1 = 1-1/sqrt(1-zeta^2)*exp(-zeta*t/tau).*sin(sqrt(1-zeta^2)*t/tau+...
    atan(sqrt(1-zeta^2)/zeta));
plot(t,y1,'-.r')
hold on %�|��

zeta = 0.5
y2 = 1-1/sqrt(1-zeta^2)*exp(-zeta*t/tau).*sin(sqrt(1-zeta^2)*t/tau+...
    atan(sqrt(1-zeta^2)/zeta));
plot(t, y2, '-g')
hold off %�����|��

%�]�w���D
title('���Pzeta�Ȥ��T�������')
xlabel('t');
ylable('������Xy')
gtext('\zeta = 0.1')    %�b�ƹ����w��m�C�L���w��r
text(9,1,'\zeta = 0.5')    %�b(9,1)�C�L���w��r
