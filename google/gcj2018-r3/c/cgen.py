import random
random.seed (2136236)
t = 100
n = 1000
print t
for tt in range (t):
	print n
	for i in range (n):
		x = random.randint (-(10 ** 6), +(10 ** 6))
		y = random.randint (-(10 ** 6), +(10 ** 6))
		z = random.randint (1, +(10 ** 6))
		print x, y, z
