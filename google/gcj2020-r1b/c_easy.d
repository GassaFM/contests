// Author: Ivan Kazmenko (gassa@mail.ru)
module solution;
import std.algorithm;
import std.conv;
import std.math;
import std.numeric;
import std.range;
import std.stdio;
import std.string;
import std.typecons;

alias Pair = Tuple !(int, q{a}, int, q{b});

Pair [] solve (int r, int s)
{
	auto start = r.iota.repeat (s).joiner.array;
	auto finish = start.dup;
	sort (finish);
	debug {writeln (start);}
	debug {writeln (finish);}

	Pair [] [int []] m;
	m[start.idup] = null;
	int [] [] q;
	q ~= start;
	while (true)
	{
		auto cur = q.front;
		if (cur == finish)
		{
			break;
		}
		debug {writeln (cur);}
		q.popFront ();
		q.assumeSafeAppend ();
		foreach (a; 1..r * s)
		{
			foreach (b; 1..r * s - a + 1)
			{
				auto next = cur[a..a + b] ~ cur[0..a] ~
				    cur[a + b..$];
				if (next !in m)
				{
					m[next.idup] = m[cur] ~ Pair (a, b);
					q ~= next;
				}
			}
		}
	}
	return m[finish.idup];
}

void main ()
{
	int tests;
	readf (" %s", &tests);
	readln;
	foreach (test; 0..tests)
	{
		int r, s;
		readf (" %s %s", &r, &s);
		auto path = solve (r, s);
		writeln ("Case #", test + 1, ": ", path.length);
		foreach (ref line; path)
		{
			writeln (line[0], " ", line[1]);
		}
	}
}
