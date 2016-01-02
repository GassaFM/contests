import std.algorithm, std.stdio;

int solve (int r, int c, int n, int phase)
{
	auto b = new bool [] [] (r + 2, c + 2);

	int res = 0;

	void add (int row, int col)
	{
		if (b[row][col])
		{
			return;
		}

		if (n > 0)
		{
			res += b[row    ][col - 1];
			res += b[row - 1][col    ];
			res += b[row    ][col + 1];
			res += b[row + 1][col    ];

			b[row][col] = true;
			n--;
		}
	}

	foreach (row; 1..r + 1)
	{
		foreach (col; 1..c + 1)
		{
			if (((row ^ col) & 1) == phase)
			{
				add (row, col);
			}
		}
	}

	foreach (row; 1..r + 1)
	{
		foreach (col; 1..c + 1)
		{
			if ((row == 1 || row == r) && (col == 1 || col == c))
			{
				add (row, col);
			}
		}
	}

	foreach (row; 1..r + 1)
	{
		foreach (col; 1..c + 1)
		{
			if ((row == 1 || row == r) || (col == 1 || col == c))
			{
				add (row, col);
			}
		}
	}

	foreach (row; 1..r + 1)
	{
		foreach (col; 1..c + 1)
		{
			if (true)
			{
				add (row, col);
			}
		}
	}

	return res;
}

void doCase (int test)
{
	int r, c, n;
	readf (" %s %s %s", &r, &c, &n);
	int res = min (solve (r, c, n, 0), solve (r, c, n, 1));
	writeln ("Case #", test, ": ", res);
}

void main ()
{
	int tests;
	readf (" %s", &tests);
	foreach (test; 0..tests)
	{
		doCase (test + 1);
	}
}
