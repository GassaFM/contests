import std.algorithm;
import std.conv;
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
		int n;
		int p;
		readf (" %s %s ", &n, &p);
		auto b = readln.split.map !(to !(int)).array;
		b ~= p + 1;
		long res = 0;
		int j = 0;
		int cur = 0;
		for (int i = 0; i < n; i++)
		{
			while (cur <= p)
			{
				cur += b[j];
				j++;
			}
			res += j - i - 1;
			cur -= b[i];
		}
		writeln ("Case #", test + 1, ": ", res);
	}
}
