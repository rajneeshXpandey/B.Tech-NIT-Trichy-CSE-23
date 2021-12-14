// Question 1 : Find missing term in a sequence in log(n) time
// 106119100 Rajneesh Pandey

#include <bits/stdc++.h>
using namespace std;

int findMissingTerm(int arr[], int n)
{
    // search space is `arr[low…high]`
    int low = 0, high = n - 1;

    // calculate the common difference between successive elements
    int d = (arr[n - 1] - arr[0]) / n;

    // loop till the search space is exhausted
    while (low <= high)
    {
        // find the middle index
        int mid = high - (high - low) / 2;

        // check the difference of middle element with its right neighbor
        if (mid + 1 < n && arr[mid + 1] - arr[mid] != d)
        {
            return arr[mid + 1] - d;
        }

        // check the difference of middle element with its left neighbor
        if (mid - 1 >= 0 && arr[mid] - arr[mid - 1] != d)
        {
            return arr[mid - 1] + d;
        }

        // if the missing element lies on the left subarray, reduce
        // our search space to the left subarray `arr[low…mid-1]`
        if (arr[mid] - arr[0] != (mid - 0) * d)
        {
            high = mid - 1;
        }
        // if the missing element lies on the right subarray, reduce
        // our search space to the right subarray `arr[mid+1…high]`
        else
        {
            low = mid + 1;
        }
    }
    return 0;
}

int main()
{

    int n;
    cout << "---------------------------" << endl;
    cout << "Enter the size of the array : " << endl;
    cin >> n;
    int array[n];
    cout << "Enter the Values in the array : " << endl;
    for (int i = 0; i < n; i++)
    {
        cin >> array[i];
    }
    cout << "Missing Term is : " << endl;
    cout << findMissingTerm(array, n) << endl;
    cout << "---------------------------" << endl;

    return 0;
}