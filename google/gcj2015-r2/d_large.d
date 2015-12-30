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
immutable int MAXP = 13;
immutable int [MAXP] INV = [1, 1,
    500000004, 333333336, 250000002, 400000003, 166666668,
    142857144, 125000001, 111111112, 700000005, 818181824, 83333334];

int lcm (int a, int b)
{
	return a / gcd (a, b) * b;
}

long solve (int r, int c)
{
	auto f = new long [] [] [] (r + 1, 2, MAXP);
	f[0][0][1] = 1;
	f[0][1][1] = 1;
	foreach (row; 1..r + 1)
	{
		// 333333333333
		// 333333333333
		// Period: 1
		if (row >= 2 && c % 1 == 0)
		{
			foreach (p; 1..MAXP)
			{
				int q = lcm (1, p);
				if (q >= MAXP)
				{
					continue;
				}
				f[row][1][q] = (f[row][1][q] +
				    f[row - 2][0][p] * 1) % MOD;
			}
		}

		// 222222222222
		// Period: 1
		if (row >= 1 && c % 1 == 0)
		{
			foreach (p; 1..MAXP)
			{
				int q = lcm (1, p);
				if (q >= MAXP)
				{
					continue;
				}
				f[row][0][q] = (f[row][0][q] +
				    f[row - 1][1][p] * 1) % MOD;
			}
		}

		// 112222112222
		// 222112222112
		// Period: 6
		if (row >= 2 && c % 6 == 0)
		{
			foreach (p; 1..MAXP)
			{
				int q = lcm (6, p);
				if (q >= MAXP)
				{
					continue;
				}
				f[row][0][q] = (f[row][0][q] +
				    f[row - 2][1][p] * 6) % MOD;
			}
		}

		// 122212221222
		// 121212121212
		// 221222122212
		// Period: 4
		if (row >= 3 && c % 4 == 0)
		{
			foreach (p; 1..MAXP)
			{
				int q = lcm (4, p);
				if (q >= MAXP)
				{
					continue;
				}
				f[row][0][q] = (f[row][0][q] +
				    f[row - 3][1][p] * 4) % MOD;
			}
		}

		// 122122122122
		// 122122122122
		// Period: 3
		if (row >= 2 && c % 3 == 0)
		{
			foreach (p; 1..MAXP)
			{
				int q = lcm (3, p);
				if (q >= MAXP)
				{
					continue;
				}
				f[row][0][q] = (f[row][0][q] +
				    f[row - 2][1][p] * 3) % MOD;
			}
		}
	}

	long res = 0;
	foreach (p; 1..MAXP)
	{
		res = (res + (f[r][0][p] + f[r][1][p]) * INV[p]) % MOD;
	}
	return res % MOD;
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
