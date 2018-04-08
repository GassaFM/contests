t = 100
n = 100000
print t
for r in range (t):
	print n
	print ' '.join (map (str, [10 ** 9 - n + i for i in range (n)]))
