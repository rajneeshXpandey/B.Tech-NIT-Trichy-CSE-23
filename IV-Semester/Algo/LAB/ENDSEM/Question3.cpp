// Question 3 : Fitting Shelves Problem
// 106119100 Rajneesh Pandey

#include <bits/stdc++.h>
using namespace std;

void minSpacePreferLarge(int wall, int m, int n)
{
    // for simplicity, Assuming m is always smaller than n
    // initializing output variables
    int num_m = 0, num_n = 0, min_empty = wall;

    // p and q are no of shelves of length m and n
    // rem is the empty space
    int p = wall / m, q = 0, rem = wall % m;
    num_m = p;
    num_n = q;
    min_empty = rem;
    while (wall >= n)
    {
        // place one more shelf of length n
        q += 1;
        wall = wall - n;
        // place as many shelves of length m
        // in the remaining part
        p = wall / m;
        rem = wall % m;

        // update output variablse if curr
        // min_empty <= overall empty
        if (rem <= min_empty)
        {
            num_m = p;
            num_n = q;
            min_empty = rem;
        }
    }
    cout << num_m << " " << num_n << " " << min_empty << endl;
}

// Driver code
int main()
{
    int wall, m, n;
    cout << "--------------------------------" << endl;
    cout << "Enter the value of wall(w) : " << endl;
    cin >> wall;
    cout << "Enter the value of m : " << endl;
    cin >> m;
    cout << "Enter the value of n : " << endl;
    cin >> n;
    cout << "Number of each type of shelf to be used and the remaining empty space : " << endl;
    minSpacePreferLarge(wall, m, n);
    cout << "-------------------------------------" << endl;
    return 0;
}
