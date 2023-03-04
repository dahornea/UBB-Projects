pkg load statistics

#2
#a)

p = input("Probability: ");
for n = 1:3:100;
  k = 0:n;
  probe = binopdf(k, n, p);
  plot(probe);
  pause(0.3);
end;

#b)

n = input('n = ');
p = input('p = ');
lambda = n * p;
k = 0:n;
p1 = poisspdf(k, lambda);
p2 = binopdf(k, n, p);
plot(k, p1, k, p2);
