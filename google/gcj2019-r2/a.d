module solution;
import std.algorithm;
import std.conv;
import std.range;
import std.stdio;

struct Slope
{
	int a;
	int b;

	bool opEquals () (const auto ref Slope that) const
	{
		return this.a * 1L * that.b == this.b * 1L * that.a;
	}

	int opCmp () (const auto ref Slope that) const
	{
		return (this.a * 1L * that.b > this.b * 1L * that.a) -
		       (this.a * 1L * that.b < this.b * 1L * that.a);
	}
}

int solveInstance ()
{
	int n;
	readf (" %s", &n);
	auto p = new Slope [n];
	foreach (ref c; p)
	{
		readf (" %s %s", &c.a, &c.b);
	}

	Slope [] d;
	foreach (i; 0..n)
	{
		foreach (j; 0..n)
		{
			if (p[i].a > p[j].a && p[j].b > p[i].b)
			{
				d ~= Slope (p[j].b - p[i].b, p[i].a - p[j].a);
			}
		}
	}
	sort (d);
	debug {writefln ("%d%(\n%s%)", d.length, d);}
	return 1 + d.uniq.walkLength.to !(int);
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
