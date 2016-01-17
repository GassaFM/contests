import core.bitop;
import std.algorithm;
import std.conv;
import std.range;
import std.stdio;
import std.string;

void main ()
{
	int tests;
	readf (" %s", &tests);
	foreach (test; 0..tests)
	{
		int n;
		readf (" %s ", &n);
		int [] [] a;
		foreach (i; 0..n)
		{
			a ~= readln.split.map !(to !(int)).array;
		}
		auto lo = new int [n];
		lo[] = n / 2 + 1;
		auto hi = new int [n];
		hi[] = 1;
/*
		int k = 0;
		while (n != (1 << k))
		{
			k++;
		}
*/
		debug {writeln (a); stdout.flush ();}

		bool [int] process (int s)
		{
			debug {writeln ("s = ", s); stdout.flush ();}
			int d = popcnt (s);
			int e = d / 2;
			bool [int] [int] v;
			v[0][0] = true;
			foreach (i; 0..e)
			{
				bool [int] [int] w;
				foreach (x, u; v)
				{
					foreach (y, val; u)
					{
						int z = 0;
						while ((x | y | ~s) & (1 << z))
						{
							z++;
						}
						assert (z < n);
						assert (!(x & (1 << z)));
						assert (!(y & (1 << z)));
						assert (s & (1 << z));
						foreach (t; z + 1..n)
						{
							if ((x | y | ~s) &
							    (1 << t))
							{
								continue;
							}
							if (a[z][t])
							{
								w[x | (1 << z)]
								    [y |
								    (1 << t)] =
								    true;
							}
							else
							{
								w[x | (1 << t)]
								    [y |
								    (1 << z)] =
								    true;
							}
						}
					}
				}
				v = w;
			}

			bool [int] res;
			foreach (x, u; v)
			{
				debug {writeln (x, ' ', popcnt (x), ' ', e);}
				assert (popcnt (x) == e);
				res[x] = true;
			}
			return res;
		}

		if (n == 1)
		{
			lo[0] = 1;
			hi[0] = 1;
		}

		bool [int] f;
		f[(1 << n) - 1] = true;
		for (int m = n >> 1; m > 0; m >>= 1)
		{
			bool [int] g;
			foreach (s, val; f)
			{
				bool [int] wins = process (s);
				debug {writeln (wins); stdout.flush ();}
				foreach (t, val2; wins)
				{
					foreach (i; 0..n)
					{
						if (s & (1 << i))
						{
							if (t & (1 << i))
							{
								lo[i] =
								    min (lo[i],
								    (m >> 1) +
								    1);
							}
							else
							{
								hi[i] =
								    max (hi[i],
								    (m >> 0) +
								    1);
							}
		
						}
					}
				}
				foreach (cur, val; wins)
				{
					g[cur] = true;
				}
			}
			f = g;
		}

		writefln ("Case #%s:", test + 1);
		foreach (i; 0..n)
		{
			writefln ("%s %s", lo[i], hi[i]);
			stdout.flush ();
		}
	}
}
