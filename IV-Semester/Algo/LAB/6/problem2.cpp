// 106119100 Rajneesh Pandey
#include<bits/stdc++.h>
using namespace std;

int dp[1001][1001];

int knapSack(int W, int wt[], int val[], int n) 
{ 
   for(int i=0;i<=n;i++)
   {
      for(int j=0;j<=W;j++)
       {if(i==0 or j==0)
          dp[i][j] = 0;}
   }
   for(int i=1;i<=n;i++)
   {
      for(int j=1;j<=W;j++)
        {
            if(wt[i-1]<=j)
                dp[i][j] = max(val[i-1]+dp[i-1][j-wt[i-1]], dp[i-1][j]);
             else 
                dp[i][j] = dp[i-1][j];
        }  }
    return dp[n][W];}
    
int main()
 {
    int t;
    cin>>t;
    while(t--)
    {   int n, w;
        cin>>n>>w;
        int val[n];
        int wt[n];
        for(int i=0;i<n;i++)
            cin>>val[i];
        for(int i=0;i<n;i++)
            cin>>wt[i];
        cout<<knapSack(w, wt, val, n)<<endl;
        }
    return 0;
 }