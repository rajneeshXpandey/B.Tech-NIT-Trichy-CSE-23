//106119100 Rajneesh Pandey

#include <bits/stdc++.h>
using namespace std;

int GCD_divide_conquer(int num_arr[], int l, int r)
{
    if (l > r)
        return 1;
    if (l == r)
        return num_arr[l];
    int mid = l + (r - l) / 2;
    int left_num = GCD_divide_conquer(num_arr, l, mid);
    int right_num = GCD_divide_conquer(num_arr, mid + 1, r);
    return __gcd(left_num, right_num);
}
int main()
{
    int n;
    cout << "Enter number of input numbers: ";
    cin >> n;
    int num_arr[n];
    cout << "Enter numbers seperated by spaces: ";
    for (int i = 0; i < n; i++)
        cin >> num_arr[i];
    cout << "GCD of all the numbers : ";
    cout << GCD_divide_conquer(num_arr, 0, n - 1);
}