import core.bitop;
import std.algorithm;
import std.conv;
import std.range;
import std.stdio;
import std.string;

immutable int MIN_D =   1;
immutable int MAX_D = 100;
immutable int INF   = int.max / 4;

void main ()
{
	int tests;
	readf (" %s", &tests);
	foreach (test; 0..tests)
	{
		int n;
		readf (" %s ", &n);
		auto a = (MAX_D + 1).repeat (4).array;
		a ~= readln.split.map !(to !(int)).array;
		n = a.length;
		auto f = new int [n + 1];
		f[] = INF;
		f[4] = 0;
		foreach (i; 5..n + 1)
		{
			foreach (s; 1..16)
			{
				int p = popcnt (s);
				int [] v;
				int k = i - p;
				foreach (j; 0..4)
				{
					if (s & (1 << j))
					{
						v ~= a[k];
						k++;
					}
					else
					{
						v ~= INF;
					}
				}
				assert (k == i);
				foreach (j; 0..2)
				{
					if (v[j + 0] != INF &&
					    v[j + 1] == INF &&
					    v[j + 2] != INF)
					{
						v[j + 1] =
						    (v[j + 0] + v[j + 2]) / 2;
					}
				}
				if (v[0] != INF && v[1] == INF &&
				    v[2] == INF && v[3] != INF)
				{
					v[1] = (v[0] + v[0] + v[3]) / 3;
					v[2] = (v[0] + v[3] + v[3]) / 3;
				}
				foreach_reverse (j; 0..3)
				{
					if (v[j] == INF && v[j + 1] != INF)
					{
						v[j] = v[j + 1] - 1;
					}
				}
				foreach (j; 1..4)
				{
					if (v[j] == INF && v[j - 1] != INF)
					{
						v[j] = v[j - 1] + 1;
					}
				}
				foreach (j; 0..4)
				{
					assert (v[j] != INF);
				}
				if (MIN_D <= v[0] && v[3] <= MAX_D &&
				    0 < v[1] - v[0] && v[1] - v[0] <= 10 &&
				    0 < v[2] - v[1] && v[2] - v[1] <= 10 &&
				    0 < v[3] - v[2] && v[3] - v[2] <= 10)
				{
					debug {writeln (i - p, " -> ", i);}
					f[i] = min (f[i], f[i - p] + (4 - p));
				}
			}
		}
		debug {writeln (f);}
		writeln ("Case #", test + 1, ": ", f.back);
	}
}
