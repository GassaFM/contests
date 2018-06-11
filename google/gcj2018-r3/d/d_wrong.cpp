#include <algorithm>
#include <cmath>
#include <cstdint>
#include <cstdio>
#include <string>
#include <vector>

using namespace std;

typedef int64_t T;

int const NA = -1;

struct Segment
{
	T x1;
	T y1;
	T x2;
	T y2;
	int num;

	Segment (T x1_, T y1_, T x2_, T y2_, int num_) :
	    x1 (x1_), y1 (y1_), x2 (x2_), y2 (y2_), num (num_) {}

	Segment () : x1 (0), y1 (0), x2 (0), y2 (0), num (0) {};
};

bool cmp (Segment const & a, Segment const & b)
{
	if (a.y2 != b.y2)
	{
		return a.y2 < b.y2;
	}
	if (a.x2 != b.x2)
	{
		return a.x2 < b.x2;
	}
	return atan2 (a.y2 - a.y1, a.x2 - a.x1) <
	       atan2 (b.y2 - b.y1, b.x2 - b.x1);
}

void solveTest (int test)
{
	int n, k;
	scanf (" %d %d", &n, &k);
	vector <Segment> s (n);
	int num = 0;
	for (auto & cur : s)
	{
		int x1, y1, x2, y2;
		scanf (" %d %d %d %d", &x1, &y1, &x2, &y2);
		cur = Segment (x1, y1, x2, y2, num);
		num += 1;
	}
	for (auto & cur : s)
	{
		if (make_pair (cur.x1, cur.y1) < make_pair (cur.x2, cur.y2))
		{
			swap (cur.x1, cur.x2);
			swap (cur.y1, cur.y2);
		}
	}
	sort (begin (s), end (s), cmp);
	vector <int> res;
	int k0 = -1;
	int k1 = -1;
	num = 0;
	for (auto & cur : s)
	{
		res.push_back (cur.num);
		if (cur.num == 0) {k0 = num;}
		if (cur.num == 1) {k1 = num;}
		num += 1;
	}
	if (k0 > k1)
	{
		reverse (begin (res), end (res));
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
