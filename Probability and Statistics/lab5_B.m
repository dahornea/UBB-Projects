pkg load statistics

pr = [22.4 21.7 24.5 23.4 21.6 23.3 22.4 21.6 24.8 20.0];
rg = [17.7 14.8 19.6 19.6 12.1 14.8 15.4 12.6 14.0 12.2];

mpr = mean(pr);
mrg = mean(rg);

n1 = length(pr);
n2 = length(rg);

s21 = var(pr);
s22 = var(rg);

s2p = ((n1-1) * s21 + (n2-1) * s22)/(n1+n2-2);

sp = sqrt(((n1-1) * s21 + (n2-1) * s22)/(n1+n2-2));

u1 = mpr-mrg-tinv(1-alpha/2, n1+n2-2)*sp*sqrt(1/n1+1/n2);
u2 = mpr-mrg+tinv(1-alpha/2, n1+n2-2)*sp*sqrt(1/n1+1/n2);

c = s21/n1/(s21/n1 + s22/n2);
n = 1/(c*c/(n1-1) + (1-c)*(1-c)/(n2-1));

u1 = mpr - mrg - tinv(1 - alpha/2, n)*sqrt(s21/n1 + s22/n2);
u2 = mpr - mrg + tinv(1 - alpha/2, n)*sqrt(s21/n1 + s22/n2);

t1 = tinv(1 - alpha/2, n);

printf('t1 = %d\n', t1);
printf('c = %d\n', c);
printf('n = %d\n', n);
printf('u1 = %d\n', u1);
printf('u2 = %d\n', u2);

f1 = finv(1 - alpha/2, n1-1, n2 - 1);
f2 = finv(alpha / 2, n1-1, n2-1);

a1 = (1 / f1) * (s21 / s22);
a2 = (1 / f2) * (s21 / s22);

printf('a1 = %d\n', a1);
printf('a2 = %d\n', a2);
