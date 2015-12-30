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

immutable int MOD = 1_000_000_007;

long solve (int r, int c)
{
	auto a = new int [] [] (r, c);
	long res = 0;

	bool better (int dcol)
	{
		foreach (row; 0..r)
		{
			foreach (col; 0..c)
			{
				if (a[row][col] != a[row][(col + dcol) % c])
				{
					return a[row][col] >
					    a[row][(col + dcol) % c];
				}
			}
		}
		return false;
	}

	int get (int row, int col)
	{
		if (row < 0)
		{
			return -9;
		}
		if (row >= r)
		{
			return -9;
		}
		if (col < 0)
		{
			col += c;
		}
		if (col >= c)
		{
			col -= c;
		}
		return a[row][col];
	}

	int check (int crow, int ccol)
	{
		int a1 = get (crow - 1, ccol);
		int a2 = get (crow, ccol - 1);
		int a3 = get (crow + 1, ccol);
		int a4 = get (crow, ccol + 1);
/*
		debug {writeln (crow, ' ', ccol, ' ',
		    a1, ' ', a2, ' ', a3, ' ', a4);}
*/
		if (!a1 || !a2 || !a3 || !a4)
		{
			return -1;
		}
		return (a1 == a[crow][ccol]) +
		       (a2 == a[crow][ccol]) +
		       (a3 == a[crow][ccol]) +
		       (a4 == a[crow][ccol]) == a[crow][ccol];
	}

	void recur (int row, int col, int crow, int ccol)
	{
		while (true)
		{
			int cur = check (crow, ccol);
			if (cur == 0)
			{
				return;
			}
			if (cur == -1)
			{
				break;
			}
			ccol++;
			if (ccol >= c)
			{
				ccol = 0;
				crow++;
				if (crow >= r)
				{
					break;
				}
			}
		}

		if (row >= r)
		{
			foreach (dcol; 1..c)
			{
				if (better (dcol))
				{
					return;
				}
			}
			debug {writefln ("-\n%(%(%s%)\n%)", a);}
			res++;
			return;
		}

		int nrow = row;
		int ncol = col + 1;
		if (ncol >= c)
		{
			ncol = 0;
			nrow++;
		}

		for (int v = 1; v <= 3; v++)
		{
			a[row][col] = v;
			recur (nrow, ncol, crow, ccol);
		}
		a[row][col] = 0;
	}

	recur (0, 0, 0, 0);

	return res;
}

void main ()
{
	int tests;
	readf (" %s", &tests);
	foreach (test; 0..tests)
	{
		int r, c;
		readf (" %s %s", &r, &c);
		auto res = solve (r, c);
		writeln ("Case #", test + 1, ": ", res);
		stdout.flush ();
	}
}
