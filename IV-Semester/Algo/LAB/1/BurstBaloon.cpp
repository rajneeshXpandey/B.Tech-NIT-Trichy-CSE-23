// Given n balloons, indexed from 0 to n-1. Each balloon is painted with a number on it
// represented by array nums. You are asked to burst all the balloons. If the you burst balloon i
// you will get nums[left] * nums[i] * nums[right] coins. Here left and right are adjacent indices
// of i. After the burst, the left and right then becomes adjacent. Find the maximum coins you
// can collect by bursting the balloons wisely. [Note: You may imagine nums[-1] = nums[n] =
// 1. They are not real therefore you can not burst them. 0 ≤ n ≤ 500, 0 ≤ nums[i] ≤ 100 ]

//106119100

#include <bits/stdc++.h>
#include <iostream>
using namespace std;


int BaloonBurst(int A[], int N)
{
    // Add Bordering Balloons
    int B[N + 2];

    B[0] = 1;
    B[N + 1] = 1;

    for (int i = 1; i <= N; i++)
        B[i] = A[i - 1];

    // Declare DP Array
    int dp[N + 2][N + 2];
    memset(dp, 0, sizeof(dp));

    for (int length = 1; length < N + 1; length++)
    {
        for (int left = 1; left < N - length + 2; left++)
        {
            int right = left + length - 1;
            // For a sub-array from indices left, right
            // This innermost loop finds the last balloon burst
            for (int last = left; last < right + 1; last++)
            {
                dp[left][right] = max(dp[left][right],dp[left][last - 1] +B[left - 1] * B[last] * B[right + 1] +dp[last + 1][right]);
            }
        }
    }
    return dp[1][N];
}

// Driver code
int main()
{
   int n;
   cin>>n;
   int array[n];
   for (size_t i = 0; i < n; i++)
   {
       cin>>array[i];
   }

    // Calling function
   cout << BaloonBurst(array, n) << endl;
}
