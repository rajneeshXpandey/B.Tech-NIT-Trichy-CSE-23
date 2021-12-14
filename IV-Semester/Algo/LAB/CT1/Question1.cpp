//106119100 Rajneesh Pandey

#include <bits/stdc++.h>
using namespace std;

int WiggleSubsequence(vector<int> &nums)
{
    int size = nums.size(), f = 1, d = 1;
    for (int i = 1; i < size; ++i)
    {
        if (nums[i] > nums[i - 1])
            f = d + 1;
        else if (nums[i] < nums[i - 1])
            d = f + 1;
    }
    return min(size, max(f, d));
}

int main()
{
    int n;
    cin >> n;

    vector<int> numbers(n);
    for (int i = 0; i < n; i++)
        cin >> numbers[i];

    cout << WiggleSubsequence(numbers);
    return 0;
}
