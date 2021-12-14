#include <bits/stdc++.h>
using namespace std;

const int ALPHABET_SIZE = 26;

class Trie {

private:
    Trie *next[ALPHABET_SIZE] = {};
    int cnt;
	bool isEndOfWord = false;

public:
	Trie() {
		cnt = 0;
	}

	void insert(string word) {
		Trie* node = this;
		for (char ch : word) {
			ch -= 'a';
			if (!node->next[ch])
				node->next[ch] = new Trie();
			node->cnt++;
			node = node->next[ch];
		}
		node->isEndOfWord = true;
	}

	bool search(string word) {
		Trie* node = this;
		for (char ch : word) {
			ch -= 'a';
			if (!node->next[ch]) { return false; }
			node = node->next[ch];
		}
		return node->isEndOfWord;
	}

	int startsWith(string prefix) {
		Trie* node = this;
		for (char ch : prefix) {
			ch -= 'a';
			if (!node->next[ch]) { return 0; }
			node = node->next[ch];
		}
		return node->cnt;
	}

	bool isEmpty(Trie* root)
	{
		for (int i = 0; i < ALPHABET_SIZE; i++)
			if (root->next[i])
				return false;
		return true;
	}

	Trie* remove(Trie* root, string word, int depth = 0)
	{
		if (!root)
			return NULL;
		if (depth == word.size()) {
			if (root->isEndOfWord)
				root->isEndOfWord = false;
			if (isEmpty(root)) {
				delete (root);
				root = NULL;
			}

			return root;
		}

		int index = word[depth] - 'a';
		root->next[index] = remove(root->next[index], word, depth + 1);

		if (isEmpty(root) && root->isEndOfWord == false) {
			delete (root);
			root = NULL;
		}
		return root;
	}

	void display(Trie* root, char str[], int level = 0)
	{
		if (root->isEndOfWord)
		{
			str[level] = '\0';
			cout << str << endl;
		}
		for (int i = 0; i < ALPHABET_SIZE; i++)
		{
			if (root->next[i])
			{
				str[level] = i + 'a';
				display(root->next[i], str, level + 1);
			}
		}
	}
};

int main()
{
	// lower case only !!
	string keys[] = {"the", "a", "there","answer", "any", "by","bye","their" };
	int n = sizeof(keys) / sizeof(keys[0]);

	Trie* root = new Trie();

	// Construct trie
	for (int i = 0; i < n; i++)
		root->insert(keys[i]);

	const int mxn = 1e2;
	char str[mxn]; // FOR DISPLAY METHOD


	//                         DISPLAY
	cout << "-------------------------\n"; // Clean
	root->display(root, str);
	cout << "-------------------------\n"; // Clean

	//                         SEARCH
    cout<<"Search \n";
	string ask = "the";
	if (root->search(ask))
		cout << "The Word \"" << ask << "\" Exists in Trie.\n";
	else cout << "No, The Word " << ask<<" is not in Trie.\n";
    cout << "\n";

    //                      PREFIX CHECK
    cout << "Prefix Check \n";
    string pref = "ans";
	int num = (root->startsWith(pref));
	cout << "There are " << num << " Word Starting with \"" << pref << "\"." << endl;
    cout << "\n";

    //                         DELETE
    cout << "Delete \n";
    string erase = "the";
	root->remove(root, erase);
	cout << "\""<<erase<<"\" was Removed!\n";
    cout<<"\n";

	//				    TRIE AFTER ALL OPERATIONS
	cout << "-------------------------\n";
	root->display( root, str);
	return 0;
}
