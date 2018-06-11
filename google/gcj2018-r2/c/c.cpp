#include <algorithm>
#include <cstdio>
#include <cstring>
#include <string>
#include <vector>

using namespace std;

int const NA = -1;

vector <char> b;
vector <int> c;
vector <vector <int> > a;
int n;

bool bipart (int v, int value)
{
	if (b[v])
	{
		return false;
	}
	b[v] = true;
	for (int u = 0; u < n; u++)
	{
		if (a[v][u] == value && (c[u] == NA || bipart (c[u], value)))
		{
			c[u] = v;
			return true;
		}
	}
	return false;
}

void solveTest (int test)
{
	scanf (" %d", &n);
	a = vector <vector <int> > (n, vector <int> (n));
	for (auto & line : a)
	{
		for (auto & x : line)
		{
			scanf (" %d", &x);
		}
	}
	b = vector <char> (n);
	c = vector <int> (n);

	int res = 0;
	for (int value = -n; value <= +n; value++)
	{
		fill (begin (b), end (b), false);
		fill (begin (c), end (c), NA);
		for (int i = 0; i < n; i++)
		{
			if (bipart (i, value))
			{
				res += 1;
				fill (begin (b), end (b), false);
			}
		}
	}

	res = n * n - res;
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
