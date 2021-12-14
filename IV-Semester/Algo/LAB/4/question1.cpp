#include <bits/stdc++.h>

#define INF 1e7

using namespace std;

int main() {
    int m, n;
    cout << "Enter the size of array 1: ";
    cin >> m;
    cout << "Enter the size of array 2: ";
    cin >> n;
    int a[m], b[n];
    cout << "Enter the elements of array 1: ";
    for(int i = 0; i < m; i++)
        cin >> a[i];
    cout << "Enter the elements of array 2: ";
    for(int i = 0; i < n; i++)
        cin >> b[i];
    cout<<"Median of both array is: ";
    if(m>=n){
        int lo = 0, hi = n * 2;
        while (lo <= hi) {
            int mid2 = (lo + hi) / 2;
            int mid1 = n + m - mid2;
            
            double w = (mid1 == 0) ? -INF : a[(mid1-1)/2];
            double x = (mid2 == 0) ? -INF : b[(mid2-1)/2];
            double y = (mid1 == m * 2) ? INF : a[(mid1)/2];
            double z = (mid2 == n * 2) ? INF : b[(mid2)/2];
            
            if (w > z) lo = mid2 + 1;
            else if (x > y) hi = mid2 - 1;
            else {
                cout<< (max(w,x) + min(z, y)) / 2 << endl;
                return 0;
            }
                
        }
    }
    else{
        int lo = 0, hi = m * 2;
        while (lo <= hi) {
            int mid2 = (lo + hi) / 2;
            int mid1 = n + m - mid2;
            
            double w = (mid1 == 0) ? -INF : b[(mid1-1)/2];
            double x = (mid2 == 0) ? -INF : a[(mid2-1)/2];
            double y = (mid1 == n * 2) ? INF : b[(mid1)/2];
            double z = (mid2 == m * 2) ? INF : a[(mid2)/2];
            
            if (w > z) lo = mid2 + 1;
            else if (x > y) hi = mid2 - 1;
            else {
                cout<< (max(w,x) + min(z, y)) / 2 << endl;
                return 0;
            }
                
        }
    }
    return 0;
}