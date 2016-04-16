import std.algorithm;
import std.conv;
import std.range;
import std.stdio;
import std.string;

void solve (int test)
{
	auto s = readln.strip;
	auto n = s.length;
	s ~= "+";
	auto res = n.iota.map !(i => s[i] != s[i + 1]).sum;
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
