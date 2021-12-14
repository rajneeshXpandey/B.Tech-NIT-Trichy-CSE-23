//106119100 Rajneesh Pandey

#include <bits/stdc++.h>

using namespace std;
int f[6], ans, sl, tl, a[6][6];
char s[125005], t[125005];
int find(int x)
{
    return x == f[x] ? x : f[x] = find(f[x]);
}
int main()
{
    cin >> s >> t;
    sl = strlen(s);
    tl = strlen(t);
    for (int i = 0; i <= sl - tl; i++)
    {
        ans = 0;
        for (int j = 0; j < 6; j++)
            f[j] = j;
        for (int j = 0; j < tl; j++)
            a[s[i + j] - 'a'][t[j] - 'a'] = 1;
        for (int j = 0; j < 6; j++)
            for (int k = 0; k < 6; k++)
                if (a[j][k])
                {
                    if (find(j) != find(k))
                        f[find(j)] = find(k), ans++;
                    a[j][k] = 0;
                }
        cout << ans;
    }
    return 0;
}