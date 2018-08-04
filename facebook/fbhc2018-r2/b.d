import std.algorithm;
import std.container;
import std.stdio;

long solve ()
{
	int n, m, a, b;
	readf (" %s %s %s %s", &n, &m, &a, &b);

	auto g = new int [] [n];
	foreach (j; 0..n - 1)
	{
		int u = j + 1;
		int v;
		readf (" %s", &v);
		g[v] ~= u;
	}

	auto d = new int [n];
	foreach (i; 0..m)
	{
		int c = (a * 1L * i + b) % n;
		d[c] += 1;
	}

	long res = 0;

	RedBlackTree !(int, q{a > b}) recur (int v)
	{
		auto s = redBlackTree !(q{a > b}, int) (v);
		foreach (u; g[v])
		{
			auto t = recur (u);
			if (s.length < t.length)
			{
				swap (s, t);
			}
			s.insert (t[]);
		}
		while (d[v] > 0 && !s.empty)
		{
			d[v] -= 1;
			res += s.front;
			s.removeFront ();
		}
		return s;
	}

	recur (0);

	return res;
}

void main ()
{
	int tests;
	readf (" %s", &tests);
	foreach (test; 0..tests)
	{
		writefln ("Case #%d: %s", test + 1, solve ());
	}
}
