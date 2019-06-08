import fractions, sys
tests = int (sys.stdin.readline ().strip ())
for test in range (tests):
	n, k = map (int, sys.stdin.readline ().split ())
	a = list (map (int, sys.stdin.readline ().split ()))
	v = []
	prev = a[0]
	for i in range (1, k):
		if a[i] != prev:
			next = a[i]
			p = fractions.gcd (prev, next)
			v += [p, prev // p, next // p]
			prev = next
	v = list (set (v))
	v.sort ()
#	print (v)
	mtab = [[x * y for y in v] for x in v]
	c = [['*', '*'] for i in range (k)]
	for i in range (k):
		for x in range (26):
			for y in range (26):
				if mtab[x][y] == a[i]:
					c[i] = [x, y]
	r = ['?' for i in range (k + 1)]
	for j in range (k + 1):
		for i in range (1, k):
			if (c[i][0] == c[i - 1][0]) and (c[i - 1][1] != c[i][1]):
				r[i] = c[i][0]
			if (c[i][0] == c[i - 1][1]) and (c[i - 1][0] != c[i][1]):
				r[i] = c[i][0]
			if (c[i][1] == c[i - 1][0]) and (c[i - 1][1] != c[i][0]):
				r[i] = c[i][1]
			if (c[i][1] == c[i - 1][1]) and (c[i - 1][0] != c[i][0]):
				r[i] = c[i][1]
		for i in range (k):
			if r[i] == c[i][0]:
				r[i + 1] = c[i][1]
			if r[i] == c[i][1]:
				r[i + 1] = c[i][0]
			if r[i + 1] == c[i][0]:
				r[i] = c[i][1]
			if r[i + 1] == c[i][1]:
				r[i] = c[i][0]
	print ('Case #' + str (test + 1) + ': ' + \
	    ''.join ('ABCDEFGHIJKLMNOPQRSTUVWXYZ'[x] for x in r))
