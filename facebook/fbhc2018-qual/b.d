import std.stdio;

void main ()
{
	int tests;
	readf (" %s", &tests);
	foreach (test; 0..tests)
	{
		int n;
		readf (" %s", &n);
		foreach (i; -1..n + 1)
		{
			readln;
		}
		write ("Case #", test + 1, ":");
		if (n & 1)
		{
			writeln (" 1");
			writeln ("0.0");
		}
		else
		{
			writeln (" 0");
		}
	}
}
