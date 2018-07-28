import std.algorithm;
import std.stdio;
import std.string;

immutable int mod = 10 ^^ 9 + 7;
immutable int height = 3;

int solve (int n, ref string [height] s)
{
	if (n & 1)
	{
		return 0;
	}
	if (s[0][0] != '.')
	{
		return 0;
	}
	if (s[$ - 1][$ - 1] != '.')
	{
		return 0;
	}
	if (s[1].any !(c => c == '#'))
	{
		return 0;
	}
	int res = 1;
	for (int i = 1; i + 1 < n; i += 2)
	{
		int cur = 0;
		cur += (s[0][i..i + 2] == "..");
		cur += (s[2][i..i + 2] == "..");
		res = (res * cur) % mod;
	}
	return res;
}

void main ()
{
	int tests;
	readf (" %s", &tests);
	foreach (test; 0..tests)
	{
		int n;
		readf (" %s", &n);
		readln;
		string [height] s;
		foreach (ref line; s)
		{
			line = readln.strip;
		}
		write ("Case #", test + 1, ": ");
		write (solve (n, s));
		writeln;
	}
}
