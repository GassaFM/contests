import std.algorithm;
import std.conv;
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
	write ("Case #", test + 1, ": ");
	int n;
	scan (n);
	if (n == 0)
	{
		writeln ("INSOMNIA");
	}
	else
	{
		int [10] k;
		int cur = 0;
		while (!k[].all !(q{a > 0}))
		{
			cur += n;
			auto s = cur.text;
			foreach (c; s)
			{
				k[c - '0']++;
			}
		}
		writeln (cur);
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
