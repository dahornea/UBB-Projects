pkg load statistics

#a)

x=[1001.7,975.0,978.3,988.3,978.7,988.9,1000.3,979.2,968.9,983.5,999.2,985.6];
n=columns(x);
averageOfX = mean(x);

fprintf('\n Part a.\n')
alpha=0.05;
m0 = 995;

[H, P, CI, stat] = ttest(x, m0, "alpha",alpha,"tail","right")

if H == 0
	fprintf("The null hypothesis is accepted\n")
else
	fprintf("The null hypothesis is rejected\n")
end

q = tinv(alpha, n - 1);


fprintf("\nThe rejection region is (%6.4f, %6.4f).\n", q, inf)
fprintf("The confidence interval is (%4.4f,%4.4f).\n", CI)
fprintf("The value of the test statistic is %6.4f.\n", stat.tstat)
fprintf("The P-value for the variances test is %6.4f.\n", P)

#b)

fprintf('\n Part b.\n')
confidence=0.99
alpha = 1-confidence;


standardDeviationOfX = std(x);

o1 = (n-1)*standardDeviationOfX*standardDeviationOfX/chi2inv(1-alpha/2, n-1)
o2 = (n-1)*standardDeviationOfX*standardDeviationOfX/chi2inv(alpha/2, n-1)

s1 = sqrt(o1);
s2 = sqrt(o2);

fprintf("The interval is (%f, %f)\n", s1, s2)
