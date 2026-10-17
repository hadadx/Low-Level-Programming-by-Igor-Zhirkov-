Node *list_create(int val);
int list_add_front(int val,Node **list);
int list_add_back(int val, Node **list);

int list_get(int index,Node *list);
int list_free(Node **list);
int list_length(Node **list);
Node *list_node_at(Node **list, int index);
int list_sum(Node **list);


void foreach(Node *list, void (*f)(int));
Node *self_map(Node *list, int (*f)(int));
void map_mut(Node *list,int (*f)(int));
int foldl(Node *list, int (*f)(int x,int a) , int a);
Node *iterate(int s,int n,int (*f)(int));
bool save(Node *lst, const char* filename);
bool load(Node **lst,const char* filename);
bool serialize(Node *lst, const char *filename);
bool deserialize(Node **lst, const char *filename);


void print_with_newline(int x);
void print_with_space(int x);

int squares(int x);
int cubes(int x);
int sum(int a,int b);
int min(int a,int b);
int max(int a,int b);
int abs(int x);
int power_of_two(int x);