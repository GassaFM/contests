import std.algorithm;
import std.conv;
import std.parallelism;
import std.range;
import std.stdio;

immutable int mod = 10 ^^ 9 + 7;
immutable int NA = -1;

int powMod (int a, int b)
{
	int res = 1;
	while (b)
	{
		if (b & 1)
		{
			res = (res * 1L * a) % mod;
		}
		a = (a * 1L * a) % mod;
		b >>= 1;
	}
	return res;
}

int invMod (int a)
{
	return powMod (a, mod - 2);
}

struct Rational
{
	int num;
	int den;

	auto opBinary (string op) (const auto ref Rational that) const
	    if (op == "+")
	{
		Rational res;
		res.num = (this.num * 1L * that.den +
		    that.num * 1L * this.den) % mod;
		res.den = (this.den * 1L * that.den) % mod;
		return res;
	}

	auto opBinary (string op) (const auto ref Rational that) const
	    if (op == "-")
	{
		Rational res;
		res.num = (this.num * 1L * that.den -
		    that.num * 1L * this.den) % mod;
		if (res.num < 0)
		{
			res.num += mod;
		}
		res.den = (this.den * 1L * that.den) % mod;
		return res;
	}

	auto opBinary (string op) (const auto ref Rational that) const
	    if (op == "*")
	{
		Rational res;
		res.num = (this.num * 1L * that.num) % mod;
		res.den = (this.den * 1L * that.den) % mod;
		return res;
	}

	int toMod () const
	{
		return (num * 1L * invMod (den)) % mod;
	}
}

struct Test
{
	int n;
	int m;
	int [] a;
	int [] b;
	int [] y;
	int [] h;
	Rational res;
}

void main ()
{
	int tests;
	readf (" %s", &tests);
	auto t = new Test [tests];
	foreach (test; 0..tests) with (t[test])
	{
		readf (" %s %s", &n, &m);
		a = new int [n - 1];
		b = new int [n - 1];
		foreach (i; 0..n - 1)
		{
			readf (" %s %s", &a[i], &b[i]);
		}
		y = new int [m];
		h = new int [m];
		foreach (j; 0..m)
		{
			readf (" %s %s", &y[j], &h[j]);
		}
		y[] -= 1;
	}

	foreach (test; parallel (tests.iota)) with (t[test])
	{
		auto fCache = new Rational [] [] (n + 1, n + 1);

		Rational solve (int lo, int hi)
		{
			debug {writeln ("solve (", lo, ", ", hi, ")");}
			if (lo >= hi)
			{
				return Rational (1, 1);
			}
			if (fCache[lo][hi] == Rational.init)
			{
				debug {writeln ("do (", lo, ", ", hi, ")");}
				auto res = Rational (0, 1);

				int best = NA;
				int bestH = NA;
				foreach (j; 0..m)
				{
					if (lo <= y[j] && y[j] < hi)
					{
						if (bestH < h[j])
						{
							bestH = h[j];
							best = j;
						}
					}
				}
				if (best != NA)
				{
					debug {writeln ("best pos = ", y[best]);}
					auto left = Rational (0, 1);
					auto leftCur = Rational (1, 1);
					foreach_reverse (m; lo..y[best])
					{
						auto den = b[m] - a[m] + 1;
						auto num = h[best] - a[m] + 1;
						num = max (num, 0);
						num = min (num, den);
						debug {writeln (num, "/", den);}
						auto p = Rational (num,
						    den) * leftCur;
						auto q = Rational (den - num,
						    den) * leftCur;

						left = left + q *
						    solve (lo, m + 1);
						leftCur = p;
						if (leftCur.num == 0)
						{
							break;
						}
						debug {writeln (p, " ", q, " ", left);}
					}
					left = left + leftCur;

					auto right = Rational (0, 1);
					auto rightCur = Rational (1, 1);
					foreach (m; y[best]..hi - 1)
					{
						auto den = b[m] - a[m] + 1;
						auto num = h[best] - a[m] + 1;
						num = max (num, 0);
						num = min (num, den);
						debug {writeln (num, "/", den);}
						auto p = Rational (num,
						    den) * rightCur;
						auto q = Rational (den - num,
						    den) * rightCur;

						right = right + q *
						    solve (m + 1, hi);
						rightCur = p;
						if (rightCur.num == 0)
						{
							break;
						}
						debug {writeln (p, " ", q, " ", right);}
					}
					right = right + rightCur;

					res = left * right;
				}

				fCache[lo][hi] = res;
			}
			return fCache[lo][hi];
		}

		res = solve (0, n);
		res = Rational (1, 1) - res;
	}

	foreach (test; 0..tests) with (t[test])
	{
		write ("Case #", test + 1, ":");
		debug {write (" ", res);}
		write (" ", res.toMod);
		writeln;
	}
}
