module solution;
import std.algorithm;
import std.conv;
import std.range;
import std.stdio;
import std.string;

struct Solver
{
	int question;
	int answer;
	int result1;
	int result2;
	bool [] fin;
	int [] sub;
	int n;

	this (int n_)
	{
		n = n_;
		fin = new bool [n];
		sub = new int [n];
		question = -1;
		answer = 0;
		result1 = 0;
		result2 = 1;
	}

	void work ()
	{
		if (question != -1)
		{
			if (answer == 1)
			{
				sub[question] += 1;
			}
			else
			{
				fin[question] = true;
			}
			question = -1;
		}

		bool done = false;

		bool checkAtMost (int pos, int num)
		{
			if (fin[pos] && sub[pos] <= num)
			{
				return true;
			}
			if (sub[pos] > num)
			{
				return false;
			}
			question = pos;
			done = true;
			return false;
		}

		bool checkSegmentAtMost (int lo, int hi, int limit)
		{
			int total = 0;
			foreach (pos; lo..hi)
			{
				total += (checkAtMost (pos, limit));
				if (done)
				{
					return false;
				}
				if (total > limit)
				{
					result1 = (max (n - 2, pos + 1)) % n;
					while (fin[result1])
					{
						result1 = (result1 + 1) % n;
					}
					result2 = (result1 + 1) % n;
					while (fin[result2])
					{
						result2 = (result2 + 1) % n;
					}
					question = -1;
					return true;
				}
			}
			return false;
		}

		if (checkSegmentAtMost (0, 2, 1) || done)
		{
			return;
		}

		if (checkSegmentAtMost (0, n, 2) || done)
		{
			return;
		}

		result1 = 0;
		while (fin[result1]) result1 = (result1 + 1) % n;
		result2 = (result1 + 1) % n;
		while (fin[result2]) result2 = (result2 + 1) % n;
		question = -1;
	}
}

void main ()
{
	int t, n, c;
	readf (" %s %s %s", &t, &n, &c);
	readln;
	Solver [] s;
	s.reserve (t);
	foreach (i; 0..t)
	{
		s ~= Solver (n);
	}
	debug {auto ferr = File ("err.txt", "wt");}

	bool ask ()
	{
		auto p = new int [t];
		foreach (i; 0..t)
		{
			s[i].work ();
			p[i] = s[i].question + 1;
		}
		writefln ("%(%s %)", p);
		stdout.flush ();
		if (!any (p))
		{
			return false;
		}
		auto r = readln.splitter.map !(to !(int)).array;
		debug {ferr.writeln (r); ferr.flush ();}
		foreach (i; 0..t)
		{
			s[i].answer = r[i];
		}
		return true;
	}

	while (ask ())
	{
	}

	int [] z;
	z.reserve (t * 2);
	foreach (i; 0..t)
	{
		z ~= s[i].result1 + 1;
		z ~= s[i].result2 + 1;
	}
	writefln ("%(%s %)", z);
	stdout.flush ();
}
