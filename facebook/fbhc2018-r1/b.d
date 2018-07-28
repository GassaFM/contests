import std.array;
import std.range;
import std.stdio;

immutable int NA = -1;

void main ()
{
	int tests;
	readf (" %s", &tests);
	foreach (test; 0..tests)
	{
		int n, k;
		readf (" %s %s", &n, &k);
		auto a = new int [n];
		auto b = new int [n];
		foreach (i; 0..n)
		{
			readf (" %s %s", &a[i], &b[i]);
		}
		a[] -= 1;
		b[] -= 1;

		int [] pre;

		void buildPre (int v)
		{
			if (v != NA)
			{
				pre ~= v;
				buildPre (a[v]);
				buildPre (b[v]);
                        }
		}

		buildPre (0);

		int [] post;

		void buildPost (int v)
		{
			if (v != NA)
			{
				buildPost (a[v]);
				buildPost (b[v]);
				post ~= v;
                        }
		}

		buildPost (0);

		auto p = n.iota.array;

		int root (int v)
		{
			if (p[v] != v)
			{
				p[v] = root (p[v]);
			}
			return p[v];
		}

		bool unite (int u, int v)
		{
			u = root (u);
			v = root (v);
			if (u == v)
			{
				return false;
			}
			p[u] = v;
			return true;
		}

		int num = n;
		foreach (i; 0..n)
		{
			num -= unite (pre[i], post[i]);
		}

		int [] res;
		if (num >= k)
		{
			int [int] mark;
			int cur = 0;
			foreach (i; 0..n)
			{
				int v = root (p[i]);
				if (v !in mark)
				{
					cur = cur % k + 1;
					mark[v] = cur;
				}
				res ~= mark[v];
			}

			foreach (i; 0..n)
			{
				assert (res[pre[i]] == res[post[i]]);
			}
		}

		write ("Case #", test + 1, ":");
		if (res.empty)
		{
			write (" Impossible");
		}
		else
		{
			writef ("%( %s%)", res);
		}
		writeln;
	}
}
