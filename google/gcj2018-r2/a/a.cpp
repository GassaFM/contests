#include <algorithm>
#include <cstdio>
#include <string>
#include <vector>

using namespace std;

int const NA = -1;

void solveTest (int test)
{
	int n;
	scanf (" %d", &n);
	vector <int> a (n);
	for (auto & x : a)
	{
		scanf (" %d", &x);
	}
	int res = 0;
	auto ans = vector <string> (n + 1, string (n, '.'));
	vector <int> b = a;
	int pos = 0;
	for (int i = 0; i < n; i++)
	{
		for ( ; b[i] > 0; b[i] -= 1, pos += 1)
		{
			int cur = pos;
			int line = 0;
			for ( ; cur < i; cur += 1, line += 1)
			{
				ans[line][cur] = '\\';
			}
			for ( ; cur > i; cur -= 1, line += 1)
			{
				ans[line][cur] = '/';
			}
			res = max (res, line + 1);
		}
	}
	ans.resize (res);

	if (a[0] == 0 || a[n - 1] == 0)
	{
		res = NA;
	}
	else
	{
		res = (int) (ans.size ());
	}

	printf ("Case #%d: ", test + 1);
	if (res == NA)
	{
		printf ("IMPOSSIBLE\n");
	}
	else
	{
		printf ("%d\n", res);
		for (auto s : ans)
		{
			printf ("%s\n", s.c_str ());
		}
	}
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
