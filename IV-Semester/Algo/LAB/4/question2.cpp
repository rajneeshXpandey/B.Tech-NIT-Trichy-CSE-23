#include <iostream>
#include <vector>
#include <utility>

#define val(x) x.first
#define pos(x) x.second

using namespace std;

// modified merge function in merge sort to count the elements
// lesser to the right
void merge(vector<int> &count, vector<pair<int, int>> &arr, int left, int mid, int right)
{
    vector<pair<int, int>> temp(right - left + 1);
    int i = left;
    int j = mid + 1;
    int k = 0;

    while (i <= mid && j <= right)
    {
        if (val(arr[i]) <= val(arr[j]))
        {
            temp[k++] = arr[j++];
        }
        else
        {
            count[pos(arr[i])] += right - j + 1;
            temp[k++] = arr[i++];
        }
    }

    while (i <= mid)
        temp[k++] = arr[i++];

    while (j <= right)
        temp[k++] = arr[j++];

    for (int i = left; i <= right; i++)
        arr[i] = temp[i - left];
}

void merge_sort(vector<int> &count, vector<pair<int, int>> &arr, int left, int right)
{
    if (left < right)
    {
        int mid = left + (right - left) / 2;
        merge_sort(count, arr, left, mid);
        merge_sort(count, arr, mid + 1, right);
        merge(count, arr, left, mid, right);
    }
}

void solve(vector<int> &nums)
{
    int n = nums.size();
    vector<int> count(n, 0);
    vector<pair<int, int>> arr(n);
    for (int i = 0; i < n; i++)
        arr[i] = make_pair(nums[i], i);

    merge_sort(count, arr, 0, n - 1);

    for (int i = 0; i < n; i++)
        cout << count[i] << " ";
    cout << "\n";
}

int main()
{
    int n;
    cout << "Enter the number of elements: ";
    cin >> n;
    vector<int> nums(n);
    cout << "Enter the elements: ";
    for (int i = 0; i < n; i++)
        cin >> nums[i];
    solve(nums);
    return 0;
}
