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
		int [] [] a;
		foreach (i; 0..n)
		{
			a ~= readln.splitter.map !(to !(int)).array;
		}

		int res = 0;
		foreach (i; 0..n)
		{
			res += a[i][i];
		}

		int rows = 0;
		foreach (i; 0..n)
		{
			bool [int] s;
			foreach (j; 0..n)
			{
				s[a[i][j]] = true;
			}
			rows += (s.length < n);
		}

		int cols = 0;
		foreach (j; 0..n)
		{
			bool [int] s;
			foreach (i; 0..n)
			{
				s[a[i][j]] = true;
			}
			cols += (s.length < n);
		}

		write ("Case #", test + 1, ":");
		writeln (" ", res, " ", rows, " ", cols);
	}
}
