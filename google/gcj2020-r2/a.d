module solution;
import std.algorithm;
import std.stdio;

immutable int limit = 2_000_000_000;

long sumAP (long a, long d, long k)
{
	return (a * 2 + d * (k - 1)) * k / 2;
}

long go (long threshold)
{
	long lo = 0;
	long hi = limit;
	while (lo < hi)
	{
		long me = (lo + hi + 1) / 2;
		if (sumAP (1, 1, me) <= threshold)
		{
			lo = me;
		}
		else
		{
			hi = me - 1;
		}
	}
	return lo;
}

long proceed (long start, long a, long b)
{
	long lo = 0;
	long hi = limit;
	while (lo < hi)
	{
		long me = (lo + hi + 1) / 2;
		bool ok = true;
		if (a >= b)
		{
			ok &= (sumAP (start + 1, 2, me) <= a);
			ok &= (sumAP (start + 2, 2, me) <= b);
		}
		else
		{
			ok &= (sumAP (start + 1, 2, me) <= b);
			ok &= (sumAP (start + 2, 2, me) <= a);
		}
		if (ok)
		{
			lo = me;
		}
		else
		{
			hi = me - 1;
		}
	}
	return lo;
}

void main ()
{
	int tests;
	readf (" %s", &tests);
	readln;
	foreach (test; 0..tests)
	{
		long a, b;
		readf (" %s %s", &a, &b);

		long start = go (max (a - b, b - a));
		if (a >= b)
		{
			a -= sumAP (1, 1, start);
		}
		else
		{
			b -= sumAP (1, 1, start);
		}

		long pairs = proceed (start, a, b);
		if (a >= b)
		{
			a -= sumAP (start + 1, 2, pairs);
			b -= sumAP (start + 2, 2, pairs);
		}
		else
		{
			b -= sumAP (start + 1, 2, pairs);
			a -= sumAP (start + 2, 2, pairs);
		}

		long n = start + pairs * 2;
		if (a >= b)
		{
			if (a >= n + 1)
			{
				n += 1;
				a -= n;
			}
		}
		else
		{
			if (b >= n + 1)
			{
				n += 1;
				b -= n;
			}
		}

		write ("Case #", test + 1, ": ");
		writeln (n, " ", a, " ", b);
	}
}
