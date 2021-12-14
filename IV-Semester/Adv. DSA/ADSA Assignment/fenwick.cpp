#include <bits/stdc++.h>
using namespace std;

vector<int> bit;  // binary indexed tree

// 1 indexed
class FenwickTree {
public:
    vector<int> bit2;  // binary indexed tree
    int n;

    FenwickTree(int n) {
        this->n = n + 1;
        bit.assign(n + 1, 0);
        bit2.assign(n + 1, 0);
    }

    FenwickTree(vector<int> a): FenwickTree(a.size()) {
        for (int i = 0; i < a.size(); i++)
            PointUpdate(i, a[i]);
    }

    //             POINT UPDATE AND POINT/RANGE QUERY
    //         USAGE: Initialize "bit" with v, Do PointUpdate(idx) and Value(l,r)=RangeQuery(l,r)

    void PointUpdate(int idx, int delta, vector<int> &b = bit) {
        for (++idx; idx < n; idx += idx & -idx)
            b[idx] += delta;
    }

    int PrefixQuery(int idx, vector<int> &b = bit) {
        int ret = 0;
        for (++idx; idx > 0; idx -= idx & -idx)
            ret += b[idx];
        return ret;
    }

    int RangeQuery(int l, int r) {
        return PrefixQuery(r) - PrefixQuery(l - 1);
    }

    //            RANGE UPDATE (l,r,delta) FOR POINT QUERIES
    //       USAGE: Initialize "bit" with 0, Do RangeUpdatePQ and Value[i] = v[i]+PrefixQuery(i)

    void RangeUpdatePQ(int l, int r, int val) {
        PointUpdate(l, val);
        PointUpdate(r + 1, -val);
    }

    //             RANGE QUERY AND RANGE UPDATES (l,r,delta)
    //       USAGE: Initialize "bit" with 0, Do RangeUpdateRQRU
    //         and Value(l,r) = pre[r]-pre[l-1]+RangeQueryRQRU(l,r)

    int PrefixQueryRQRU(int idx, vector<int> &b = bit) {
        return PrefixQuery(idx) * idx -  PrefixQuery(idx, bit2);
    }

    int RangeQueryRQRU(int l, int r) {
        return PrefixQueryRQRU(r) - PrefixQueryRQRU(l - 1);
    }

    void RangeUpdateRQRU(int l, int r, int val) {
        PointUpdate(l, val);
        PointUpdate(r + 1, -val);
        PointUpdate(l, (l - 1)*val, bit2);
        PointUpdate(r + 1, -r * val, bit2);
    }
};

int main()
{
    int n;
    cin >> n;
    vector<int> v(n), pre(n);
    for (int i = 0; i < n; i++)
    {
        cin >> v[i];
        pre[i] = v[i] + (i > 0 ? pre[i - 1] : 0);
    }

    FenwickTree ft(n); // For Range Updates
    // FenwickTree ft(v); // For Point Updates


    // POINT UPDATE AND QUERY
    ft.PointUpdate(1, 10);
    ft.RangeQuery(1, 3);

    cout << "--------------------" << endl;

    // RANGE UPDATE AND QUERY
    ft.RangeUpdateRQRU(1, 2, 10);
    ft.RangeUpdateRQRU(2, 3, 5);

    cout << (pre[3] - pre[1] + ft.RangeQueryRQRU(2, 3)) << endl;
    return 0;
}

