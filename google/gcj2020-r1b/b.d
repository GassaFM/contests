// Author: Ivan Kazmenko (gassa@mail.ru)
module solution;
import std.algorithm;
import std.conv;
import std.math;
import std.numeric;
import std.random;
import std.range;
import std.stdio;
import std.string;
import std.typecons;

immutable int limit = 1_000_000_000;

void solve ()
{
	bool ask (int x, int y)
	{
		if (x < -limit || +limit < x ||
		    y < -limit || +limit < y)
		{
			return false;
		}
		writeln (x, " ", y);
		stdout.flush ();
		auto res = readln.strip;
		if (res == "CENTER")
		{
			throw new Exception ("solved!");
		}
		return (res != "MISS");
	}

	int search (string which) (int xlo, int xhi, int ylo, int yhi)
	{
		static if (which == "x")
		{
			auto lo = xlo;
			auto hi = xhi;
			auto other = ylo;
		}
		else static if (which == "y")
		{
			auto lo = ylo;
			auto hi = yhi;
			auto other = xlo;
		}
		else
		{
			static assert (false);
		}
		while (abs (lo - hi) > 1)
		{
			auto me = hi + (lo - hi) / 2;
			auto curX = (which == "x") ? me : other;
			auto curY = (which == "y") ? me : other;
			if (ask (curX, curY))
			{
				lo = me;
			}
			else
			{
				hi = me;
			}
		}
		return lo;
	}

	int x0;
	int y0;
	while (true)
	{
		x0 = uniform (-limit, +limit + 1);
		y0 = uniform (-limit, +limit + 1);
		auto cur = ask (x0, y0);
		if (cur)
		{
			break;
		}
	}

	auto xlo = search !("x") (x0, -limit - 1, y0, y0);
	auto xhi = search !("x") (x0, +limit + 1, y0, y0);
	auto xme = xlo + (xhi - xlo) / 2;
	auto ylo = search !("y") (xme, xme, y0, -limit - 1);
	auto yhi = search !("y") (xme, xme, y0, +limit + 1);
	auto yme = ylo + (yhi - ylo) / 2;
	ask (xme, yme);
	assert (false);
}

void main ()
{
	rndGen.seed (124625);
	int tests, a, b;
	readf (" %s %s %s", &tests, &a, &b);
	readln;
	foreach (test; 0..tests)
	{
		try
		{
			solve ();
		}
		catch (Exception e)
		{
		}
	}
}
