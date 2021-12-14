//106119100 ,CSLR 41, 22 march 2021,Question 2
#include "bits/stdc++.h"
using namespace std;
using LL = long long;

vector<int> Arr;
int N;//Size of Array 
int KEY;//Key to be searched in the array

int rangeRandom(int l,int r){
    srand(time(NULL));
    return l + rand()%(r-l+1);
}

int recursiveRandomizedBinarySearch( int l, int r ){
    if( l <= r ){
        int mid = rangeRandom(l,r);
        if( Arr[mid] == KEY ) return mid;
        if( Arr[mid] > KEY ){
            return recursiveRandomizedBinarySearch(l,mid-1);
        }
        else{
            return recursiveRandomizedBinarySearch(mid+1,r);
        }
    }

    return -1;
}

int main(){
    ios_base::sync_with_stdio(false);

    cout<<"Enter Number of elements \"N\" in sorted array  :\n";
    cin>>N;
    Arr.resize(N);
    cout<<"Enter Key  to be searched\n";
    cin>>KEY;

    cout<<"Enter Arrays Elements\n";
    for( int i = 0 ; i < N ; i++ ){
        cin>>Arr[i];
    }

    cout<<"Key "<<KEY<<" is found at index : "<<recursiveRandomizedBinarySearch(0,N-1);
    return 0;

}