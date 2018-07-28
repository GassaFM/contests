import random
random.seed (26932486)

t = 75
print t
for i in range (t):
	n = 3000
	a = [random.randrange (1, 1000000) for i in range (n - 1)]
	b = [random.randrange (1, 1000000) for i in range (n - 1)]
	for k in range (n - 1):
		a[k], b[k] = min (a[k], b[k]), max (a[k], b[k])
	m = 3000
	y = list (range (1, n + 1))
	random.shuffle (y)
	h = [random.randrange (1, 1000000) for i in range (n)]
	print n, m
	for k in range (n - 1):
		print a[k], b[k]
	for j in range (m):
		print y[j], h[j]
