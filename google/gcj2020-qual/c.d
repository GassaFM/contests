// Author: Ivan Kazmenko (gassa@mail.ru)
import std.algorithm;
import std.conv;
import std.math;
import std.numeric;
import std.range;
import std.stdio;
import std.string;
import std.typecons;

void main ()
{
	auto tests = readln.strip.to !(int);
	foreach (test; 0..tests)
	{
		auto n = readln.strip.to !(int);
		alias Pair = Tuple !(int, q{lo}, int, q{hi});
		auto a = new Pair [n];
		foreach (ref c; a)
		{
			readf (" %s %s", &c.lo, &c.hi);
		}
		readln;
		auto p = n.iota.array;
		p.sort !((i, j) => a[i].lo < a[j].lo);
		auto answer = new char [n];
		bool ok = true;
		int one = 0;
		int two = 0;
		foreach (i; p)
		{
			if (one <= a[i].lo)
			{
				answer[i] = 'C';
				one = a[i].hi;
			}
			else if (two <= a[i].lo)
			{
				answer[i] = 'J';
				two = a[i].hi;
			}
			else
			{
				ok = false;
			}
		}
		if (!ok)
		{
			answer = "IMPOSSIBLE".dup;
		}
		write ("Case #", test + 1, ":");
		writeln (" ", answer);
	}
}
