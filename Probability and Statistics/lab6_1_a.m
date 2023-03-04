pkg load statistics

x = [7 7 4 5 9 9 4 12 8 1 8 7 3 13 2 1 17 7 12 5 6 2 1 13 14 10 2 4 9 11 3 5 12 6 10 7];

#a)

alpha = input('alpha=');
mew = input('m0=');
sigma = 5;

n = columns(x);

[H, P, CI, STAT] = ztest(x, mew, sigma, 'alpha', alpha, 'tail', 'left');

RR = [-inf, norminv(alpha)];

if H == 1
  fprintf('\nH is rejected\n');
else
  fprintf('H is not rejected\n');
end

fprintf('\n RR = (%1.2f, %1.2f)', RR);
fprintf('\n The value of the statistic = %1.2f', STAT);
fprintf('\n The p-value = %1.2f\n', P);

