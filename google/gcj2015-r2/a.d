import core.bitop;
import std.algorithm;
import std.array;
import std.ascii;
import std.container;
import std.conv;
import std.math;
import std.numeric;
import std.range;
import std.stdio;
import std.string;
import std.typecons;

immutable int DIRS = 4;
immutable int [DIRS] DROW = [-1,  0, +1,  0];
immutable int [DIRS] DCOL = [ 0, -1,  0, +1];
immutable char [DIRS] DNAME = ['^', '<', 'v', '>'];

void main ()
{
	int tests;
	readf (" %s", &tests);
	foreach (test; 0..tests)
	{
		int r, c;
		readf (" %s %s ", &r, &c);
		string [] a;
		foreach (row; 0..r)
		{
			a ~= readln ().strip ();
		}

		int res = 0;
		foreach (row; 0..r)
		{
			foreach (col; 0..c)
			{
				int cur = 0;
				while (cur < DIRS && a[row][col] != DNAME[cur])
				{
					cur++;
				}
				// int cur = DNAME.countUntil (a[row][col]);
				// if (cur < 0)
				if (cur >= DIRS)
				{
					continue;
				}
				int add = r * c + 1;
				foreach (d; 0..DIRS)
				{
					int crow = row;
					int ccol = col;
					do
					{
						crow += DROW[d];
						ccol += DCOL[d];
					}
					while (0 <= crow && crow < r &&
					       0 <= ccol && ccol < c &&
					       a[crow][ccol] == '.');
					if (0 <= crow && crow < r &&
					    0 <= ccol && ccol < c)
					{
						add = min (add, (d != cur));
					}
				}
				res += add;
			}
		}

		write ("Case #", test + 1, ": ");
		if (res > r * c)
		{
			writeln ("IMPOSSIBLE");
		}
		else
		{
			writeln (res);
		}
	}
}
