clear;clc;close;

w = logspace(-3,3); %-3��3��������Ҩ��w�]50�I,�óq�q��10������

F = 3./(2*w*j+1);
Amp = abs(F);
theta = angle(F)*180/pi;

ax = plotyy(w,Amp,w,theta,'loglog','semilogx'); %�Ĥ@�ռƾ�xy�b���O��Ƥؼ�
%�ĤG�ռƾ�x�y�Ь����

title('���ܨ�Ʈ��ֻP�ۨ���')
xlabel('�W�v')
ylabel(ax(1), '���T')
ylabel(ax(2), '�ۨ�')