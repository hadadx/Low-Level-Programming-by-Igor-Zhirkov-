#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include "node.h"
#include "funcs.h"

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