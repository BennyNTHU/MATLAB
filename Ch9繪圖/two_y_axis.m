clc;clear;close;

x = linspace(0, 10);
y1 = 100 * exp(-x/2).*cos(2*x);
y2 = cos(x).*sin(2*x);
ax = plotyy(x,y1,x,y2); %ø�s��Ӥ��Py�b��ת����O
xlabel('x')
ylabel(ax(1), 'y_1')    %�]�w����y�b
ylabel(ax(2), 'y_2')    %�]�w�k��y�b
title('plotyyø�Ϯi��')
legend('y_1','y_2') %�Ϩ�