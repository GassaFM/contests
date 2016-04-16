import std.algorithm;
import std.array;
import std.conv;
import std.stdio;
import std.string;

void solve (int test)
{
	auto n = readln.strip.to !(int);
	auto f = readln.split.map !(to !(int)).map !(q{a - 1}).array;

	auto p = new int [] [n];
	foreach (i; 0..n)
	{
		p[f[i]] ~= i;
	}

	int res = 0;

	// part 1: mutual friends

	int dfs (int v)
	{
		int res = 1;
		foreach (u; p[v])
		{
			if (u != f[v])
			{
				res = max (res, dfs (u) + 1);
			}
		}
		return res;
	}

	foreach (i; 0..n)
	{
		if (f[f[i]] == i)
		{
			debug {writeln ("+", dfs (i));}
			res += dfs (i);
		}
	}

	// part 2: long cycles
	foreach (i; 0..n)
	{
		auto b = new bool [n];
		b[] = false;
		int j = i;
		int len = 0;
		do
		{
			b[j] = true;
			j = f[j];
			len++;
		}
		while (!b[j]);
		if (j == i)
		{
			debug {writeln ("=", len);}
			res = max (res, len);
		}
	}

	writeln ("Case #", test + 1, ": ", res);
}

void main ()
{
	auto tests = readln.strip.to !(int);
	foreach (test; 0..tests)
	{
		solve (test);
	}
}
