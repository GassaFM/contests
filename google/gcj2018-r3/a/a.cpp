#include <algorithm>
#include <cstdio>
#include <iterator>
#include <string>
#include <vector>

using namespace std;

int const NA = -1;

void solveTest (int test)
{
	int n;
	scanf (" %d", &n);
	vector <int> x (n);
	vector <int> y (n);
	for (int i = 0; i < n; i++)
	{
		scanf (" %d %d", &x[i], &y[i]);
	}
	auto xlo = *min_element (begin (x), end (x));
	auto ylo = *min_element (begin (y), end (y));
	auto xhi = *max_element (begin (x), end (x));
	auto yhi = *max_element (begin (y), end (y));
	int res = 0;
	res = max (res, (xhi - xlo + 1) / 2);
	res = max (res, (yhi - ylo + 1) / 2);
	printf ("Case #%d: %d\n", test + 1, res);
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
