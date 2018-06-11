#include <algorithm>
#include <cstdint>
#include <cstdio>
#include <cstring>
#include <set>
#include <string>
#include <vector>

using namespace std;

vector <string> multiply (vector <string> v, int scale)
{
	vector <string> res;
	for (auto line : v)
	{
		for (int i = 0; i < scale; i++)
		{
			string temp;
			for (auto c : line)
			{
				for (int j = 0; j < scale; j++)
				{
					temp += c;
				}
			}
			res.push_back (temp);
		}
	}
	return res;
}

int const scale = 22;

int rows;
int cols;
vector <string> board;
vector <string> large;
vector <string> b;

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
	b[row][col] = '\0';
	for (int dir = 0; dir < dirs; dir++)
	{
		res += mark (row + dRow[dir], col + dCol[dir]);
	}
	return res;
}

set <uint64_t> s;

uint64_t const p1 = 997ULL;
uint64_t const p2 = 997ULL * 1000 * 1000 * 1000 * 1000 * 1000 + 13;
uint64_t hm;
uint64_t hh [scale * (scale + 2)] [scale * (scale + 2)];

int combine (int row0, int col0)
{
/*
	printf ("%d %d\n", row0, col0);
	fflush (stdout);
*/
	uint64_t h = 0;
	for (int row = 1; row <= rows; row++)
	{
		h = (h * hm + hh[row0 + row][col0]) % p2;
	}
	if (s.find (h) != s.end ())
	{
		return 0;
	}
	s.insert (h);

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
	board = vector <string> (rows + 2, string (cols + 2, '#'));
	for (int row = 1; row <= rows; row++)
	{
		for (int col = 1; col <= cols; col++)
		{
			scanf (" %c", &board[row][col]);
		}
	}
	large = multiply (board, scale);
/*
	for (auto line : large)
	{
		printf ("%s\n", line.c_str ());
	}
*/

	hm = 1;
	for (int row = 1; row <= rows; row++)
	{
		hm = (hm * p1) % p2;
	}
	for (int row0 = 0; row0 < (rows + 2) * scale; row0++)
	{
		for (int col0 = 1 * scale; col0 <= (cols + 1) * scale; col0++)
		{
			uint64_t h = 0;
			for (int col = 1; col <= cols; col++)
			{
				h = (h * p1 + large[row0][col0 + col]) % p2;
			}
			hh[row0][col0] = h;
		}
	}

	b = vector <string> (rows + 2, string (cols + 2, '\0'));
	s.clear ();
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
