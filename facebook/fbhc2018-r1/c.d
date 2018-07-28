import std.algorithm;
import std.math;
import std.range;
import std.stdio;

void main ()
{
	int tests;
	readf (" %s", &tests);
	foreach (test; 0..tests)
	{
		int n, m;
		readf (" %s %s", &n, &m);
		int h1, h2, w, x, y, z;
		readf (" %s %s %s %s %s %s", &h1, &h2, &w, &x, &y, &z);
		auto h = new int [n];
		h[0] = h1;
		h[1] = h2;
		for (int i = 2; i < n; i++)
		{
			h[i] = (w * 1L * h[i - 2] + x * 1L * h[i - 1] + y) % z;
		}
		auto a = new int [m];
		auto b = new int [m];
		auto u = new int [m];
		auto d = new int [m];
		foreach (j; 0..m)
		{
			readf (" %s %s %s %s", &a[j], &b[j], &u[j], &d[j]);
		}
		a[] -= 1;
		b[] -= 1;

		auto fup = new real [n - 1];
		auto fdn = new real [n - 1];
		auto bup = new real [n - 1];
		auto bdn = new real [n - 1];
		fup[] = 1E8;
		fdn[] = 1E8;
		bup[] = 1E8;
		bdn[] = 1E8;
		foreach (j; 0..m)
		{
			foreach (i; a[j]..b[j])
			{
				fup[i] = min (fup[i], u[j]);
				fdn[i] = min (fdn[i], d[j]);
			}
			foreach (i; b[j]..a[j])
			{
				bup[i] = min (bup[i], u[j]);
				bdn[i] = min (bdn[i], d[j]);
			}
		}

		auto p = new real [n];
		real lo = 0.0;
		real hi = 1E8;
		foreach (step; 0..200)
		{
			real me = (lo + hi) * 0.5;
			p[] = h[] - me;
			bool done;
			foreach (refineStep; 0..3)
			{
				debug {if (n < 10) {writefln ("%(%.10f %)", p);}}
				done = true;
				foreach (i; 0..n - 1)
				{
					if (p[i + 1] < p[i] - fdn[i])
					{
						p[i + 1] = p[i] - fdn[i];
						done = false;
					}
					if (p[i + 1] < p[i] - bup[i])
					{
						p[i + 1] = p[i] - bup[i];
						done = false;
					}
				}
				foreach_reverse (i; 0..n - 1)
				{
					if (p[i] < p[i + 1] - bdn[i])
					{
						p[i] = p[i + 1] - bdn[i];
						done = false;
					}
					if (p[i] < p[i + 1] - fup[i])
					{
						p[i] = p[i + 1] - fup[i];
						done = false;
					}
				}
			}
			done &= n.iota.all !(i => abs (p[i] - h[i]) <= me);
			if (done)
			{
				hi = me;
			}
			else
			{
				lo = me;
			}
		}

		write ("Case #", test + 1, ":");
		writef (" %.10f", lo);
		writeln;
	}
}
