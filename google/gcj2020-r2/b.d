module solution;
import std.algorithm;
import std.conv;
import std.range;
import std.stdio;
import std.typecons;

immutable int infinity = 1_000_000;

void main ()
{
	int tests;
	readf (" %s", &tests);
	readln;
	foreach (test; 0..tests)
	{
		int n, m;
		readf (" %s %s", &n, &m);
		readln;
		auto x = [0] ~ readln.splitter.map !(to !(int)).array;
		alias Edge = Tuple !(int, q{u}, int, q{v}, int, q{len});
		auto edge = new Edge [m];
		auto adj = new int [] [n];
		foreach (j; 0..m)
		{
			int u, v;
			readf (" %s %s", &u, &v);
			u -= 1;
			v -= 1;
			edge[j] = Edge (u, v, infinity);
			adj[u] ~= j;
			adj[v] ~= j;
		}
		debug {writefln ("%(%s\n%)", adj);}

		auto d = new int [n];
		d[] = infinity;
		d[0] = 0;
		int vis = 1;
		int prev = 0;
		bool haveToAdd = true;
		while (vis < n)
		{
			auto cur = n.iota.filter !(v => x[v] == -vis).array;
			bool isOrdered = !cur.empty;
			int next;
			if (isOrdered)
			{
				haveToAdd = true;
				next = prev + haveToAdd;
			}
			else
			{
				next = n.iota.filter
				    !(v => d[v] == infinity && x[v] > 0)
				    .map !(v => x[v]).minElement;
				cur = n.iota.filter !(v => x[v] == next).array;
			}
			debug {writeln (vis, " ", next, " ", cur, " ", d);}

			bool ok = true;
			foreach (v; cur)
			{
				ok = false;
				foreach (j; adj[v])
				{
					auto u = v ^ edge[j].u ^ edge[j].v;
					if (next > d[u])
					{
						ok = true;
					}
				}
				if (!ok)
				{
					break;
				}
			}
			if (!ok)
			{
				if (isOrdered)
				{
					next += 1;
				}
				else
				{
					assert (false);
				}
			}

			foreach (v; cur)
			{
				ok = false;
				foreach (j; adj[v])
				{
					auto u = v ^ edge[j].u ^ edge[j].v;
					if (next > d[u])
					{
						edge[j].len = next - d[u];
						ok = true;
					}
				}
				if (ok)
				{
					d[v] = next;
					vis += 1;
				}
				else
				{
					assert (false);
				}
			}

			haveToAdd = (next == prev);
			prev = next;
		}

		write ("Case #", test + 1, ": ");
		writefln ("%(%s %)", edge.map !(e => e.len));
	}
}
