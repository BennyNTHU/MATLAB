function p=polyadd(a,b)
na = length(a);
nb = length(b);
if na>nb
    p = a + [zeros(1,na-nb) b];
elseif na < nb
    p = [zeros(1,nb-na) a]+b;
else
    p = a+b;
end
