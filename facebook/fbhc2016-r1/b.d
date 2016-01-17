import std.algorithm;
import std.container;
import std.conv;
import std.range;
import std.stdio;
import std.string;
import std.typecons;

alias Machine = Tuple !(long, q{start}, int, q{delta});

void main ()
{
	int tests;
	readf (" %s", &tests);
	foreach (test; 0..tests)
	{
		int l, n, m, d;
		readf (" %s %s %s %s ", &l, &n, &m, &d);
		auto w = readln.split.map !(to !(int)).array;

		auto m1 = w.map !(x => Machine (0, x)).array;
		auto b1 = m1.heapify
		    !((x, y) => x.start + x.delta > y.start + y.delta);
		long [] t;
		foreach (i; 0..l)
		{
			auto p = b1.front;
			long cur = p.start + p.delta;
			b1.replaceFront (Machine (cur, p.delta));
			t ~= cur;
		}

		auto m2 = min (l, m).iota.map !(x => Machine (0, d)).array;
		auto b2 = m2.heapify
		    !((x, y) => x.start + x.delta > y.start + y.delta);
		long res = 0;
		foreach (i; 0..l)
		{
			auto p = b2.front;
			long cur = max (t[i], p.start) + p.delta;
			b2.replaceFront (Machine (cur, p.delta));
			res = max (res, cur);
		}
		writeln ("Case #", test + 1, ": ", res);
	}
}
