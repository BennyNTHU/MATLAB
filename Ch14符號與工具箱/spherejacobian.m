syms r u w real

x = r*cos(u)*cos(w);
y = r*cos(u)*sin(w);
z = r*sin(u);

f = [x y z]';
v = [r u w]';
J = jacobian(f,v)