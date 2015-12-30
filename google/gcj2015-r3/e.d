import core.bitop;
import std.algorithm;
import std.array;
import std.ascii;
import std.complex;
import std.container;
import std.conv;
import std.math;
import std.numeric;
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
		int n, d;
		readf (" %s %s ", &n, &d);
		auto a = readln.split.map !(to !(int)).array;

		auto b = a[0..2 * d].dup;
		int res = 0;
		debug {writeln ("b = ", b);}
		for (int f = d; f >= 1; f >>= 1)
		{
			auto e = new int [2 * d];
			for (int i = 0; i < 2 * d; i++)
			{
				e[i] = b[(i + f) % (2 * d)] - b[i];
			}
			debug {writeln ("e = ", e);}
			for (int i = 0; i < 2 * f; i++)
			{
				auto x = e[(i + 1) % (2 * d)] - e[i];
				x >>= 1;
				if (x > 0)
				{
					debug {writeln (f, " ", i);}
					res += x;
					for (int j = 0; j < 2 * d; j++)
					{
						if ((j + 2 * d * 2 * f - 1 - i) %
						    (2 * f) >= f)
						{
							debug {writeln (j);}
							b[j] -= x;
						}
					}
				}
			}
			debug {writeln ("b = ", b);}
		}
		foreach (i; 0..2 * d)
		{
			if (b[i] < 0)
			{
				res = -1;
			}
		}
		auto temp = b.minPos.front;
		b[] -= temp;
		foreach (i; 0..2 * d)
		{
			if (b[i] != 0)
			{
				res = -1;
			}
		}

		foreach (i; 2 * d..n)
		{
			if (a[i] != a[i - 2 * d])
			{
				res = -1;
			}
		}

		write ("Case #", test + 1, ": ");
		if (res >= 0)
		{
			writeln (res);
		}
		else
		{
			writeln ("CHEATERS!");
		}
	}
}
