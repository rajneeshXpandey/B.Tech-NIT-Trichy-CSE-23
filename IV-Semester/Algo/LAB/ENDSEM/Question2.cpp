//Question 2 : Maximal Rectangle
// 106119100 Rajneesh Pandey

#include <bits/stdc++.h>
using namespace std;

int maxRectangle(vector<vector<char>> &matrix)
{
    if (matrix.empty())
        return 0;
    int m = matrix.size();
    int n = matrix[0].size();
    int left[n], right[n], height[n];
    //initializing the arrays
    fill_n(left, n, 0);
    fill_n(right, n, n);
    fill_n(height, n, 0);
    int maxArea = 0;
    for (int i = 0; i < m; i++)
    {
        int cur_left = 0, cur_right = n;
        for (int j = 0; j < n; j++)
        { // compute height (can do this from either side)
            if (matrix[i][j] == '1')
                height[j]++;
            else
                height[j] = 0;
        }
        for (int j = 0; j < n; j++)
        { // compute left (from left to right)
            if (matrix[i][j] == '1')
                left[j] = max(left[j], cur_left);
            else
            {
                left[j] = 0;
                cur_left = j + 1;
            }
        }
        // compute right (from right to left)
        for (int j = n - 1; j >= 0; j--)
        {
            if (matrix[i][j] == '1')
                right[j] = min(right[j], cur_right);
            else
            {
                right[j] = n;
                cur_right = j;
            }
        }
        // compute the area of rectangle (can do this from either side)
        for (int j = 0; j < n; j++)
            maxArea = max(maxArea, (right[j] - left[j]) * height[j]);
    }
    return maxArea;
}

int main()
{

    int n, m;
    cout << "----------------------------" << endl;
    cout << "Enter the Dimensions of the matrix : " << endl;
    cin >> n >> m;
    vector<vector<char>> matrix(n, vector<char>(m));
    cout << "Enter the Values in the matrix : " << endl;
    for (int i = 0; i < n; i++)
        for (int j = 0; j < m; j++)
        {
            cin >> matrix[i][j];
        }
    cout << "Maximum area of Rectangle is : " << endl;
    cout << maxRectangle(matrix) << endl;
    cout << "---------------------------" << endl;

    return 0;
}
