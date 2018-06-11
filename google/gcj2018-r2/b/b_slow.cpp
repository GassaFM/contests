#include <algorithm>
#include <cstdio>
#include <cstring>
#include <string>
#include <vector>

using namespace std;

int const infinity = 0x3F3F3F3F;

void solveTest (int test)
{
	int r;
	int b;
	scanf (" %d %d", &r, &b);
	vector <vector <int> > f (r + 1, vector <int> (b + 1, -infinity));
	f[r][b] = 0;
	for (int i = 0; i <= r; i++)
	{
		for (int j = 0; j <= b; j++)
		{
			if (i + j == 0)
			{
				continue;
			}
			for (int u = i; u <= r; u++)
			{
				for (int v = j; v <= b; v++)
				{
					f[u - i][v - j] = max (f[u - i][v - j],
					    f[u][v] + 1);
				}
			}
		}
	}

	int res = f[0][0];
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
