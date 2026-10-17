Node *list_create(int val);
int list_add_front(int val,Node **list);
int list_add_back(int val, Node **list);

int list_get(int index,Node *list);
int list_free(Node **list);
int list_length(Node **list);
Node *list_node_at(Node **list, int index);
int list_sum(Node **list);