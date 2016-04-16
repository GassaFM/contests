import std.algorithm;
import std.array;
import std.conv;
import std.stdio;
import std.string;

void solve (int test)
{
	auto n = readln.strip.to !(int);
	bool [int] v;
	foreach (i; 0..n * 2 - 1)
	{
		foreach (u; readln.split.map !(to !(int)))
		{
			v[u] ^= true;
		}
	}
	int [] ans;
	foreach (key, value; v)
	{
		if (value == true)
		{
			ans ~= key;
		}
	}
	assert (ans.length == n);
	sort (ans);

	writeln ("Case #", test + 1, ": ", ans.map !(text).join (" "));
}

void main ()
{
	auto tests = readln.strip.to !(int);
	foreach (test; 0..tests)
	{
		solve (test);
	}
}
