import std.algorithm;
import std.container;
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
		long a, b;
		readf (" %s %s %s ", &n, &a, &b);
		auto c = readln.split.map !(to !(long)).array;
		real res = 0.0;
		assert (a < b);
		real scale = b - a;
		real mult = 1.0 / scale;

		long s = c.sum (0L);
		long aq = a / s;
		a -= aq * s;
		b -= aq * s;
		long bq = b / s;

		long cur = 0;
		int j = 0;
		while (j < n && cur + c[j] <= a)
		{
			cur += c[j];
			j++;
		}
		assert (j < n);

		if (bq == 0 && cur + c[j] > b)
		{
			res += ((a - cur) + (b - cur)) * 0.5L * (b - a);
		}
		else
		{
			res += ((a - cur) + c[j]) * 0.5L * (c[j] - (a - cur));
			cur += c[j];
			j++;
			while (j < n)
			{
				if (bq == 0 && cur + c[j] > b)
				{
					res += (b - cur) * 0.5L * (b - cur);
					break;
				}
				else
				{
					res += c[j] * 0.5L * c[j];
				}
				cur += c[j];
				j++;
			}
		}

		if (bq > 0)
		{
			foreach (i; 0..n)
			{
				res += (bq - 1) * c[i] * 0.5 * c[i];
			}
			b -= bq * s;
			cur = 0;
			j = 0;
			while (j < n)
			{
				if (cur + c[j] > b)
				{
					res += (b - cur) * 0.5 * (b - cur);
					break;
				}
				else
				{
					res += c[j] * 0.5 * c[j];
				}
				cur += c[j];
				j++;
			}
		}

		res *= mult;
		writefln ("Case #%s: %.20f", test + 1, res);
	}
}
