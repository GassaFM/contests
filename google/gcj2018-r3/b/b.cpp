#include <algorithm>
#include <cassert>
#include <cstdio>
#include <iterator>
#include <set>
#include <string>
#include <utility>
#include <vector>

using namespace std;

//FILE * ferr;

// RND BEGIN
const unsigned LCG_MULT = 1664525, LCG_ADD = 1013904223;
unsigned currand;

inline void initrand (int seed)
{
	currand = seed;
}

inline void nextrand (void)
{
	currand = currand * LCG_MULT + LCG_ADD;
}

inline int rndvalue (int range)
{
	nextrand ();
	return ((long long) currand * range) >> 32;
}
// RND END

int const NA = -1;
int const steps = 1000000;

vector <vector <unsigned> > mark (int n, vector <pair <int, int> > e)
{
	vector <vector <unsigned> > res;
	for (int i = 0; i < n; i++)
	{
		vector <unsigned> cur (n, 0);
		cur[i] = 1;
		for (int k = 0; k < n; k++)
		{
			vector <unsigned> next (n, 0);
			for (auto & edge : e)
			{
				int u = edge.first;
				int v = edge.second;
				next[u] += cur[v];
				next[v] += cur[u];
			}
			cur = next;
		}
		sort (begin (cur), end (cur));
		res.push_back (cur);
	}
	return res;
}

bool check (int n, vector <pair <int, int> > e)
{
	auto m = mark (n, e);
	set <vector <unsigned> > s;
	for (auto & line : m)
	{
		s.insert (line);
	}
	return (int) (s.size ()) == n;
}

vector <pair <int, int> > gen (int n)
{
	int r = rndvalue (100) + 1;
	for (int i = 0; i < r; i++)
	{
		rndvalue (1000);
	}
	vector <pair <int, int> > res;
	auto a = vector <vector <char> > (n, vector <char> (n, false));
	auto d = vector <int> (n, 0);
	for (int i = 0; i < n * 2; i++)
	{
		int x = NA;
		int y = NA;
		for (int step = 0; ; step++)
		{
			if (step >= steps)
			{
				return vector <pair <int, int> > ();
			}
			x = rndvalue (n);
			y = rndvalue (n - 1);
			y += (y >= x);
			if (!a[x][y] && d[x] < 4 && d[y] < 4)
			{
				break;
			}
		}
		a[x][y] = true;
		a[y][x] = true;
		res.push_back (make_pair (x, y));
		d[x] += 1;
		d[y] += 1;
	}
	return res;
}

vector <pair <int, int> > genRepeated (int n)
{
	while (true)
	{
		auto res = gen (n);
		if ((int) (res.size ()) != n * 2)
		{
//			fprintf (ferr, "%d: repeat\n", n); fflush (ferr);
			continue;
		}
		if (check (n, res))
		{
			return res;
		}
//		fprintf (ferr, "%d: similar\n", n); fflush (ferr);
	}
}

void solveTest (int test)
{
	int lo, hi;
	scanf (" %d", &lo);
	if (lo == NA)
	{
		assert (false);
		return;
        }
	scanf (" %d", &hi);

	int n = 10;
	n = max (n, lo);
	n = min (n, hi);
	auto e = genRepeated (n);
	printf ("%d\n", n);
	for (auto & edge : e)
	{
		printf ("%d %d\n", edge.first + 1, edge.second + 1);
	}
	fflush (stdout);

	int n2;
	scanf (" %d", &n2);
	assert (n == n2);
	auto e2 = vector <pair <int, int> > (n * 2);
	for (auto & edge : e2)
	{
		scanf (" %d %d", &edge.first, &edge.second);
		edge.first -= 1;
		edge.second -= 1;
	}

	auto m = mark (n, e);
	auto m2 = mark (n, e2);
	vector <int> f (n);
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			if (m[i] == m2[j])
			{
				f[i] = j;
				break;
			}
		}
	}
	for (int i = 0; i < n; i++)
	{
		printf ("%d%c", f[i] + 1, "\n "[i + 1 < n]);
	}
	fflush (stdout);
}

int main ()
{
	initrand (21529876);
//	ferr = fopen ("log.txt", "wt");
	int tests;
	scanf (" %d", &tests);
	for (int test = 0; test < tests; test++)
	{
		solveTest (test);
	}
	return 0;
}
