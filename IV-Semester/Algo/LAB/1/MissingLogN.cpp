// Find missing term in a sequence in log(n) time : Given a sequence of numbers such that
// the difference between the consecutive terms is constant, find missing term in it in O(log (n))
// time. (Example: Input : [5, 7, 9, 11, 15], Output: 13)

#include <bits/stdc++.h>
using namespace std;

int missing(int arr[],int n,int start,int end,int diff)
{ int ans = -1;
    while(start<=end)
    {
        int mid = (start + end) / 2;
        
        if (arr[mid+1] - arr[mid] != diff)
        { 
          ans = (arr[mid]+diff);
          break;
        }
        else if (arr[mid] == (arr[start] + ((mid) - 1) * diff))
            start = mid+1;
        else if (arr[mid] != (arr[start] + ((mid) - 1) * diff))
            end = mid-1;          
    }
    return ans;
}

int main()
{
 //taking the input 'n' and the difference of sequence 'd'
    int n,d;
    cin >> n >>d;
    int array[n];
//taking input of sequence of array 
    for (int i = 1; i <= n; i++)
        cin >> array[i];

    int missing_term = missing(array,n,1,n,d);

    cout<<missing_term<<endl; 

    return 0;      
}
