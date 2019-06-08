module solution;
import std.stdio;

void main ()
{
	int tests;
	int w;
	readf (" %s %s", &tests, &w);
	foreach (test; 0..tests)
	{
		writeln (55);
		stdout.flush ();
		ulong lo;
		readf (" %s", &lo);

		writeln (185);
		stdout.flush ();
		ulong hi;
		readf (" %s", &hi);

		auto a = new int [7];
		a[4] |= (hi >> (185 / 4)) & 0b01111111;
		a[5] |= (hi >> (185 / 5)) & 0b01111111;
		a[6] |= (hi >> (185 / 6)) & 0b01111111;
		debug {stderr.writeln ((hi >> (185 / 4)) & 0b01111111);}
		debug {stderr.writeln ((hi >> (185 / 5)) & 0b01111111);}
		debug {stderr.writeln ((hi >> (185 / 6)) & 0b01111111);}
		lo -= (a[4] << (55 / 4));
		lo -= (a[5] << (55 / 5));
		lo -= (a[6] << (55 / 6));
		a[1] |= (lo >> ( 55 / 1)) & 0b01111111;
		a[2] |= (lo >> ( 55 / 2)) & 0b01111111;
		a[3] |= (lo >> ( 55 / 3)) & 0b01111111;
		debug {stderr.writeln ((lo >> ( 55 / 1)) & 0b01111111);}
		debug {stderr.writeln ((lo >> ( 55 / 2)) & 0b01111111);}
		debug {stderr.writeln ((lo >> ( 55 / 3)) & 0b01111111);}

		writefln ("%(%s %)", a[1..7]);
		stdout.flush ();
		int res;
		readf (" %s", &res);
		if (res != 1)
		{
			assert (false);
		}
	}
}
