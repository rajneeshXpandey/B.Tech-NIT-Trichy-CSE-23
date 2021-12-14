//106119100 Rajneesh Pandey

#include <bits/stdc++.h>

using namespace std;
void display_path(vector<int> path)
{
    cout << "DISPLAYING PATH" << endl;
    for (int a : path)
    {
        cout << a << " ";
    }
    cout << endl;
}
int helper(vector<vector<int>> &grid, map<int, bool> &m, int st)
{
    int cost = INT_MAX;
    bool flag = false;
    m[st] = true;
    for (int i = 0; i < grid.size(); i++)
    {
        int mini = -1;
        if (!m[i] && i != st)
        {
            mini = grid[st][i];
            mini += helper(grid, m, i);
            flag = true;
            if (mini < cost)
            {
                cost = mini;
            }
        }
    }
    m[st] = false;
    if (flag)
        return cost;
    return grid[st][0];
}

int main()
{
    vector<vector<int>> grid = {
        {0, 10, 15, 20},
        {5, 0, 9, 10},
        {6, 13, 0, 12},
        {8, 8, 9, 0}};
    map<int, bool> m;
    int cost = helper(grid, m, 0);
    cout << cost;
}