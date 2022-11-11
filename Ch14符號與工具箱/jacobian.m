clear;clc;close;
syms x y z real
f = [x*y*z y x+z]';
v = [x y z]';
J = jacobian(f,v)