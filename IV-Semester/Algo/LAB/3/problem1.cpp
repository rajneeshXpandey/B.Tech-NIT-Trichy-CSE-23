//106119100 Rajneesh Pandey

#include <bits/stdc++.h>
using namespace std;
void string_swap(string *st1, string *st2)
{
    string temp = *st1;
    *st1 = *st2;
    *st2 = temp;
}
int string_partition(string string_arr[], int low, int high)
{
    string pivot = string_arr[high];
    int i = low;
    for (int j = low; j <= high - 1; j++)
        if (string_arr[j] < pivot)
            string_swap(&string_arr[i], &string_arr[j]);
    string_swap(&string_arr[i + 1], &string_arr[high]);
    return (i + 1);
}
void String_quickSort(string string_arr[], int low, int high)
{
    if (low < high)
    {
        int part = string_partition(string_arr, low, high);
        String_quickSort(string_arr, low, part - 1);
        String_quickSort(string_arr, part + 1, high);
    }
}
int main()
{
    int n;
    cout << "Enter the number of strings to arrange: ";
    cin >> n;
    string string_arr[n];
    cout << "Enter Strings seperated by space: ";
    for (int i = 0; i < n; i++)
        cin >> string_arr[i];
    String_quickSort(string_arr, 0, n-1);
    cout << "Strings in Alphabetical Order : \n";
    for (int i = 0; i < n; i++)
        cout << string_arr[i] << endl;
    return 0;
}
