//106119100 ,CSLR 41, 22 march 2021,Question 1

#include "bits/stdc++.h"
using namespace std;
using LL = long long;
using matrix = vector<vector<int>>;

matrix X,Y,Z;
int N,K ;//Size of Square matrix and Number of iterations to be made

int random(){
    srand(time(NULL));
    return rand()%2;
}

matrix multiply(matrix &A,matrix &B){
    assert( A[0].size() == B.size() );
    matrix res;
    res.assign(A.size(),vector<int>(B[0].size(),0));
    int temp;
    for( int i = 0 ; i < A.size() ; i++ ){
        for( int j = 0; j < B[0].size() ; j++ ){
            temp = 0;
            for( int k = 0 ; k < B.size() ; k++ ){
                temp = temp + A[i][k] * B[k][j];
            }
            res[i][j] = temp;
        }
    }

    return res;
}

matrix addition(matrix &A,matrix &B){
    assert( A.size() == B.size() && A[0].size() == B[0].size() );
    matrix res;
    res.assign(A.size(),vector<int>(B[0].size(),0));
    int temp;
    for( int i = 0 ; i < A.size() ; i++ ){
        for( int j = 0; j < B[0].size() ; j++ ){
           res[i][j] = A[i][j] + B[i][j];
        }
    }
    return res;
}

matrix subtraction(matrix &A,matrix &B){
    assert( A.size() == B.size() && A[0].size() == B[0].size() );
    matrix res;
    res.assign(A.size(),vector<int>(B[0].size(),0));
    int temp;
    for( int i = 0 ; i < A.size() ; i++ ){
        for( int j = 0; j < B[0].size() ; j++ ){
           res[i][j] = A[i][j] - B[i][j];
        }
    }
    return res;
}

matrix RANDOM(int sz){
    matrix res;
    res.assign(sz,vector<int>(1,0));
    for( int i = 0 ; i < sz ; i++ ){
        res[i][0] = random()%2;
    }
    return res;
}

bool freivald(){
    matrix R = RANDOM(N);

    matrix YR = multiply(Y,R);
    matrix XYR = multiply(X,YR);
    matrix ZR = multiply(Z,R);
    matrix fin = subtraction(XYR,ZR);

    for( int i = 0 ; i < N ; i++ ){
        if( fin[i][0] != 0 ) return false;
    }

    return true;
}

void solve(){
    while( K-- ){
        if( !freivald() ) {
            cout<<"NO\n";
            return;
        }
    }
    cout<<"YES";
}

int main(){
    ios_base::sync_with_stdio(false);

    cout<<"Enter Size of square matrix N :\n";
    cin>>N;
    cout<<"Enter Number of Preferred Iterations K :\n";
    cin>>K;

    X.resize(N,vector<int>(N));
    Y.resize(N,vector<int>(N));
    Z.resize(N,vector<int>(N));

    cout<<"Enter Matrix X :\n";
    for( int i = 0 ; i < N ; i++ ){
        for( int j = 0 ; j < N ; j++ ){
            cin>>X[i][j];
        }
    }

    cout<<"Enter Matrix Y :\n";
    for( int i = 0 ; i < N ; i++ ){
        for( int j = 0 ; j < N ; j++ ){
            cin>>Y[i][j];
        }
    }

    cout<<"Enter Matrix Z :\n";
    for( int i = 0 ; i < N ; i++ ){
        for( int j = 0 ; j < N ; j++ ){
            cin>>Z[i][j];
        }
    }
    cout<<"\n";
    solve();
}