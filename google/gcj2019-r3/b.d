module solution;
import std.algorithm;
import std.conv;
import std.range;
import std.stdio;
import std.typecons;

alias Record = Tuple !(int, q{value}, int, q{index});

immutable int mod = 10 ^^ 9 + 7;

int solve (int n, int [] a)
{
	int half = 1;
	while (half < n)
	{
		half *= 2;
	}
	int limit = half * 2;
	auto tMax = new Record [limit];
	auto tSum = new long [limit];
	foreach (i; 0..n)
	{
		tMax[i + half] = Record (a[i], i);
		tSum[i + half] = a[i];
	}
	foreach_reverse (i; 1..half)
	{
		tMax[i] = max (tMax[i * 2 + 0], tMax[i * 2 + 1]);
		tSum[i] = tSum[i * 2 + 0] + tSum[i * 2 + 1];
	}

	int sumSegment (int lo, int hi)
	{
		long res = 0;
		for (lo += half, hi += half; lo <= hi; lo >>= 1, hi >>= 1)
		{
			if (lo & 1)
			{
				res += tSum[lo];
				lo += 1;
			}
			if (!(hi & 1))
			{
				res += tSum[hi];
				hi -= 1;
			}
		}
		return res % mod;
	}

	Record maxSegment (int lo, int hi)
	{
		Record res;
		for (lo += half, hi += half; lo <= hi; lo >>= 1, hi >>= 1)
		{
			if (lo & 1)
			{
				res = max (res, tMax[lo]);
				lo += 1;
			}
			if (!(hi & 1))
			{
				res = max (res, tMax[hi]);
				hi -= 1;
			}
		}
		return res;
	}

	int [long] flSaved;
	int fl (int lo, int hi)
	{
		if (hi - lo <= 0)
		{
			return 0;
		}
		long coord = lo * 1L * mod + hi;
		if (coord in flSaved)
		{
			return flSaved[coord];
		}

		auto v = maxSegment (lo, hi);
		auto me = v.index;
		debug {writeln ("me = ", me);}
		long res = 0;
		res += fl (lo, me - 1);
		res += fl (me + 1, hi);
		long add = ((hi - me + 1) * 1L * a[me] -
		    sumSegment (me, hi)) % mod;
		debug {writeln ("add = ", add, " * ", (me - lo + 1));}
		add = (add * (me - lo + 1)) % mod;
		res += add;
		int resMod = res % mod;
		flSaved[coord] = resMod;
		return resMod;
	}

	int [long] frSaved;
	int fr (int lo, int hi)
	{
		if (hi - lo <= 0)
		{
			return 0;
		}
		long coord = lo * 1L * mod + hi;
		if (coord in frSaved)
		{
			return frSaved[coord];
		}

		auto v = maxSegment (lo, hi);
		auto me = v.index;
		long res = 0;
		res += fr (lo, me - 1);
		res += fr (me + 1, hi);
		long add = ((me - lo + 1) * 1L * a[me] -
		    sumSegment (lo, me)) % mod;
		add = (add * (hi - me + 1)) % mod;
		res += add;
		int resMod = res % mod;
		frSaved[coord] = resMod;
		return resMod;
	}

	int [long] funSaved;
	int fun (int lo, int hi)
	{
		debug {writeln ("fun ", lo, " ", hi);}
		if (hi - lo <= 1)
		{
			return 0;
		}
		long coord = lo * 1L * mod + hi;
		debug {scope (exit) {writeln ("fun ", lo, " ", hi, " = ",
		    funSaved[coord]);}}
		if (coord in funSaved)
		{
			return funSaved[coord];
		}

		auto v = maxSegment (lo, hi);
		auto me = v.index;
		debug {writeln ("me = ", me);}
		long numLeft = me - lo + 1;
		long numRight = hi - me + 1;
		long res = 0;
		res += fun (lo, me - 1);
		res += fun (me + 1, hi);
		res += fl (lo, me - 1) * numRight;
		res += fr (me + 1, hi) * numLeft;
		int resMod = res % mod;
		funSaved[coord] = resMod;
		return resMod;
	}

	return ((fun (0, n - 1) % mod) + mod) % mod;
}

void main ()
{
	int tests;
	readf (" %s", &tests);
	readln;
	foreach (test; 0..tests)
	{
		int n;
		readf (" %s", &n);
		readln;
		auto a = readln.splitter.map !(to !(int)).array;
		writeln ("Case #", test + 1, ": ", solve (n, a));
	}
}
