// 106119100 Rajneesh Pandey

// SSTF disk scheduling

#include <bits/stdc++.h>
using namespace std;

void calculatedifference(int request[], int head, int diff[][2], int n)
{
    for (int i = 0; i < n; i++)
        diff[i][0] = abs(head - request[i]);
    }

int findMIN(int diff[][2], int n)
{
    int index = -1;
    int minimum = 1e9;

    for (int i = 0; i < n; i++)
    {
        if (!diff[i][1] && minimum > diff[i][0])
        {
            minimum = diff[i][0];
            index = i;
        }
    }
    return index;
}

void shortestSeekTimeFirst(int request[],int head, int n)
{
    if (n == 0)
        return;
    int diff[n][2] = {{0, 0}};
    int seekcount = 0;
    int seeksequence[n + 1] = {0};

    for (int i = 0; i < n; i++)
    {
        seeksequence[i] = head;
        calculatedifference(request, head, diff, n);
        int index = findMIN(diff, n);
        diff[index][1] = 1;
        seekcount += diff[index][0];
        head = request[index];
    }
    seeksequence[n] = head;
    cout << "Total number of seek operations = "<< seekcount << endl;
    cout << "Seek sequence is : "<< "\n";

    for (int i = 0; i <= n; i++)
    {
        cout << seeksequence[i] << "\n";
    }
}

int main()
{
    int n = 8;
    int proc[n] = {176, 79, 34, 60, 92, 11, 41, 114};
    shortestSeekTimeFirst(proc, 50, n);
    return 0;
}
