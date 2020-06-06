module solution;
import std.algorithm;
import std.conv;
import std.stdio;
import std.string;

void main ()
{
	auto tests = readln.strip.to !(int);
	foreach (test; 0..tests)
	{
		auto s = readln.split;
		auto p = levenshteinDistanceAndPath (s[0], s[1]);
		debug {writeln (p);}
		int cur = 0;
		int curOther = 0;
		int cost = 0;
		auto answer = s[0].dup;
		foreach (op; p[1])
		{
			if (cost * 2 >= p[0])
			{
				break;
			}
			if (op == EditOp.none)
			{
				cur += 1;
				curOther += 1;
			}
			else if (op == EditOp.substitute)
			{
				answer[cur] = s[1][curOther];
				cur += 1;
				curOther += 1;
				cost += 1;
			}
			else if (op == EditOp.insert)
			{
				answer = answer[0..cur] ~ s[1][curOther] ~
				    answer[cur..$];
				cur += 1;
				curOther += 1;
				cost += 1;
			}
			else if (op == EditOp.remove)
			{
				answer = answer[0..cur] ~
				    answer[cur + 1..$];
				cost += 1;
			}
			else
			{
				assert (false);
			}
		}
		writeln ("Case #", test + 1, ": ", answer);
	}
}
