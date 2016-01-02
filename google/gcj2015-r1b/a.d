import std.algorithm, std.conv, std.range, std.stdio;

long solve (long n)
{
	long res = 0;
	while (n > 9)
	{
		auto s = to !(string) (n);
		auto total = s.length;
		auto half = total / 2;
		auto value = to !(long) (s[half..total]);
		auto t = s.dup;
		t[half..total] = '0';
		t[$ - 1] = '1';
		auto r = t.retro.to !(string);
		if (value == 0 || r >= t)
		{
			n -= value + 1;
			res += value + 1;
		}
		else
		{
			res += value;
			n = r.to !(long);
		}
	}
	return res + n;
}

void doCase (int test)
{
	long n;
	readf (" %s", &n);
	long res = solve (n);
	writeln ("Case #", test, ": ", res);
}

void main ()
{
	int tests;
	readf (" %s", &tests);
	foreach (test; 0..tests)
	{
		doCase (test + 1);
	}
}
