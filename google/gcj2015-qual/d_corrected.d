import std.algorithm, std.conv, std.exception, std.range, std.stdio, std.string;

bool go (int x, int r, int c)
{
	enforce (r <= c);
	if ((r * c) % x != 0)
	{
		return false;
	}
	if (c < x) // straight line does not fit
	{
		return false;
	}
	if (r < (x + 1) / 2) // zig-zag does not fit
	{
		return false;
	}
	if (x >= 7) // hole in polyomino
	{
		return false;
	}
	if (x <= 3) // put in corner
	{
		return true;
	}
	if (r + c - x <= 2) // zig-zag separates rectangle
	{
		return false;
	}
	if (x == 5 && r == 3 && c > 7) // can move zig-zag
	{
		return true;
	}
	if (r == (x + 1) / 2) // zig-zag separates rectangle
	{
		return false;
	}
	return true; // put in corner, maintain connectivity
}

void solve (int test)
{
	write ("Case #", test + 1, ": ");
	int x, r, c;
	readf (" %s %s %s", &x, &r, &c);
	writeln (go (x, min (r, c), max (r, c)) ? "GABRIEL" : "RICHARD");
}

void main ()
{
	readln.strip.to !(int).iota.each !(solve);
}
