module solution;
import std.algorithm;
import std.range;
import std.stdio;
import std.typecons;

immutable long total = 10L ^^ 12;
immutable long span = 10L ^^ 10;

alias Segment = Tuple !(long, q{a}, long, q{b});

void main ()
{
	int tests;
	readf (" %s", &tests);
	int w;
	readf (" %s", &w);
	foreach (test; 0..tests)
	{
		Segment [] s;
		s.reserve (101);
		s ~= Segment (1L, total + 1L);

		void go (long r, bool self = true)
		{
			auto c = s.find !(line =>
			    line.a <= r && r < line.b);
			if (c.empty)
			{
				assert (false);
			}
			s ~= Segment (r + span, c.front.b);
			c.front.b = r;
			if (self)
			{
				writeln (r);
				stdout.flush ();
			}
		}

		while (true)
		{
			long r;
			readf (" %s", &r);
			if (r > 0)
			{
				go (r, false);
				auto c3 = s.find !(line =>
				    line.b - line.a > span * 3 - 2);
				if (!c3.empty)
				{
					go (max (c3.front.a,
					    c3.front.b - span * 3));
					continue;
				}
				auto c1 = s.find !(line =>
				    span * 1 <= line.b - line.a &&
				    line.b - line.a <= span * 2 - 1);
				auto c2 = s.find !(line =>
				    span * 2 <= line.b - line.a &&
				    line.b - line.a <= span * 3 - 2);
				auto k1 = s.count !(line =>
				    span * 1 <= line.b - line.a &&
				    line.b - line.a <= span * 2 - 1);
				auto k2 = s.count !(line =>
				    span * 2 <= line.b - line.a &&
				    line.b - line.a <= span * 3 - 2);
				auto g = (k1 & 1) * 1 + (k2 & 1) * 2;
				switch (g)
				{
				case 0:
					go (chain (c1, c2).front.a);
					continue;
				case 1:
					go (c1.front.a);
					continue;
				case 2:
					go (c2.front.a + span - 1);
					continue;
				case 3:
					go (c2.front.a + span);
					continue;
				default:
					assert (false);
				}
			}
			else
			{
				if (r == -1)
				{
					return;
				}
				break;
			}
		}
	}
}
