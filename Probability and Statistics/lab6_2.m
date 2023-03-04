pkg load statistics

pr = [22.4 21.7 24.5 23.4 21.6 23.3 22.4 21.6 24.8 20.0];
rg = [17.7 14.8 19.6 19.6 12.1 14.8 15.4 12.6 14.0 12.2];

alpha = 0.05;

n1 = columns(pr);
n2 = columns(rg);

m1 = mean(pr);
m2 = mean(rg);

v1 = var(pr);
v2 = var(rg);

#a)
[H, P, CI, STAT] = vartest2(pr, rg, 'alpha', alpha, 'tail', 'both');

f1 = finv(alpha/2, n1-1, n2-1);
f2 = finv(1-alpha/2, n1-1, n2-1);

fprintf('(-inf, %1.2f)U(%1.2f, inf)\n', f1, f2);
fprintf('\n The value of the statistic = %1.2f', STAT.fstat);
fprintf('\n The p-value = %1.2f\n', P);

#if H == 1
#  fprintf('\nH is rejected\n');
#else
#  fprintf('H is not rejected\n');
#end

#b)

[H, P, CI, STAT] = ttest2(pr, rg, 'alpha', alpha, 'tail', 'right');
f1 = tinv(1-alpha, n1+n2-2);

fprintf('(%1.2f, inf)\n', f1);
fprintf('\n The value of the statistic = %1.2f', STAT.tstat);
fprintf('\n The p-value = %1.2f\n', P);

if H == 1
  fprintf('\nH is rejected\n');
else
  fprintf('H is not rejected\n');
end
