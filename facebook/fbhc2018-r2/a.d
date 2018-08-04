import std.algorithm;
import std.stdio;
import std.typecons;

struct Edge
{
	int u;
	int v;
	int w;
}

class Result
{
	int answer;
	Edge [] edges;
}

auto solve (int n, int k)
{
	auto res = new Result ();
	with (res)
	{
		int total = 0;
		int cur = k - 1;
		foreach (step; 0..n - 1)
		{
			int u = step + 1;
			int v = step + 2;
			int w = cur;
			if (w == 1)
			{
				v = n;
			}
			if (w < 1)
			{
				break;
			}
			total += w;
			edges ~= Edge (u, v, w);
			cur -= 1;
		}
		if (edges.length != 1)
		{
			edges ~= Edge (1, n, k);
			answer = total - k;
		}
		if (edges.length < 2)
		{
			answer = 0;
		}
	}
	return res;
}

void main ()
{
	int tests;
	readf (" %s", &tests);
	foreach (test; 0..tests)
	{
		int n, k;
		readf (" %s %s", &n, &k);
		auto res = solve (n, k);
		writefln ("Case #%d: %s", test + 1, res.answer);
		writeln (res.edges.length);
		foreach (edge; res.edges)
		{
			writeln (edge.u, " ", edge.v, " ", edge.w);
		}
	}
}
