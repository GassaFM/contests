import sys

tests = int (sys.stdin.readline ().strip ())
for test in range (tests):
	n = int (sys.stdin.readline ().strip ())
	a = list (map (int, sys.stdin.readline ().split ()))
	a[::2] = sorted (a[::2])
	a[1::2] = sorted (a[1::2])
	b = sorted (a)
	res = 'OK'
	for i in range (n):
		if a[i] != b[i]:
			res = i
			break
	sys.stdout.write (str (res) + '\n')
