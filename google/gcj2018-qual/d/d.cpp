#include <algorithm>
#include <cstdio>
#include <cmath>
#include <cstdlib>
#include <iostream>

using namespace std;

typedef long double real;

#define PI 3.1415926535897932384626433832795L
real x [3];
real y [3];
real z [3];
real volume;

void calculate ()
{
	real xa = +x[0] + -x[1] + +x[2];
	real za = +z[0] + -z[1] + +z[2];
	real xb = +x[0] + -x[1] + -x[2];
	real zb = +z[0] + -z[1] + -z[2];
	real xc = +x[0] + +x[1] + -x[2];
	real zc = +z[0] + +z[1] + -z[2];
	volume = (xb + xa) * (zb - za) + (xc + xb) * (zc - zb);
	volume /= 4;
}

void gun (real a)
{
	x[0] = +cos (a);
	y[0] = +sin (a);
	z[0] = 0;
	x[1] = +sin (PI / 4) * -sin (a);
	y[1] = +sin (PI / 4) * +cos (a);
	z[1] = +cos (PI / 4);
	x[2] = +cos (PI / 4) * -sin (a);
	y[2] = +cos (PI / 4) * +cos (a);
	z[2] = -sin (PI / 4);
}

void solve (real a)
{
	real lo = PI / 2.0;
	real hi = PI / 5.1;
	for (int step = 0; step < 200; step++)
	{
		real me = (lo + hi) * 0.5L;
		gun (me);
		calculate ();
		if (volume < a)
		{
			lo = me;
		}
		else
		{
			hi = me;
		}
	}
}

int main (void)
{
	cout.precision (10);
	cout << fixed;
	int tests;
	cin >> tests;
	for (int test = 0; test < tests; test++)
	{
		real a;
		cin >> a;
		cout << "Case #" << (test + 1) << ": " << endl;
		solve (a);
		for (int i = 0; i < 3; i++)
		{
			cout << x[i] * 0.5 << " " << y[i] * 0.5 << " " <<
			    z[i] * 0.5 << endl;
		}
	}

	return 0;
}
