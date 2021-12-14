// 106119100  Rajneesh Pandey

#include <iostream>
using namespace std;

void CalculateWaitingTime(int processes[], int n, int bt[], int wt[])
{
    wt[0] = 0;
    for (int i = 1; i < n; i++)
        wt[i] = bt[i - 1] + wt[i - 1];
}

void CalculateTurnAroundTime(int processes[], int n, int bt[], int wt[], int tat[])
{
    for (int i = 0; i < n; i++)
        tat[i] = bt[i] + wt[i];
}

void CalculateAvgTime(int processes[], int n, int bt[])
{
    int wt[n], tat[n], total_wt = 0, total_tat = 0;

    CalculateWaitingTime(processes, n, bt, wt);

    CalculateTurnAroundTime(processes, n, bt, wt, tat);

    cout << "Processes No.: "
         << " Burst time: "
         << " Waiting time: "
         << " Turn around time:\n ";

    for (int i = 0; i < n; i++)
    {
        total_wt = total_wt + wt[i];
        total_tat = total_tat + tat[i];
        cout << i + 1 << "\t\t" << bt[i] << "\t\t " << wt[i] << "\t\t " << tat[i] << endl;
    }

    cout << "Average waiting time= " << (float)total_wt / (float)n;
    cout << "\nAverage turn around time= " << (float)total_tat / (float)n << " " << endl;
    cout << "----------------------------------------" << endl;
}

int main()
{
    int n;
    cin >> n;
    int processes[n];
    int burst_time[n];

    for (int i = 0; i < n; i++)
        processes[i] = i + 1;

    for (int i = 0; i < n; i++)
        cin >> burst_time[i];
    cout << "-----------------" << endl;
    cout << " OUTPUT : " << endl;
    cout << " ------" << endl;
    cout << endl;
    CalculateAvgTime(processes, n, burst_time);
    return 0;
}
