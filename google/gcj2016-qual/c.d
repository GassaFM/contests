import std.algorithm;
import std.bigint;
import std.conv;
import std.random;
import std.range;
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
	int n;
	int j;
	scan (n, j);

	writeln ("Case #", test + 1, ":");
	int [] [string] s;
	debug {int counter = 0;}
	while (s.length < j)
	{
		auto t = (n - 2).iota
		    .map !(_ => cast (char) (uniform (0, 2) + '0')).array.idup;
		t = '1' ~ t ~ '1';
		if (t in s)
		{
			continue;
		}
		int [] divs;
		foreach (base; 2..11)
		{
			auto v = BigInt (0);
			foreach (c; t)
			{
				v = v * base + (c - '0');
			}
			for (int d = 2; d < 101 && d * d <= v; d++)
			{
				if (v % d == 0)
				{
					divs ~= d;
					break;
				}
			}
		}
		debug {counter++;}
		if (divs.length == 9)
		{
			s[t] = divs;
		}
	}
	debug {writeln (counter);}
	foreach (key, value; s)
	{
		writefln ("%s %(%s %)", key, value);
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
