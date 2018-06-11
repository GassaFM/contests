import sys

def solve ():
	r, c, h, v = map (int, sys.stdin.readline ().split ())
	t = [sys.stdin.readline ().strip () for i in range (r)]
	s = [[0 for j in range (c + 1)] for i in range (r + 1)]

	def num (i1, j1, i2, j2):
		return s[i2][j2] - s[i1][j2] - s[i2][j1] + s[i1][j1]

	for i in range (r):
		for j in range (c):
			s[i + 1][j + 1] = s[i][j + 1] + \
			    s[i + 1][j] - s[i][j] + (t[i][j] == '@')

#	for i in range (r + 1):
#		print s[i]

	if s[r][c] == 0:
		return True

	d = (h + 1) * (v + 1)
	if s[r][c] % d != 0:
		return False

	y = s[r][c] // (h + 1)
	p = 0
	a = [0]
	for i in range (1, r + 1):
		cur = num (p, 0, i, c)
		if cur > y:
			return False
		if cur == y:
			a += [i]
			p = i
	assert len (a) == h + 2

	x = s[r][c] // (v + 1)
	q = 0
	b = [0]
	for j in range (1, c + 1):
		cur = num (0, q, r, j)
		if cur > x:
			return False
		if cur == x:
			b += [j]
			q = j
	assert len (b) == v + 2

	piece = s[r][c] // d
	for i in range (h + 1):
		for j in range (v + 1):
			if num (a[i], b[j], a[i + 1], b[j + 1]) != piece:
				return False

	return True

tests = int (sys.stdin.readline ())
for test in range (tests):
	res = solve ()
	if res:
		ans = 'POSSIBLE'
	else:
		ans = 'IMPOSSIBLE'
	sys.stdout.write ('Case #' + str (test + 1) + ': ' + ans + '\n')
