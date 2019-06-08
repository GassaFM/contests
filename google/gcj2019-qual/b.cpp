#include <iostream>
using namespace std;

int main ()
{
	int tests;
	cin >> tests;
	for (int test = 0; test < tests; test++)
	{
		int n;
		cin >> n;
		string s;
		cin >> s;
		for (int i = 0; i < int (s.size ()); i++)
		{
			s[i] = 'S' + 'E' - s[i];
		}
		cout << "Case #" << test + 1 << ": " << s << endl;
	}
	return 0;
}
