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
	b = vector <char> (n, true);
	{
		int u = 0;
		int v = 1;
		int w = 2;
		for (int i = 3; i < n; i++)
		{
			if (!above (u, v, w, i))
			{
				if (above (u, v, i, w))
				{
					w = i;
				}
				else if (above (u, i, w, v))
				{
					v = i;
				}
				else if (above (i, v, w, u))
				{
					u = i;
				}
				else
				{
					assert (false);
				}
			}
		}
		if (p[u].z < p[v].z) {swap (u, v);}
		if (p[v].z < p[w].z) {swap (v, w);}
		if (p[u].z < p[v].z) {swap (u, v);}
		res[n - 1] = w; b[w] = false;
		res[n - 2] = v; b[v] = false;
		res[n - 3] = u; b[u] = false;
	}
	for (int i = n - 4; i >= 0; i--)
	{
		int & w = res[i + 3];
		int & v = res[i + 2];
		int & u = res[i + 1];
		int & t = res[i + 0];
		t = NA;
		bool bad = false;
		for (int step = 0; step < 6; step++)
		{
			bad = false;
			for (int j = 0; j < n; j++) if (b[j])
			{
				if (t == NA)
				{
					t = j;
				}
				else if (!above (t, u, v, j))
				{
					if (above (j, u, v, t))
					{
						t = j;
					}
					else
					{
						bad = true;
						break;
					}
				}
			}
			if (!bad)
			{
				break;
			}
			if (step & 1)
			{
				swap (v, w);
			}
			else
			{
				swap (u, v);
			}
		}
		assert (!bad);
		b[t] = false;
	}
	printf ("Case #%d:", test + 1);
	for (int i = 0; i < n; i++)
	{
		printf (" %d", res[i] + 1);
	}
	printf ("\n");
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
