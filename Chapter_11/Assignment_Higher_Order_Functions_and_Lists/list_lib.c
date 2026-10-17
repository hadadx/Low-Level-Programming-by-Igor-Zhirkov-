#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include "node.h"
#include "funcs.h"

bool deserialize(Node **lst, const char *filename)
{
    Node *newList = NULL;
    Node *nextNode = NULL;
    int val;
    int flag = 0;
    FILE *f = fopen(filename, "rb");
    if (f == NULL)
    {
        return false;
    }

    while (fread(&val, sizeof(int), 1, f) == 1)
    {
        if (flag == 0)
        {
            newList = malloc(sizeof(Node));
            newList->next = NULL;
            newList->value = val;

            nextNode = newList;
            flag = 1;
        }
        else
        {
            Node *newNode = malloc(sizeof(Node));
            newNode->next = NULL;
            newNode->value = val;

            nextNode->next = newNode;
            nextNode = newNode;
        }
    }

    fclose(f);
    *lst = newList;
    return true;
}

bool serialize(Node *lst, const char *filename)
{
    int val;
    FILE *f = fopen(filename, "wb");
    if (f == NULL)
    {
        return false;
    }

    while (lst)
    {
        val = lst->value;
        fwrite(&val, sizeof(int), 1, f);
        lst = lst->next;
    }

    fclose(f);
    return true;
}

bool load(Node **lst, const char *filename)
{
    Node *newList = NULL;
    Node *nextNode = NULL;
    int x;
    int flag = 0;

    FILE *f = fopen(filename, "r");
    if (f == NULL)
    {
        return false;
    }

    while (fscanf(f, "%d", &x) == 1)
    {
        if (flag == 0)
        {
            newList = malloc(sizeof(Node));
            newList->next = NULL;
            newList->value = x;

            nextNode = newList;
            flag = 1;
        }
        else
        {
            Node *newNode = malloc(sizeof(Node));

            newNode->next = NULL;
            newNode->value = x;

            nextNode->next = newNode;
            nextNode = newNode;
        }
    }
    *lst = newList;
    fclose(f);
    return true;
}

bool save(Node *lst, const char *filename)
{
    FILE *f = fopen(filename, "w");
    if (f == NULL)
    {
        return false;
    }

    while (lst)
    {
        fprintf(f, "%d\n", lst->value);
        lst = lst->next;
    }
    fclose(f);
    return true;
}

Node *iterate(int s, int n, int (*f)(int))
{
    int lastVal = s;
    Node *nextNode = NULL;
    Node *newList = malloc(sizeof(Node));
    newList->next = nextNode;
    newList->value = lastVal;
    nextNode = newList;

    for (size_t i = 1; i <= n; i++)
    {
        Node *newNode = malloc(sizeof(Node));

        lastVal = f(lastVal);

        newNode->value = lastVal;
        newNode->next = NULL;

        nextNode->next = newNode;
        nextNode = newNode;
    }

    return newList;
}

int foldl(Node *list, int (*f)(int x, int a), int a)
{
    int acc = a;

    while (list)
    {
        acc = f(list->value, acc);
        list = list->next;
    }
    return acc;
}

void map_mut(Node *list, int (*f)(int))
{
    while (list)
    {
        list->value = f(list->value);
        list = list->next;
    }
}

Node *self_map(Node *list, int (*f)(int))
{
    Node *newList = NULL;
    Node *nextNode = NULL;
    int flag = 0;

    while (list)
    {
        if (flag == 0)
        {
            Node *newNode = malloc(sizeof(Node));

            newNode->next = NULL;
            newNode->value = f(list->value);

            newList = newNode;
            nextNode = newNode;

            flag = 1;
            list = list->next;
        }
        else
        {
            Node *newNode = malloc(sizeof(Node));

            newNode->next = NULL;
            newNode->value = f(list->value);

            nextNode->next = newNode;
            nextNode = newNode;

            list = list->next;
        }
    }

    return newList;
}

void foreach (Node *list, void (*f)(int))
{
    while (list)
    {
        f(list->value);
        list = list->next;
    }
}

int power_of_two(int x)
{
    return x * 2;
}

int abs(int x)
{
    if (x < 0)
    {
        return ~x;
    }
    else
    {
        return x;
    }
}

int max(int a, int b)
{
    if (a > b)
    {
        return a;
    }
    else
    {
        return b;
    }
}

int min(int a, int b)
{
    if (a < b)
    {
        return a;
    }
    else
    {
        return b;
    }
}

int sum(int a, int b)
{
    return a + b;
}

void print_with_space(int x)
{
    printf("%d ", x);
}

void print_with_newline(int x)
{
    printf("%d\n", x);
}

int squares(int x)
{
    return x * x;
}

int cubes(int x)
{
    return x * x * x;
}

Node *list_create(int val)
{
    Node *new;
    new = malloc(sizeof(Node));

    new->next = 0;
    new->value = val;

    return new;
}

int list_add_front(int val, Node **list)
{
    Node *new = malloc(sizeof(Node));

    if (new == NULL)
    {
        return EXIT_FAILURE;
    }

    new->next = *list;
    new->value = val;

    *list = new;

    return EXIT_SUCCESS;
}

int list_add_back(int val, Node **list)
{
    Node *newNode = malloc(sizeof(Node));

    if (newNode == NULL)
    {
        return EXIT_FAILURE;
    }

    Node *tempNode = *list;

    while (tempNode->next)
    {
        tempNode = tempNode->next;
    }

    newNode->next = 0;
    newNode->value = val;

    tempNode->next = newNode;
}

int list_get(int index, Node *list)
{
    Node *temp = list;

    for (size_t i = 0; i < index; i++)
    {
        if (temp->next == NULL)
        {
            return EXIT_FAILURE;
        }

        temp = temp->next;
    }

    return temp->value;
}

int list_free(Node **list)
{
    Node *listcp = *list;
    while (listcp)
    {
        Node *holdNext = listcp->next;
        free(listcp);
        listcp = holdNext;
    }
    *list = 0;

    return EXIT_SUCCESS;
}

int list_length(Node **list)
{
    Node *tmplist = *list;
    int i = 0;

    while (tmplist)
    {
        tmplist = tmplist->next;
        i++;
    }
    return i;
}

Node *list_node_at(Node **list, int index)
{
    Node *tmplist = *list;
    int i = 0;

    while (tmplist)
    {
        if (i == index)
        {
            return tmplist;
        }

        tmplist = tmplist->next;
        i++;
    }

    return NULL;
}

int list_sum(Node **list)
{
    Node *tmplist = *list;
    int sum = 0;
    while (tmplist)
    {
        sum += tmplist->value;
        tmplist = tmplist->next;
    }

    return sum;
}