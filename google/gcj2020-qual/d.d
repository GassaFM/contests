// Author: Ivan Kazmenko (gassa@mail.ru)
import std.algorithm;
import std.conv;
import std.math;
import std.numeric;
import std.range;
import std.stdio;
import std.string;
import std.typecons;

void main ()
{
	int tests, len;
	readf (" %s %s", &tests, &len);
	readln;
	foreach (test; 0..tests)
	{
		auto a = new int [len];
		int lo = 0;
		int hi = len - 1;
		int num = 0;

		void ask (int pos)
		{
			writeln (pos + 1);
			stdout.flush ();
			a[pos] = readln[0] - '0';
			num += 1;
		}

		int same = 0;
		int diff = 0;
		auto b = a.dup;
		while (lo < hi)
		{
			if (num > 0 && num % 10 == 0)
			{
				b[] = a[];
				ask (same);
				ask (diff);
				if (a[same] != b[same] || a[diff] != b[diff])
				{
					b[] ^= 1;
				}
				if (a[same] != b[same] || a[diff] != b[diff])
				{
					reverse (b);
				}
				if (a[same] != b[same] || a[diff] != b[diff])
				{
					b[] ^= 1;
				}
				if (a[same] != b[same] || a[diff] != b[diff])
				{
					assert (false);
				}
				a[] = b[];
			}
			ask (lo);
			ask (hi);
			if (a[lo] == a[hi])
			{
				same = lo;
			}
			else
			{
				diff = lo;
			}
			lo += 1;
			hi -= 1;
		}
		writefln ("%(%s%)", a);
		stdout.flush ();
		auto res = readln.strip;
		if (res != "Y")
		{
			assert (false);
		}
	}
}
