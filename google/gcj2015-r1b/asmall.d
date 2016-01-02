import std.algorithm, std.conv, std.range, std.stdio;

int [] f;
int [] p;

void prepare ()
{
	int MAX = 1_000_000;
	f = new int [MAX + 1];
	p = new int [MAX + 1];
	f[1] = 1;
	foreach (i; 2..f.length)
	{
		f[i] = f[i - 1] + 1;
		p[i] = i - 1;
		auto j = i.to !(string).retro.array.to !(int);
		if (j < i && j.to !(string).retro.array.to !(int) == i)
		{
			if (f[i] > f[j] + 1)
			{
				f[i] = f[j] + 1;
				p[i] = j;
			}
		}
	}

	debug {foreach (i; 1..f.length) if (p[i] != i - 1)
	    {writefln ("%7d %7d %7d", i, p[i], f[i]);}}
}

void doCase (int test)
{
	long n;
	readf (" %s", &n);
	long res = f[cast (int) n];
	writeln ("Case #", test, ": ", res);
}

void main ()
{
	prepare ();

	int tests;
	readf (" %s", &tests);
	foreach (test; 0..tests)
	{
		doCase (test + 1);
	}
}
