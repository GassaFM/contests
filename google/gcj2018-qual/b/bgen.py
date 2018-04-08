import random
random.seed (16263)

t = 100
n = 100000
print t
for r in range (t):
	print n
	print ' '.join (map (str, [random.randint (1, 10 ** 9) for i in range (n)]))
