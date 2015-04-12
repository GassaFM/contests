import std.algorithm, std.conv, std.range, std.stdio, std.string;

void solve (int test)
{
	write ("Case #", test + 1, ": ");
	readln;
	auto a = readln // "1 8 4 2 3\n"
	    .split // ["1", "8", "4", "2", "3"]
	    .map !(to !(int)) // [1, 8, 4, 2, 3]
	    .array; // [1, 8, 4, 2, 3]

	iota (1, a.reduce !(max) + 1) // [1, 2, 3, 4, 5, 6, 7, 8]
	    .map !(x => x + a.map !(y => (y - 1) / x).sum) // [14, 7, 6, 5, 6, 7, 8, 8]
	    .reduce !(min) // 5
	    .writeln;
}

void main ()
{
	readln.strip.to !(int).iota.each !(solve);
}
