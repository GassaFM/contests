import std.conv;
import std.range;
import std.stdio;
import std.string;

void solve (int test)
{
	auto s = readln.strip;

	string res;
	foreach (c; s)
	{
		if (res.empty || c >= res.front)
		{
			res = c ~ res;
		}
		else
		{
			res = res ~ c;
		}
	}

	writeln ("Case #", test + 1, ": ", res);
}

void main ()
{
	auto tests = readln.strip.to !(int);
	foreach (test; 0..tests)
	{
		solve (test);
	}
}
