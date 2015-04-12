import std.algorithm, std.conv, std.range, std.stdio, std.string;

void solve (int test)
{
	write ("Case #", test + 1, ": ");
	auto a = readln // "4 01032\n"
	    .split // ["4", "01032"]
	    .back // "01032"
	    .map !(x => x - '0'); // [0, 1, 0, 3, 2]
	a.walkLength // 5
	    .iota // [0, 1, 2, 3, 4]
	    .map !(x => cast (int) (x - a.takeExactly (x).sum)) // [1, 1, 2, 0, -1]
	    .reduce !(max) // 2
	    .writeln;
}

void main ()
{
	readln.strip.to !(int).iota.each !(solve);
}
