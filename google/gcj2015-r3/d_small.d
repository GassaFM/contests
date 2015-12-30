import core.bitop;
import std.algorithm;
import std.array;
import std.ascii;
import std.container;
import std.conv;
import std.exception;
import std.math;
import std.numeric;
import std.range;
import std.stdio;
import std.string;
import std.typecons;

void main ()
{
	int tests;
	readf (" %s", &tests);
	foreach (test; 0..tests)
	{
		int p;
		readf (" %s ", &p);
		auto e = readln.split.map !(to !(long)).array;
		auto f = readln.split.map !(to !(long)).array;
		long [] ans;
		while (f.all !(x => x % 2 == 0))
		{
			ans ~= 0;
			f[] /= 2;
		}
		debug {writeln (e, ' ', f, ' ', p); stdout.flush ();}
		while (sum (f) > 1)
		{
			enforce (e.isSorted);
			enforce (p > 1);
			long delta = e[1] - e[0];

			long [long] v;
			foreach (i; 0..p)
			{
				v[e[i]] = f[i];
			}

			long [] g;
			long [] h;
			foreach (i; 0..p)
			{
				long cur = v[e[i]];
				if (cur != 0)
				{
					enforce (cur > 0);
					enforce (v[e[i] + delta] >= cur);
					v[e[i]] -= cur;
					v[e[i] + delta] -= cur;
					g ~= e[i];
					h ~= cur;
				}
			}

			if (e[$ - 1] == delta)
			{
				ans ~= +delta;
			}
			if (e[0] < 0)
			{
				ans ~= -delta;
				g[] += delta;
			}
			else if (e[$ - 1] > 0)
			{
				ans ~= +delta;
			}
			else
			{
				enforce (false);
			}

			e = g;
			f = h;
			p = e.length;
			debug {writeln (e, ' ', f, ' ', p); stdout.flush ();}
		}

		sort (ans);
		writeln ("Case #", test + 1, ": ", ans.map !(text).join (" "));
	}
}
