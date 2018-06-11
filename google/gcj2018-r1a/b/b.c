#include <stdint.h>
#include <stdio.h>

#define MAX_N 1000
int m [MAX_N];
int s [MAX_N];
int p [MAX_N];
int64_t v [MAX_N];
int r, b, c;

int check (int64_t limit)
{
	for (int i = 0; i < c; i++)
	{
		v[i] = (limit - p[i]) / s[i];
		if (v[i] < 0)
		{
			v[i] = 0;
		}
		if (v[i] > m[i])
		{
			v[i] = m[i];
		}
	}
	int64_t total = 0;
	for (int j = 0; j < r; j++)
	{
		int k = 0;
		for (int i = 0; i < c; i++)
		{
			if (v[k] < v[i])
			{
				k = i;
			}
		}
		total += v[k];
		v[k] = 0;
	}
	return total >= b;
}

int64_t solve (void)
{
	scanf (" %d %d %d", &r, &b, &c);
	for (int i = 0; i < c; i++)
	{
		scanf (" %d %d %d", &m[i], &s[i], &p[i]);
	}
	int64_t lo = 0;
	int64_t hi = (int64_t) (2E18);
	while (lo < hi)
	{
		int64_t me = (lo + hi) / 2;
		if (check (me))
		{
			hi = me;
		}
		else
		{
			lo = me + 1;
		}
	}
	return lo;
}

int main (void)
{
	int tests;
	scanf (" %d", &tests);
	for (int test = 0; test < tests; test++)
	{
		int64_t res = solve ();
		printf ("Case #%d: %lld\n", test + 1, res);
	}
	return 0;
}
