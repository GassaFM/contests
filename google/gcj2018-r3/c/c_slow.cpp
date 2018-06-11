#include <algorithm>
#include <cassert>
#include <cmath>
#include <cstdint>
#include <cstdio>
#include <string>
#include <vector>

using namespace std;

typedef long double T;

int const NA = -1;

struct Point
{
	T x;
	T y;
	T z;

	Point (T x_, T y_, T z_) : x (x_), y (y_), z (z_) {}

	Point () : x (0), y (0), z (0) {}
};

int n;
vector <Point> p;
vector <int> res;
vector <char> b;

bool above (int u, int v, int w, int i)
{
	auto e = (p[v].x - p[u].x) * (p[w].y - p[u].y) -
	         (p[w].x - p[u].x) * (p[v].y - p[u].y);
	auto a = (p[u].x - p[i].x) * (p[v].y - p[i].y) * (p[w].z - p[i].z) -
	         (p[u].x - p[i].x) * (p[w].y - p[i].y) * (p[v].z - p[i].z) -
	         (p[v].x - p[i].x) * (p[u].y - p[i].y) * (p[w].z - p[i].z) +
	         (p[v].x - p[i].x) * (p[w].y - p[i].y) * (p[u].z - p[i].z) +
	         (p[w].x - p[i].x) * (p[u].y - p[i].y) * (p[v].z - p[i].z) -
	         (p[w].x - p[i].x) * (p[v].y - p[i].y) * (p[u].z - p[i].z);
	return (e > 0) == (a > 0);
//	return (a > 0);
}

void solveTest (int test)
{
	scanf (" %d", &n);
	p = vector <Point> (n);
	for (auto & point : p)
	{
		int x, y, z;
		scanf (" %d %d %d", &x, &y, &z);
		point = Point (x, y, z);
	}
	res = vector <int> (n, 0);
	for (int i = 0; i < n; i++)
	{
		res[i] = i;
	}
	do
	{
		bool bad = false;
		for (int k = n - 1; k >= 3; k--)
		{
			int u = res[k - 0];
			int v = res[k - 1];
			int w = res[k - 2];
			for (int i = k - 3; i >= 0; i--)
			{
				if (!above (u, v, w, res[i]))
				{
					bad = true;
					goto endloop;
				}
			}
		}
endloop:
		if (!bad)
		{
			break;
		}
	}
	while (next_permutation (begin (res), end (res)));
	printf ("Case #%d:", test + 1);
	for (int i = 0; i < n; i++)
	{
		printf (" %d", res[i] + 1);
	}
	printf ("\n");
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
