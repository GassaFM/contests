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
		auto s = readln.strip ~ '0';
		int cur = 0;
		string res;
		foreach (const ref c; s)
		{
			auto d = c - '0';
			while (cur < d)
			{
				res ~= '(';
				cur += 1;
			}
			while (cur > d)
			{
				res ~= ')';
				cur -= 1;
			}
			res ~= c;
		}
		write ("Case #", test + 1, ":");
		writeln (" ", res[0..$ - 1]);
	}
}
