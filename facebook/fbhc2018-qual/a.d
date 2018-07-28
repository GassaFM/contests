import std.algorithm;
import std.stdio;
import std.string;

void main ()
{
	int tests;
	readf (" %s", &tests);
	foreach (test; 0..tests)
	{
		int n, k;
		long v;
		readf (" %s %s %s", &n, &k, &v);
		readln;
		auto names = new string [n];
		foreach (ref name; names)
		{
			name = readln.strip;
		}
		v -= 1;
		v %= n;
		int [] p;
		foreach (i; v * k..(v + 1) * k)
		{
			p ~= i % n;
		}
		sort (p);

		write ("Case #", test + 1, ":");
		foreach (i; p)
		{
			write (" ", names[i]);
		}
		writeln;
	}
}
