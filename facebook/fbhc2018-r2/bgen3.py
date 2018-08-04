import random
random.seed (26236)

t = 20
print t
for tt in range (t):
	n = 200000
	m = 1000000
	a = random.randrange (n)
	b = random.randrange (n)
	print n, m, a, b
	for i in range (n - 1):
		print i // 2
