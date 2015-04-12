import std.algorithm, std.conv, std.range, std.stdio, std.string;

enum {E, I, J, K};

struct Q
{
	int s = +1;
	int v = E;

	this (int ns, int nv)
	{
		s = ns;
		v = nv;
	}

	this (dchar ch)
	{
		s = +1;
		if (ch == 'i')
		{
			v = I;
		}
		else if (ch == 'j')
		{
			v = J;
		}
		else if (ch == 'k')
		{
			v = K;
		}
		else
		{
			assert (false);
		}
	}

	Q opBinary (string op) (Q other)
	    if (op == "*")
	{
		Q res = MULT[v][other.v];
		res.s *= s * other.s;
		return res;
	}

	string toString ()
	{
		return "" ~ "+-"[s == -1] ~ "1ijk"[v];
	}
}

immutable Q [4] [4] MULT =
    [[Q (+1, E), Q (+1, I), Q (+1, J), Q (+1, K)],
     [Q (+1, I), Q (-1, E), Q (+1, K), Q (-1, J)],
     [Q (+1, J), Q (-1, K), Q (-1, E), Q (+1, I)],
     [Q (+1, K), Q (+1, J), Q (-1, I), Q (-1, E)]];

immutable int LIMIT = 4;

bool go ()
{
	long l, x;
	readf (" %s %s ", &l, &x);
	x = min (x, LIMIT * 3 + x % LIMIT);
	Q t;
	auto s = readln
	    .strip
	    .repeat (cast (size_t) x)
	    .join
	    .map !(r => Q (r))
	    .array;
	s.each !((ref r) => t = r = t * r);
	debug {writeln (s);}
	if (s.back != Q (+1, I) * Q (+1, J) * Q (+1, K))
	{
		return false;
	}
	return s.find (Q (+1, I)).find (Q (+1, I) * Q (+1, J)).length > 0;
}

void solve (int test)
{
	write ("Case #", test + 1, ": ");
	writeln (go () ? "YES" : "NO");
}

void main ()
{
	readln.strip.to !(int).iota.each !(solve);
}
