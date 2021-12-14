//106119100 Rajneesh Pandey
#include <bits/stdc++.h>
using namespace std;
vector<int> AddParentheses(string input)
{
    vector<int> ans;
    bool pureNum = true;
    for (int i = 0; i < input.length(); i++)
        if (input[i] < '0' || input[i] > '9')
        {
        pureNum = false;
        vector<int> L = AddParentheses(input.substr(0, i));
        vector<int> R = AddParentheses(input.substr(i + 1,input.length()-i-1));
        for (auto l : L)
            for (auto r : R)
                    if (input[i] == '+')
                        ans.push_back(l + r);
                    else if (input[i] == '-')
                        ans.push_back(l - r);
                    else if (input[i] == '*')
                        ans.push_back(l * r);
        }
    if (pureNum)
        ans.push_back(atoi(input.c_str()));
    return ans;
}
int main(){
    string st;cin >> st;
    vector<int> ans;
    ans = AddParentheses(st);
    for (auto x : ans)
        cout << x << " ";
    return 0;
}
