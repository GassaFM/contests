import core.bitop;
import std.algorithm;
import std.array;
import std.functional;
import std.conv;
import std.stdio;
import std.string;

alias mgo = memoize !(go);

int go (int [2] [] s)
{
	if (s.length == 0)
	{
		return 0;
	}
	auto t = s.group.array;
	debug {writeln ("go ", t);}
	int ans = short.max;
	auto taken = new int [t.length];

	void recur (int d, int add, int [2] p)
	{
		debug {writeln ("recur ", d, " ", add, " ", p);}
		if (d == t.length)
		{
			if (p[0] > 0 && p[0] == p[1])
			{
				int [2] [] r;
				foreach (i; 0..t.length)
				{
					foreach (j; 0..t[i][1] - taken[i])
					{
						r ~= t[i][0];
					}
				}
				int cur = mgo (r);
				debug {writeln (t, ": ", add, " + ", cur);}
				ans = min (ans, add + cur);
			}
			return;
		}

		int next = 0;
		int [2] q = p.dup;
		foreach (k; 0..t[d][1] + 1)
		{
			taken[d] = k;
			recur (d + 1, add + next, q);
			next += q[0] * t[d][0][1] + q[1] * t[d][0][0];
			q[] += t[d][0][];
		}
	}

	recur (0, 0, [0, 0]);
	return ans;
}

void main ()
{
	int tests;
	readf (" %s", &tests);
	foreach (test; 0..tests)
	{
		int n;
		readf (" %s", &n);
		readln;
		bool [] [] a;
		foreach (i; 0..n)
		{
			a ~= readln.strip.map !(x => x == '1').array;
		}
		debug {writeln (a);}

		auto b = new bool [] [] (2, n);

		int [2] recur (int side, int v)
		{
			int [2] res = [0, 0];
			if (b[side][v])
			{
				return res;
			}
			b[side][v] = true;
			res[side] |= 1 << v;
			foreach (u; 0..n)
			{
				if (side ? a[u][v] : a[v][u])
				{
					auto cur = recur (!side, u);
					res[] |= cur[];
				}
			}
			return res;
		}

		int [2] [] comps;
		int res = 0;

		foreach (side; 0..2)
		{
			foreach (w; 0..n)
			{
				if (!b[side][w])
				{
					auto cur = recur (side, w);
					foreach (u; 0..n)
					    if (cur[0] & (1 << u))
					{
						foreach (v; 0..n)
						    if (cur[1] & (1 << v))
						{
							res += !a[u][v];
						}
					}
					comps ~= cur[].map !(popcnt).array
					    .to !(int [2]);
				}
			}
		}
		debug {writeln (comps);}
		sort (comps);
		debug {writeln (comps);}

		res += mgo (comps);

		writeln ("Case #", test + 1, ": ", res);
	}
}
