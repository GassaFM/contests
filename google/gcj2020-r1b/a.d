// Author: Ivan Kazmenko (gassa@mail.ru)
module solution;
import std.algorithm;
import std.conv;
import std.math;
import std.numeric;
import std.range;
import std.stdio;
import std.string;
import std.typecons;

string solve (long x, long y)
{
	string res = "";
	long cur = 1;
	while (x != 0 || y != 0)
	{
		if ((x & cur) == (y & cur))
		{
			return "IMPOSSIBLE";
		}
		long next = cur * 2;
		if (x & cur)
		{
			if (x == -cur && y == 0)
			{
				x += cur;
				res ~= 'E';
			}
			else if (x == +cur && y == 0)
			{
				x -= cur;
				res ~= 'W';
			}
			else if (((x + cur) & next) != (y & next))
			{
				x += cur;
				res ~= 'E';
			}
			else if (((x - cur) & next) != (y & next))
			{
				x -= cur;
				res ~= 'W';
			}
			else
			{
				return "IMPOSSIBLE";
			}
		}
		else
		{
			if (x == 0 && y == -cur)
			{
				y += cur;
				res ~= 'N';
			}
			else if (x == 0 && y == +cur)
			{
				y -= cur;
				res ~= 'S';
			}
			else if ((x & next) != ((y + cur) & next))
			{
				y += cur;
				res ~= 'N';
			}
			else if ((x & next) != ((y - cur) & next))
			{
				y -= cur;
				res ~= 'S';
			}
			else
			{
				return "IMPOSSIBLE";
			}
		}
		cur = next;
	}
	return res;
}

void main ()
{
	int tests;
	readf (" %s", &tests);
	readln;
	foreach (test; 0..tests)
	{
		int x, y;
		readf (" %s %s", &x, &y);
		writeln ("Case #", test + 1, ": ", solve (-x, -y));
	}
}
