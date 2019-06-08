module solution;
import std.algorithm;
import std.conv;
import std.range;
import std.stdio;
import std.typecons;

int [] solveNextTest ()
{
	int p;
	int q;
	readf (" %s %s", &p, &q);
	alias Person = Tuple !(int, q{x}, int, q{y}, char, q{dir});
	auto a = new Person [p];
	int [] xs = [0, q];
	int [] ys = [0, q];
	foreach (ref cur; a)
	{
		readf (" %s %s %s", &cur.x, &cur.y, &cur.dir);
		xs ~= [cur.x - 1, cur.x, cur.x + 1];
		ys ~= [cur.y - 1, cur.y, cur.y + 1];
	}
	xs = xs.sort.uniq.filter !(z => 0 <= z && z <= q).array;
	ys = ys.sort.uniq.filter !(z => 0 <= z && z <= q).array;
	debug {writefln ("%(%s\n%)", a);}

	int resX = 0;
	int goX = 0;
	foreach (curX; xs)
	{
		int curGo = 0;
		foreach (ref next; a)
		{
			curGo +=
			    (next.x < curX && next.dir == 'E') ||
			    (next.x > curX && next.dir == 'W');
		}
		debug {writeln ("x ", curX, ": ", curGo);}
		if (goX < curGo)
		{
			resX = curX;
			goX = curGo;
		}
	}

	int resY = 0;
	int goY = 0;
	foreach (curY; ys)
	{
		int curGo = 0;
		foreach (ref next; a)
		{
			curGo +=
			    (next.y < curY && next.dir == 'N') ||
			    (next.y > curY && next.dir == 'S');
		}
		debug {writeln ("y ", curY, ": ", curGo);}
		if (goY < curGo)
		{
			resY = curY;
			goY = curGo;
		}
	}

	return [resX, resY];
}

void main ()
{
	int tests;
	readf (" %s", &tests);
	foreach (test; 0..tests)
	{
		writefln ("Case #%s: %(%s %)", test + 1, solveNextTest ());
	}
}
