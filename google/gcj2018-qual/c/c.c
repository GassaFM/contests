#include <assert.h>
#include <stdio.h>
#include <string.h>

int const cx = 3;
int const cy = 3;
int const sx = 15;
int const sy = 14;

int z [20] [20];

int value (int x, int y)
{
	int res = 0;
	for (int dx = -1; dx <= +1; dx++)
	{
		for (int dy = -1; dy <= +1; dy++)
		{
			res += !z[x + dx][y + dy];
		}
	}
	return res;
}

int main (void)
{
	int tests;
	scanf (" %d", &tests);
	for (int test = 0; test < tests; test++)
	{
		int a;
		scanf (" %d", &a);
		memset (z, 0, sizeof (z));
		while (1)
		{
			int v = 0;
			int bx = 0;
			int by = 0;
			for (int tx = cx + 1; tx < cx + sx - 1; tx++)
			{
				for (int ty = cy + 1; ty < cy + sy - 1; ty++)
				{
					int w = value (tx, ty);
					if (v < w)
					{
						v = w;
						bx = tx;
						by = ty;
					}
				}
			}
			assert (v > 0);
			printf ("%d %d\n", bx, by);
			fflush (stdout);
			int ax;
			int ay;
			scanf (" %d %d", &ax, &ay);
			if (ax == 0 && ay == 0)
			{
				break;
			}
			z[ax][ay] += 1;
		}
	}

	return 0;
}
