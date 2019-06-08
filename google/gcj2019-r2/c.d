module solution;
import std.algorithm;
import std.format;
import std.range;
import std.stdio;

struct Slope
{
	int a;
	int b;
}

string solveInstance ()
{
	int n;
	readf (" %s", &n);
	auto p = new Slope [n];
	foreach (ref c; p)
	{
		readf (" %s %s", &c.a, &c.b);
	}

	foreach (i; 1..201)
	{
		foreach (j; 1..201)
		{
			auto v = p.map !(c => c.a * i + c.b * j).array;
			if (zip (v, v.drop (1))
			    .map !(q{a[1] - a[0]})
			    .all !(q{a > 0}))
			{
				return format ("%d %d", i, j);
			}
		}
	}
	return "IMPOSSIBLE";
}

void main ()
{
	int tests;
	readf (" %s", &tests);
	readln;
	foreach (test; 0..tests)
	{
		writeln ("Case #", test + 1, ": ", solveInstance ());
	}
}
