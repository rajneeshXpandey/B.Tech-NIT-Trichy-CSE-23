#include <stdio.h>
#include <stdlib.h>

struct node
{
    int data;
    struct node *next;
};

struct node *getnode(int data)
{
    struct node *temp = (struct node *)malloc(sizeof(struct node));
    temp->data = data;
    temp->next = NULL;

    return temp;
}

struct node *insert(struct node *head, int data)
{
    if (head == NULL)
    {
        return getnode(data);
    }
    struct node *temp = head;

    while (temp->next != NULL)
    {
        temp = temp->next;
    }

    struct node *pnode = getnode(data);
    temp->next = pnode;

    return head;
}

struct node *insert_start(struct node *head, int data)
{
    struct node *pnode = getnode(data);
    pnode->next = head;
    head = pnode;

    return head;
}

struct node *delete (struct node *head, int data)
{
    if (head == NULL)
    {
        return head;
    }

    struct node *temp = head;
    struct node *prev = NULL;

    if (temp != NULL && temp->data == data)
    {
        prev = temp->next;
        free(temp);
        return prev;
    }

    while (temp != NULL && temp->data != data)
    {
        prev = temp;
        temp = temp->next;
    }
    if (temp == NULL)
    {
        return head;
    }
    prev->next = temp->next;
    temp->next = NULL;
    free(temp);

    return head;
}

void printlist(struct node *head)
{
    if (head == NULL)
    {
        printf("List is empty.");
        return;
    }
    while (head != NULL)
    {
        printf("%d ", head->data);
        head = head->next;
    }
}

struct node *search(struct node *head, int data)
{
    if (head == NULL)
    {
        return head;
    }

    struct node *temp = head;
    while (temp != NULL && temp->data != data)
    {
        temp = temp->next;
    }

    return temp;
}

int main()
{
    struct node *head = NULL;
    int choice;
    int data;
    while (1)
    {
        printf("Linked List\n---------------------\n");
        printf("1. Insert\n");
        printf("2. Insert in beginning\n");
        printf("3. Delete a node\n");
        printf("4. Search a node\n");
        printf("5. Print list\n");
        printf("6. Exit\n\n");

        scanf("%d", &choice);

        if (choice == 6)
        {
            break;
        }

        switch (choice)
        {
        case 1:
            printf("Enter data\n");
            scanf("%d", &data);
            head = insert(head, data);
            break;
        case 2:
            printf("Enter data to insert at beginning\n");
            scanf("%d", &data);
            head = insert_start(head, data);
            break;
        case 3:
            printf("Enter data to delete\n");
            scanf("%d", &data);
            head = delete (head, data);
            break;
        case 4:
            printf("Enter data to search\n");
            scanf("%d", &data);
            struct node *searchnode = NULL;
            searchnode = search(head, data);
            if (searchnode != NULL)
            {
                printf("%d data exists in linkedlist.\n\n", data);
            }
            else
            {
                printf("%d data doest not exists in linkedlist.\n\n", data);
            }
            break;
        case 5:
            printlist(head);
            printf("\n\n");
            break;
        default:
            printf("Please enter a valid choice.\n\n");
            break;
        }
    }

    return 0;
}