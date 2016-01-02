import std.algorithm, std.container, std.stdio, std.typecons;

void doCase (int test)
{
	int n;
	readf (" %s", &n);

	int total = 0;
	alias Event = Tuple !(long, q{time}, int, q{delta}, long, q{add});
	auto events = heapify !(q{a > b}) (Array !(Event) ());
	foreach (i; 0..n)
	{
		int d, h, m;
		readf (" %s %s %s", &d, &h, &m);
		foreach (j; 0..h)
		{
			long t = m + j;
			events.insert (Event ((360 - d) * t, +1, 360 * t));
		}
		total += h;
	}

	int res = total;
	int left = total;
	int cur = total;
	while (res > cur - left)
	{
		auto v = events.front;
//		debug {writeln (v);}
		cur -= v.delta;
		res = min (res, cur);
		if (v.delta == +1)
		{
			left--;
		}

		v.time += v.add;
		v.delta = -1;
		events.replaceFront (v);
	}

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
