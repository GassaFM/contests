import java.lang.*;
import java.util.*;

public class Solution {
	static int cost (String s) {
		int res = 0;
		int cur = 1;
		for (char c : s.toCharArray ()) {
			if (c == 'S') {
				res += cur;
			} else if (c == 'C') {
				cur *= 2;
			} else {
				assert (false);
			}
		}
		return res;
	}

	static String improve (String s) {
		for (int pos = s.length () - 2; pos >= 0; pos--) {
			if (s.charAt (pos + 0) == 'C' &&
			    s.charAt (pos + 1) == 'S') {
				return s.substring (0, pos) +
				    s.charAt (pos + 1) +
				    s.charAt (pos + 0) +
				    s.substring (pos + 2, s.length ());
			}
		}
		return "";
	}

	public static void main (String [] args) {
		Scanner in = new Scanner (System.in);
		int tests = in.nextInt ();
		for (int test = 0; test < tests; test++) {
			int d = in.nextInt ();
			String s = in.next ();
			int res = 0;
			while (cost (s) > d) {
				s = improve (s);
				if (s == "") {
					break;
				}
				res += 1;
			}
			System.out.print ("Case #" + (test + 1) + ": ");
			if (s == "") {
				System.out.println ("IMPOSSIBLE");
			} else {
				System.out.println (res);
			}
		}
	}
}
