import std.conv;
import std.stdio;
import std.string;

void main ()
{
	int tests;
	readf (" %s", &tests);
	readln;
	foreach (test; 0..tests)
	{
		auto s = readln.strip;
		auto n = s.length.to !(int);
		string res = "Impossible";
		foreach (i; 1..n)
		{
			if (s[i] == s[0] && s[i..n] != s[0..n - i])
			{
				res = s[0..i] ~ s;
				break;
			}
		}
		write ("Case #", test + 1, ":");
		writeln (" ", res);
	}
}
