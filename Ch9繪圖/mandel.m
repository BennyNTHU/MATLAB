clc;clear;close all;
m=100;
n=50;
x=linspace(-2,1,m);
y=linspace(-1.5,1.5,m);
[X,Y]=meshgrid(x,y);
C=X+i*Y;
Z=zeros(m,m);
Zn=Z;
for k=1:n
    Zn=Zn.*Zn+C;
    Z=Z+(abs(Zn)<2);
end
surf(X,Y,Z);
view(2)