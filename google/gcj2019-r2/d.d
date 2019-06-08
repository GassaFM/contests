module solution;
import std.conv;
import std.stdio;

immutable int mod1 = 1_000_000_007;
immutable int mod2 =   999_999_893;

string solveInstance ()
{
	int n;
	readf (" %s", &n);

	auto fwd = new int [] [n];
	auto rev = new int [] [n];
	foreach (i; 0..n)
	{
		int u, v;
		readf (" %s %s", &u, &v);
		u -= 1;
		v -= 1;
		fwd[i] ~= u;
		fwd[i] ~= v;
		rev[u] ~= i;
		rev[v] ~= i;
	}

	auto z = new int [n];
	foreach (ref x; z)
	{
		readf (" %s", &x);
	}

	auto can = new bool [n];

	void markCan (int v)
	{
		if (can[v])
		{
			return;
		}
		can[v] = true;
		foreach (u; fwd[v])
		{
			markCan (u);
		}
	}

	foreach (i; 0..n)
	{
		if (z[i] > 0)
		{
			markCan (i);
		}
	}
	debug {writeln (can);}

	if (!can[0])
	{
		return "0";
	}

	int [] order;
	auto vis = new bool [n];

	void topSort (int v)
	{
		if (!can[v] || vis[v])
		{
			return;
		}
		vis[v] = true;
		foreach (u; rev[v])
		{
			topSort (u);
		}
		order ~= v;
	}

	topSort (0);
	order = order[$ - 1] ~ order[0..$ - 1];
	debug {writeln (vis);}
	debug {writeln (order);}

	auto w1 = z.dup;
	auto w2 = z.dup;

	void process (const int [] vs)
	{
		foreach (u; vs)
		{
			auto add1 = w1[u];
			auto add2 = w2[u];
			w1[u] = 0;
			w2[u] = 0;
			foreach (v; fwd[u])
			{
				w1[v] = (w1[v] + add1) % mod1;
				w2[v] = (w2[v] + add2) % mod2;
			}
		}
		debug {writeln (w1);}
		debug {writeln (w2);}
	}

	process (order[1..$]);
	auto saved1 = w1[0];
	auto saved2 = w2[0];
	process (order[1..$]);
	if ((saved1 != w1[0] || saved2 != w2[0]))
	{
		return "UNBOUNDED";
	}
	process (order[0..$]);
	if ((w1[0] != 0 || w2[0] != 0) &&
	    (saved1 != w1[0] || saved2 != w2[0]))
	{
		return "UNBOUNDED";
	}
	return saved1.text;
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
