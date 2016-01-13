import std.algorithm;
import std.conv;
import std.range;
import std.stdio;
import std.string;
import std.typecons;

void main ()
{
	int tests;
	readf (" %s", &tests);
	foreach (test; 0..tests)
	{
		int n;
		readf (" %s", &n);
		alias Point = Tuple !(int, q{x}, int, q{y});
		auto a = new Point [n];
		foreach (ref p; a)
		{
			readf (" %s %s", &p.x, &p.y);
		}
		long res = 0;
		auto d = new int [] [] (n, n);
		foreach (i; 0..n)
		{
			foreach (j; i + 1..n)
			{
				d[i][j] = (a[i].x - a[j].x) ^^ 2 +
				    (a[i].y - a[j].y) ^^ 2;
			}
		}
		foreach (i; 0..n)
		{
			foreach (j; i + 1..n)
			{
				foreach (k; j + 1..n)
				{
					if (d[i][j] == d[i][k] ||
					    d[i][j] == d[j][k] ||
					    d[i][k] == d[j][k])
					{
						res++;
					}
				}
			}
		}
		writeln ("Case #", test + 1, ": ", res);
	}
}
