#include <algorithm>
#include <cmath>
#include <cstdio>
#include <vector>

using namespace std;

typedef double real;

real const infinity = 1E100;

real solve ()
{
	int n;
	int total;
	scanf (" %d %d", &n, &total);
	vector <int> w (n);
	vector <int> h (n);
	vector <int> p (n);
	vector <int> q (n);
	vector <real> a (n);
	int base = 0;
	int limit = 0;
	for (int i = 0; i < n; i++)
	{
		scanf (" %d %d", &w[i], &h[i]);
		p[i] = (w[i] + h[i]) * 2.0;
		q[i] = min (w[i], h[i]) * 2.0;
		a[i] = hypot (w[i], h[i]) * 2.0 - q[i];
		base += p[i];
		limit += q[i];
	}

	vector <real> f (limit + 1);
	for (int v = 0; v <= limit; v++)
	{
		f[v] = -infinity;
	}
	f[0] = 0.0;
	int cur = 0;
	for (int i = 0; i < n; i++)
	{
		for (int v = cur, w = cur + q[i]; v >= 0; v--, w--)
		{
			f[w] = max (f[w], f[v] + a[i]);
		}
		cur += q[i];
	}

#ifdef DEBUG
	printf ("base = %d\n", base);
	printf ("limit = %d\n", limit);
	for (int v = 0; v <= limit; v++)
	{
		printf ("%d: %.10f\n", v, f[v]);
	}
#endif

	limit = min (limit, total - base);
	real res = 0;
	for (int v = 0; v <= limit; v++)
	{
		res = max (res, v + f[v]);
	}

	res += base;
	res = min (res, (real) (total));
	return res;
}

int main (void)
{
	int tests;
	scanf (" %d", &tests);
	for (int test = 0; test < tests; test++)
	{
		real res = solve ();
		printf ("Case #%d: %.10f\n", test + 1, res);
	}
	return 0;
}
