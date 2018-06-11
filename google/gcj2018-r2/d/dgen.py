import random
random.seed (21626)

tests = 100
print tests
for test in range (tests):
	rows = 20
	cols = 20
	print rows, cols
	for row in range (rows):
		s = ''
		for col in range (cols):
			s += 'BW'[random.randrange (2)]
		print s
