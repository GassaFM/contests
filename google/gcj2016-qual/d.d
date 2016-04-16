import std.stdio;

auto scan (T...) (ref T args)
{
	static if (T.length > 0)
	{
		return (readf (" %s", &args[0]) == 1) && scan (args[1..$]);
	}
	else
	{
		return true;
	}
}

void solve (int test)
{
	int k, c, s;
	scan (k, c, s);
	long [] v;
	int i = 0;
	while (i < k)
	{
		long w = 0;
		foreach (j; 0..c)
		{
			w = w * k + i;
			i++;
			if (i >= k)
			{
				break;
			}
		}
		v ~= w + 1;
	}
	write ("Case #", test + 1, ": ");
	if (v.length <= s)
	{
		writefln ("%(%s %)", v);
	}
	else
	{
		writeln ("IMPOSSIBLE");
	}
}

void main ()
{
	int tests;
	scan (tests);
	foreach (test; 0..tests)
	{
		solve (test);
	}
}
