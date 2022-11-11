clear;clc;close;

w = logspace(-3,3); %-3到3之中等比例取預設50點,並通通取10的次方

F = 3./(2*w*j+1);
Amp = abs(F);
theta = angle(F)*180/pi;

ax = plotyy(w,Amp,w,theta,'loglog','semilogx'); %第一組數據xy軸都是對數尺標
%第二組數據x座標為對數

title('複變函數振福與相角圖')
xlabel('頻率')
ylabel(ax(1), '振幅')
ylabel(ax(2), '相角')