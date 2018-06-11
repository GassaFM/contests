#include <algorithm>
#include <cstdio>
#include <cstring>
#include <string>
#include <vector>

using namespace std;

int const side = 24;
int const scale = 22;

int rows;
int cols;
char board [side] [side];
char large [side * scale] [side * scale];
bool b [side] [side];

void multiply ()
{
	for (int row = 0; row < rows + 2; row++)
	{
		for (int i = 0; i < scale; i++)
		{
			for (int col = 0; col < cols + 2; col++)
			{
				for (int j = 0; j < scale; j++)
				{
					large[row * scale + i]
					    [col * scale + j] =
					    board[row][col];
				}
			}
		}
	}
}

int const dirs = 4;
int const dRow [dirs] = {-1,  0, +1,  0};
int const dCol [dirs] = { 0, -1,  0, +1};

int mark (int row, int col)
{
	if (!b[row][col])
	{
		return 0;
	}
	int res = 1;
	b[row][col] = false;
	for (int dir = 0; dir < dirs; dir++)
	{
		res += mark (row + dRow[dir], col + dCol[dir]);
	}
	return res;
}

int combine (int row0, int col0)
{
	printf ("%d %d\n", row0, col0);
	fflush (stdout);
	for (int row = 0; row < rows + 2; row++)
	{
		for (int col = 0; col < cols + 2; col++)
		{
			b[row][col] = false;
		}
	}

	for (int row = 1; row <= rows; row++)
	{
		for (int col = 1; col <= cols; col++)
		{
			b[row][col] = (board[row][col] ==
			    large[row + row0][col + col0]);
		}
	}

	int res = 0;
	for (int row = 1; row <= rows; row++)
	{
		for (int col = 1; col <= cols; col++)
		{
			if (b[row][col])
			{
				res = max (res, mark (row, col));
			}
		}
	}
	return res;
}

void solveTest (int test)
{
	scanf (" %d %d", &rows, &cols);
	for (int row = 0; row <= rows + 2; row++)
	{
		for (int col = 0; col <= cols + 2; col++)
		{
			board[row][col] = '#';
		}
	}
	fprintf (stderr, "! %d %d %d\n", test + 1, rows, cols);
	for (int row = 1; row <= rows; row++)
	{
		for (int col = 1; col <= cols; col++)
		{
			fprintf (stderr, "! %d %d %d\n", test + 1, row, col);
			scanf (" %c", &board[row][col]);
		}
	}
	fprintf (stderr, "! %d\n", test + 1);
	multiply ();

	int res = 0;
	for (int row0 = 1 * scale; row0 <= (rows + 1) * scale; row0++)
	{
		for (int col0 = 1 * scale; col0 <= (cols + 1) * scale; col0++)
		{
			res = max (res, combine (row0, col0));
		}
	}

	printf ("Case #%d: ", test + 1);
	printf ("%d\n", res);
	fflush (stdout);
}

int main ()
{
	int tests;
	scanf (" %d", &tests);
	for (int test = 0; test < tests; test++)
	{
		solveTest (test);
	}
	return 0;
}
