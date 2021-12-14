// 106119100 Rajneesh Pandey
#include <bits/stdc++.h>
using namespace std;

int maxCoins(vector<int> &nums)
{
    int n = nums.size();
    vector<vector<int>> f(n + 1, vector<int>(n + 1, -1));
    vector<int> nums1(n + 2, 1);
    for (int i = 0; i < n; ++i)
    {
        nums1[i + 1] = nums[i];
    }
    return search(nums1, f, 1, n);
}
int search(const vector<int> &nums, vector<vector<int>> &f, const int i, const int j)
{
    if (i > j)
    {
        return 0;
    }
    if (f[i][j] >= 0)
    {
        return f[i][j];
    }
    for (int k = i; k <= j; ++k)
    {
        f[i][j] = max(f[i][j], search(nums, f, i, k - 1) + search(nums, f, k + 1, j) + nums[k] * nums[i - 1] * nums[j + 1]);
    }
    return f[i][j];
}
int main()
{
    int n;
    cin >> n;
    vector<int> nums(n);
    for (int i = 0; i < n; i++)
        cin >> nums[i];
   cout<< maxCoins(nums);
     return 0;
}
