#include <algorithm>
#include <iostream>
using namespace std;

int main ()
{
	int tests;
	cin >> tests;
	for (int test = 0; test < tests; test++)
	{
		string s;
		cin >> s;
		auto n = int (s.size ());
		reverse (s.begin (), s.end ());
		string t (n, '0');
		for (int i = 0; i < n; i++)
		{
			if (s[i] == '4')
			{
				s[i] -= 1;
				t[i] += 1;
			}
		}
		while (t[t.size () - 1] == '0')
		{
			t.resize (t.size () - 1);
		}
		reverse (s.begin (), s.end ());
		reverse (t.begin (), t.end ());
		cout << "Case #" << test + 1 << ": " << s << " " << t << endl;
	}
	return 0;
}
