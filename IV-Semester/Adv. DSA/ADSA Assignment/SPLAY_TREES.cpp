#include<cstdio>
#include<cstdlib>
#include<bits/stdc++.h>
using namespace std;
struct Node{
	Node *l;
	Node *r;
	Node *p;
	int v;
};
Node *root;
void rightRotate(Node *P)
{
	Node *T=P->l;
	Node *B=T->r;
	Node *D=P->p;
	if(D)
	{
		if(D->r==P) D->r=T;
		else D->l=T;
	}
	if(B)
		B->p=P;
	T->p=D;
	T->r=P;

	P->p=T;
	P->l=B;
}
void leftRotate(Node *P)
{
	Node *T=P->r;
	Node *B=T->l;
	Node *D=P->p;
	if(D)
	{
		if(D->r==P) D->r=T;
		else D->l=T;
	}
	if(B)
		B->p=P;
	T->p=D;
	T->l=P;

	P->p=T;
	P->r=B;
}

void Splay(Node *T)
{
	while(true)
	{
		Node *p=T->p;
		if(!p) break;
		Node *pp=p->p;
		if(!pp)//Zig
		{
			if(p->l==T)
				rightRotate(p);
			else
				leftRotate(p);
			break;
		}
		if(pp->l==p)
		{
			if(p->l==T)
			{//ZigZig
				rightRotate(pp);
				rightRotate(p);
			}
			else
			{//ZigZag
				leftRotate(p);
				rightRotate(pp);
			}
		}
		else
		{
			if(p->l==T)
			{//ZigZag
				rightRotate(p);
				leftRotate(pp);
			}
			else
			{//ZigZig
				leftRotate(pp);
				leftRotate(p);
			}
		}
	}
	root=T;
}
void Insert(int v)
{
	if(!root)
	{
		root=(Node *)malloc(sizeof(Node));
		root->l=NULL;
		root->r=NULL;
		root->p=NULL;
		root->v=v;
		return;
	}
	Node *P=root;
	while(true)
	{
		if(P->v==v) break; // not multiset
		if(v < (P->v) )
		{
			if(P->l) P=P->l;
			else
			{
				P->l=(Node *)malloc(sizeof(Node));
				P->l->p=P;
				P->l->r=NULL;
				P->l->l=NULL;
				P->l->v=v;
				P=P->l;
				break;
			}
		}
		else
		{
			if(P->r) P=P->r;
			else
			{
				P->r=(Node *)malloc(sizeof(Node));
				P->r->p=P;
				P->r->r=NULL;
				P->r->l=NULL;
				P->r->v=v;
				P=P->r;
				break;
			}
		}
	}
	Splay(P);
}
void Inorder(Node *R)
{
	if(!R) return;
	Inorder(R->l);
	cout<<"key: "<<R->v;
	if(R->l) cout<<"   | left:  "<<R->l->v;
	if(R->r) cout<<"   | right: "<<R->r->v;
	puts("");
	Inorder(R->r);
}
Node* Find(int v)
{
	if(!root) return NULL;
	Node *P=root;
	while(P)
	{
		if(P->v==v)
			break;
		if(v<(P->v))
		{
			if(P->l)
				P=P->l;
			else
				break;
		}
		else
		{
			if(P->r)
				P=P->r;
			else
				break;
		}
	}
	Splay(P);
	if(P->v==v) return P;
	else return NULL;
}
bool Erase(int v)
{
	Node *N=Find(v);
	if(!N) return false;
	Splay(N); //check once more;
	Node *P=N->l;
	if(!P && !(N->r))
    {
        root=NULL;
        free(N);
        return true;
    }
	if(!P)
	{
		root=N->r;
		root->p=NULL;
		free(N);
		return true;
	}

	while(P->r) P=P->r;
	Splay(P);
	P->r=NULL;
	if(N->r)
	{
		P->r=N->r;
		N->r->p=P;
	}
	root=P;
	root->p=NULL;
	free(N);
	return true;

}
void update(int x,int y)
{
 /*   Node *temp=Find(x);
    if(!temp)
    {
        cout<<"\n\tThe given key is not present in the Tree!";
        return;
    }
    Erase(x);
    Insert(y);*/
    if(!Erase(x))
    {
        cout<<"\nThe element is not found in the tree!";
        return;
    }
    Insert(y);
    return;
}
int main()
{
    root = NULL;
   cout<<"\n\n\t\t\t\t\t\tSPLAY TREES !\n";
  // st.InOrder(root);
   int i, c;
   while(1)
   {
      cout<<"\n";
      cout<<"1. Insert "<<endl;
      cout<<"2. Delete"<<endl;
      cout<<"3. Search"<<endl;
      cout<<"4. Update"<<endl;
      cout<<"5. Splaying"<<endl;
      cout<<"6. Exit"<<endl;
      cout<<"Enter your choice: ";
      cin>>c;
      switch(c)//perform switch operation
      {
         case 1:
            int n;
            cout<<"Enter the number of values to be inserted: ";
            cin>>n;
            for(int j=0;j<n;j++)
            {
                cout<<"Enter the key to be inserted:";
                cin>>i;
                Insert(i);
            }
            cout<<"\nAfter Insertion: \n"<<endl;
            if(root)
            cout<<"root:"<<root->v<<"\n";
            Inorder(root);
            break;
         case 2:
         //   cout<<"Enter the number of values to be deleted: ";
          //  cin>>n;
          //  for(int j=0;j<n;j++)
          //  {
                cout<<"Enter the value to be deleted:";
                cin>>i;
                if(Erase(i))
                    cout<<"\nThe value is deleted !";
                else
                    cout<<"\nThe given key is not found !";
          //  }
            cout<<"\nAfter Deletion:\n"<<endl;
            if(root)
            cout<<"root:"<<root->v<<"\n";
            Inorder(root);
            break;
         case 3:
            cout<<"Enter the number of values to be searched: ";
            cin>>n;
            for(int j=0;j<n;j++)
            {
                cout<<"Enter the value to be searched:";
            cin>>i;
            Node *temp=Find(i);
            if(!temp)
                cout<<"\nThe element is not found!";
            else
                cout<<"\nThe element is found in the tree!";
            cout<<"\nThe splay Tree after searching the key "<<i<<" is:\n";
            if(root)
            cout<<"root:"<<root->v<<"\n";
            Inorder(root);
            }
            break;
         case 4:
            cout<<"\nEnter the number of values to be updated:";
            cin>>n;
            for(int j=0;j<n;j++)
            {
                cout<<"Enter the value to be updated:";
                int key;
                cin>>key;
                int val;
                cout<<"Enter the updated value:";
                cin>>val;
                update(key,val);
                cout<<"\nAfter updating "<<key<<" to "<<val<<"\n";
                if(root)
                cout<<"root:"<<root->v<<"\n";
                Inorder(root);
            }
            break;
         case 5:
            cout<<"\nEnter the number of splaying operations to be performed:";
            cin>>n;
            for(int j=0;j<n;j++)
            {
                cout<<"Enter the value to be splayed:";
                int x;
                cin>>x;
                Find(x);
                cout<<"\nAfter performing splaying operation on "<<x<<":\n";
                if(root)
                cout<<"root:"<<root->v<<"\n";
                Inorder(root);
            }
            break;
         case 6:
            exit(1);
         default:
            cout<<"\nInvalid type! \n";
      }
   }
   cout<<"\n";
}
